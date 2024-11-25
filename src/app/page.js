"use client";
import Image from "next/image";
import NFTCollection from "@/components/NFTCollection";
import { getContract } from "thirdweb";
import { useReadContract } from "thirdweb/react";
import { sepolia, hardhat, localhost } from "thirdweb/chains";
import client from "@/components/thirdweb/Client";
import { NFTCollectionFactoryAddress, Marketplace } from "@/constants/constants";
//const collections = [{id: 1}, {id: 2}, {id: 3}, {id: 4}, {id: 5}, {id: 6},]

export default function Home() {

  const NFTCollectionContract = getContract({
    chain: sepolia,
    client: client,
    address: NFTCollectionFactoryAddress
  });


  const {data: collections, isLoading: isLoadingCollections, refetch: refetchCollections} = useReadContract({
    contract: NFTCollectionContract,
    method: "function getAllCollections() external view returns (CollectionsInfo[] memory)",
    params: []
  })

  console.log(isLoadingCollections);
  console.log(collections);

  return (
    <div className="w-full pt-[5rem]">
      {
        isLoadingCollections && (
          <p>No collections</p>
        )
      }
      {!isLoadingCollections && collections && (
        collections.length > 0 ? (
          collections.map((collection, index) => (
            <NFTCollection key={index} />
          ))
        ) : (
          <p>No collections</p>
        )
      )}
    </div>
  );
}


/*<div className="w-full pt-[5rem] grid grid-cols-3 gap-4">
    {  
      collections.map((item) => (
        <NFTCollection key={item.id} />
      ))
    }
</div>*/