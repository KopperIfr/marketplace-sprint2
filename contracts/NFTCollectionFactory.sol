// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27;

import "./NFT.sol";

contract NFTCollectionFactory {

    mapping(address => address[]) userCollections;
    address[] public userAddresses;

    struct CollectionsInfo {
        address owner;
        address collection;
    }

    event CollectionCreated(address indexed owner, address collectionAddress);

    function createCollection(
        string memory name, 
        string memory symbol) external 
    {
        bool hasCollection = false;
        NFT nftCollection = new NFT(name, symbol);
        nftCollection.transferOwnership(msg.sender);
        userCollections[msg.sender].push(address(nftCollection));
        for (uint256 i = 0; i < userAddresses.length; i++) 
        {
            if(userAddresses[i] == msg.sender) hasCollection = true;
        }
        if(!hasCollection) userAddresses.push(msg.sender);
        emit CollectionCreated(msg.sender, address(nftCollection));
    }


    function deleteCollection(uint256 collectionIndex) external {
        delete userCollections[msg.sender][collectionIndex];
    }

    function getCollectionsByUser(address user) external view returns (address[] memory) {
        return userCollections[user];
    }

function getAllCollections() external view returns (CollectionsInfo[] memory) {
    uint totalCollections;

    // Contar el número total de colecciones
    for (uint i = 0; i < userAddresses.length; i++) {
        totalCollections += userCollections[userAddresses[i]].length;
    }

    // Crear un array para almacenar la información de las colecciones
    CollectionsInfo[] memory allCollections = new CollectionsInfo[](totalCollections);

    uint currentIndex = 0;

    // Agregar la información de las colecciones al array
    for (uint i = 0; i < userAddresses.length; i++) {
        address[] memory collections = userCollections[userAddresses[i]];
        for (uint j = 0; j < collections.length; j++) {
            allCollections[currentIndex] = CollectionsInfo({
                owner: userAddresses[i],
                collection: collections[j]
            });
            currentIndex++;
        }
    }

    return allCollections;
}

    function getUserAddressesWithCollections() external view returns (address[] memory) {
        return userAddresses;
    }
}