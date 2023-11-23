pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract FactoryNFT is AccessControl, ERC721URIStorage {

    constructor() ERC721("Agricultural Certification Token", "ACT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AccessControl, ERC721URIStorage) returns (bool){
        return super.supportsInterface(interfaceId);
    }

    // ON-BOARDING
    mapping(address => bytes32) public addressToRoleOnboardingRequests;//TODO reentrancy
    bytes32 public constant ACTOR_ROLE = keccak256("ACTOR_ROLE");
    bytes32 public constant CERTIFIER_ROLE = keccak256("CERTIFIER_ROLE");

    function requestActorRole() public {//TODO revert, if address is already in the map
        addressToRoleOnboardingRequests[msg.sender] = ACTOR_ROLE;
    }

    function requestCertifierRole() public {//TODO revert, if address is already in the map
        addressToRoleOnboardingRequests[msg.sender] = CERTIFIER_ROLE;
    }

    function approveRole(address _requesterAddress) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(addressToRoleOnboardingRequests[_requesterAddress], _requesterAddress);
        delete addressToRoleOnboardingRequests[_requesterAddress];
    }

    // CERTIFICATION REQUEST
    mapping(address => string) public addressToMetadataCertificationRequests;//TODO reentrancy

    function requestCertification(string memory _metadata) public onlyRole(ACTOR_ROLE) {//TODO implement array of metadata for each actors
        addressToMetadataCertificationRequests[msg.sender] = _metadata;
    }

    function approveCertification(address _actorAddress) public onlyRole(CERTIFIER_ROLE) returns (uint) {//TODO reentrancy guard
        uint _tokenCounter = createToken(_actorAddress, addressToMetadataCertificationRequests[_actorAddress]);
        delete addressToMetadataCertificationRequests[_actorAddress];

        return _tokenCounter;
    }


    // TOKEN MINTING
    uint256 private _tokenIdCounter;

    function createToken(address _holder, string memory tokenURI) private returns (uint) {
        _mint(_holder, _tokenIdCounter);
        _setTokenURI(_tokenIdCounter, tokenURI);

        return ++_tokenIdCounter;
    }
}