import localFont from "next/font/local";
import "./globals.css";
import { ThirdwebProvider } from 'thirdweb/react';
import Navbar from "@/components/Navbar";
import PaddingWrapper from "@/components/layout/PaddingWraper";

const geistSans = localFont({
  src: "./fonts/GeistVF.woff",
  variable: "--font-geist-sans",
  weight: "100 900",
});
const geistMono = localFont({
  src: "./fonts/GeistMonoVF.woff",
  variable: "--font-geist-mono",
  weight: "100 900",
});

export const metadata = {
  title: "Marketplace",
  description: "Marketplace for selling and buying NFTs",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <ThirdwebProvider>
          <Navbar />
            <PaddingWrapper>
              {children}
            </PaddingWrapper>
        </ThirdwebProvider>
      </body>
    </html>
  );
}
