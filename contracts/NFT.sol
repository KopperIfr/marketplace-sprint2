// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721, Ownable {

    uint256 tokenCounter;
    mapping(uint256 => string) private _tokenURIs;

    event NFTCreated(uint256 indexed tokenId, address indexed collectionAddress, address indexed owner);
    event NFTDeleted(uint256 indexed tokenId, address indexed owner);

    constructor(string memory name, string memory symbol) ERC721(name, symbol) Ownable(msg.sender) {
        tokenCounter = 0;
    }   

    function mint(address to /*string memory tokenURI*/) external onlyOwner {
        _safeMint(to, tokenCounter);
        //_setTokenURI(tokenCounter, 'tokenUri');
        emit NFTCreated(tokenCounter, address(this), msg.sender);
        tokenCounter++;
    }

    function deleteNFT(uint256 tokenId) external onlyOwner {
        _burn(tokenId);
        emit NFTDeleted(tokenId, msg.sender);
    }

    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
        ownerOf(tokenId);
        _tokenURIs[tokenId] = tokenURI;
    }

}