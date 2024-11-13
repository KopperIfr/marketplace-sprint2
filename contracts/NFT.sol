// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721, Ownable {

    uint256 tokenCounter;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) Ownable(msg.sender) {
        tokenCounter = 0;
    }   

    function mint(address to) external onlyOwner {
        _safeMint(to, tokenCounter);
        tokenCounter++;
    }

    function deleteNFT(uint256 tokenId) external onlyOwner {
        _burn(tokenId);
    }

}