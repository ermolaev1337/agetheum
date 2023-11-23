const {expect} = require("chai");
const hre = require("hardhat");
// const {
//     loadFixture,
// } = require("@nomicfoundation/hardhat-toolbox/network-helpers");


describe("FactoryNFT", function () {
    const deployContract = async () => {
        const [_owner, _farmer, _certifier] = await ethers.getSigners();

        const FactoryNFTContract = await ethers.getContractFactory("FactoryNFT");
        const factoryNFT = await FactoryNFTContract.deploy();

        const tx1 = await factoryNFT.connect(_owner).grantFarmerRole(_farmer.address);
        await tx1.wait();

        const tx2 = await factoryNFT.connect(_owner).grantCertifierRole(_certifier.address);
        await tx2.wait();

        return [factoryNFT, _owner, _farmer, _certifier]
    }


    describe("Request and receive certification", async () => {

        it("farmer should request certification, certifier should confirm it", async () => {

            const metadata = JSON.stringify({
                "description": "Farmer ACT",
                "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Vehn%C3%A4pelto_6.jpg/1599px-Vehn%C3%A4pelto_6.jpg",
                "name": "Wheat",
                "attributes": [
                    {name: "Composts and Weed Suppressants", value: ["Original Potting Plus Mix", "Vegro Seed Mix"]},
                    {name: "Fertilisers", value: ["Meadowsalt", "EPSO Combitop", "Zinc"]},
                    {name: "Microorganisms", value: ["SlurryBugs Shift It", "Nutri-Life Tricho-Shield"]},
                    {name: "Supplements", value: ["P870 Tracesure Lamb"]},
                ]
            })

            const [factoryNFT, owner, farmer, certifier] = await deployContract();

            const requestCertificationTx = await factoryNFT.connect(farmer).requestCertification(metadata);
            await requestCertificationTx.wait();

            const dictBefore = await factoryNFT.connect(farmer).addressToTokenURI(farmer.address)
            expect(metadata).to.be.equal(dictBefore);

            const approveCertificationTx = await factoryNFT.connect(certifier).approveCertification(farmer.address);
            const approveCertificationTxMined = await approveCertificationTx.wait();
            // console.debug("approveCertificationTx", approveCertificationTx)
            // expect(approveCertificationTx).to.be.equal(1)

            const dictAfter = await factoryNFT.connect(farmer).addressToTokenURI(farmer.address)
            expect("").to.be.equal(dictAfter);

            // // Extract the token ID from the transaction event
            const event = approveCertificationTxMined.events[0];
            const value = event.args[2];
            const tokenId = value.toNumber(); // Getting the tokenID

            // Retrieve the token URI and compare it with the metadata
            const tokenURI = await factoryNFT.tokenURI(tokenId); // Using the tokenURI from ERC721 to retrieve the metadata
            expect(tokenURI).to.be.equal(metadata); // Comparing and testing

        });
    });
});

