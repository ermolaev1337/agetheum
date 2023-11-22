const { expect } = require("chai");
const hre = require("hardhat");

describe("Minting the token and returning it", function () {
    it("should the contract be able to mint a function and return it", async function () {
        const metadata = "https://opensea-creatures-api.herokuapp.com/api/creature/1"; // Random metadata URL

        // Deploy the contract. Ensure that the FactoryNFT contract is correctly written and can be deployed
        const FactoryNFTContract = await ethers.getContractFactory("FactoryNFT");
        const factoryNFT = await FactoryNFTContract.deploy();

        // Mint the token and wait for the transaction to complete
        const transaction = await factoryNFT.createToken(metadata); // Minting the token
        const tx = await transaction.wait(); // Waiting for the token to be minted

        // Extract the token ID from the transaction event
        const event = tx.events[0];
        const value = event.args[2];
        const tokenId = value.toNumber(); // Getting the tokenID

        // Retrieve the token URI and compare it with the metadata
        const tokenURI = await factoryNFT.tokenURI(tokenId); // Using the tokenURI from ERC721 to retrieve the metadata
        expect(tokenURI).to.be.equal(metadata); // Comparing and testing
    });
});
