"use client";
import { ConnectButton, darkTheme, useActiveAccount } from "thirdweb/react";
import { sepolia, localhost, hardhat } from "thirdweb/chains";
import { createWallet } from "thirdweb/wallets";
import Image from "next/image";
import client from "./thirdweb/Client";

const wallets = [
    createWallet('io.metamask'),
    createWallet('us.binance'),
    createWallet("com.coinbase.wallet"),
    createWallet("me.rainbow"),
    createWallet("io.rabby"),
    createWallet("io.zerion.wallet"),
]

export default function Navbar() {

    const account = useActiveAccount();

    return(
        <nav className="w-full min-h-[4rem] px-[2rem] shadow-sm flex">
            <div className="flex flex-1 justify-start items-center">
                <Image alt="Logo" src={'/logo.png'} width={120} height={120}/>
            </div>
            <div className="flex flex-1 justify-center  items-center space-x-8">
                <a href="/">Collections</a>
                <a href="/about">About us</a>
            </div>
            <div className="flex flex-1 justify-end  items-center space-x-8">
                {account && 
                (
                    <a href="/my-collections">My collections</a>
                )}
                <ConnectButton 
                wallets={wallets}
                connectModal={{size: 'wide'}}
                theme={darkTheme}
                client={client}
                chains={[sepolia, hardhat]}
                />
            </div>
        </nav>
    );
}