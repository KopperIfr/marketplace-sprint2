import Image from "next/image";
import NFTCollection from "@/components/NFTCollection";

const collections = [{id: 1}, {id: 2}, {id: 3}, {id: 4}, {id: 5}, {id: 6},]

export default function Home() {
  return (
    <div className="w-full pt-[5rem] grid grid-cols-3 gap-4">
        {  
          collections.map((item) => (
            <NFTCollection key={item.id} />
          ))
        }
    </div>
  );
}
