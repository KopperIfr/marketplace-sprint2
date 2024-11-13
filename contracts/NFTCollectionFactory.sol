// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./NFT.sol";

contract NFTCollectionFactory {

    mapping(address => address[]) userCollections;

    event CollectionCreated(address indexed owner, address collectionAddress);

    function createCollection(
        string memory name, 
        string memory symbol) external 
    {
        NFT nftCollection = new NFT(name, symbol);
        nftCollection.transferOwnership(msg.sender);
        userCollections[msg.sender].push(address(nftCollection));
        emit CollectionCreated(msg.sender, address(nftCollection));
    }


    function deleteCollection(uint256 collectionIndex) external {
        delete userCollections[msg.sender][collectionIndex];
    }

    function getCollectionsByUser(address user) external view returns (address[] memory) {
        return userCollections[user];
    }
}