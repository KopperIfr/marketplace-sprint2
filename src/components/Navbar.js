"use client";
import { ConnectButton, darkTheme, useActiveAccount } from "thirdweb/react";
import { createWallet } from "thirdweb/wallets";

const wallets = [
    createWallet('io.metamask'),
    createWallet('us.binance'),

]

export default function Navbar() {
    <nav className="w-full min-h-[4rem] px-[2rem] shadow-sm">
        <div>
            
        </div>
        <a href="/">Collections</a>
        <a href="/about">About us</a>
    </nav>
}