pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract FactoryNFT is ERC721URIStorage {

    uint256 private _tokenIdCounter;

    constructor() ERC721("Factory NFT", "FTN") {

    }

    function createToken(string memory tokenURI) public returns (uint) {
        _mint(msg.sender, _tokenIdCounter);
        _setTokenURI(_tokenIdCounter, tokenURI);

        return _tokenIdCounter++;
    }
}