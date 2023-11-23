pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


contract FactoryNFT is AccessControl, ERC721URIStorage {
    uint256 private _tokenIdCounter;

//  Role-based access control
    bytes32 public constant FARMER_ROLE = keccak256("FARMER_ROLE");
    bytes32 public constant CERTIFIER_ROLE = keccak256("CERTIFIER_ROLE");

    constructor() ERC721("Agricultural Certification Token", "ACT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AccessControl, ERC721URIStorage) returns (bool){
        return super.supportsInterface(interfaceId);
    }

    function grantFarmerRole(address _address) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(FARMER_ROLE, _address);
    }

    function grantCertifierRole(address _address) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(CERTIFIER_ROLE, _address);
    }

    mapping(address => string) public addressToTokenURI;//TODO deal with array of tokenURIs for each address (farmer)

    function requestCertification(string memory tokenURI) public onlyRole(FARMER_ROLE) {
        addressToTokenURI[msg.sender] = tokenURI;
    }

    function approveCertification(address farmerAddress) public onlyRole(CERTIFIER_ROLE) returns (uint) {//TODO reentrancy guard
        uint _tokenCounter = createToken(farmerAddress, addressToTokenURI[farmerAddress]);
        delete addressToTokenURI[farmerAddress];

        return _tokenCounter;
    }

    function createToken(address _holder, string memory tokenURI) private returns (uint) {
        _mint(_holder, _tokenIdCounter);
        _setTokenURI(_tokenIdCounter, tokenURI);

        return ++_tokenIdCounter;
    }
}