// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./NFT.sol";
import "./NFTCollectionFactory.sol";
import '@openzeppelin/contracts/token/ERC721/IERC721.sol';
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Marketplace is ReentrancyGuard, Ownable(msg.sender) {
    
    // List, Sell
    event NFTListed(uint256 indexed tokenId, address indexed owner, uint256 indexed price);
    event NFTPurchased(uint256 indexed tokenId, address indexed owner, address indexed buyer, uint256 price);
    event NFTUnlisted(uint256 indexed tokenId, address indexed owner);

    struct Listing {
        address seller;
        uint256 tokenId;
        uint256 price;
    }

    Listing[] public listingsArray;
    mapping (address => mapping (uint256 => Listing)) listings;

    function listNFT(address nftAddress, uint256 tokenId, uint256 price) external {
        IERC721 collection = IERC721(nftAddress);
        require(collection.ownerOf(tokenId) == msg.sender, 'Not the NFT owner');
        require(price > 0, 'Price must be greater that 0');
        collection.transferFrom(msg.sender, address(this), tokenId);
        listings[nftAddress][tokenId] = Listing(msg.sender, tokenId, price);
        listingsArray.push(Listing(msg.sender, tokenId, price));
        emit NFTListed(tokenId, msg.sender, price);
    }

    function buyNFT(address nftAddress, uint256 tokenId, uint listingIndex) external payable {
        Listing memory listing = listings[nftAddress][tokenId];
        require(listing.price == msg.value, 'Incorrect ETH amount!');
        delete listings[nftAddress][tokenId];
        delete listingsArray[listingIndex];
        payable(listing.seller).transfer(msg.value);
        IERC721(nftAddress).transferFrom(address(this), msg.sender, tokenId);
        emit NFTPurchased(tokenId, listing.seller, msg.sender, listing.price);
    }

    function unlistNFT(address nftAddress, uint256 tokenId, uint listingIndex) external {
        IERC721 collection = IERC721(nftAddress);
        require(collection.ownerOf(tokenId) == msg.sender, 'Not owner of NFT');
        delete listings[nftAddress][tokenId];
        delete listingsArray[listingIndex];
        collection.transferFrom(address(this), msg.sender, tokenId);
        emit NFTUnlisted(tokenId, msg.sender);
    }

}