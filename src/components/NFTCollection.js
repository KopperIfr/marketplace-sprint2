import { getContract, readContract } from "thirdweb"



export default function NFTCollection() {

    const collectionContract = getContract(process.env.NEXT_PUBLIC_COLLECTION_CONTRACT);
    

    return(
        <div className="w-full bg-black h-[15rem] rounded-sm mt-[1rem]">
            <div className="">

            </div>
            <div className="">

            </div>
        </div>
    )
}