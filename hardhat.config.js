/** @type import('hardhat/config').HardhatUserConfig */
require('hardhat-deploy');
require('@nomiclabs/hardhat-ethers');
require('dotenv').config();
module.exports = {
  solidity: "0.8.27",
  defaultNetwork: 'hardhat',
  networks: {
      // sepolia: {
      //     url: process.env.SEPOLIA_RPC_URL,
      //     accounts: [process.env.PRIVATE_API_KEY],
      //     chainId: 11155111
      // },
      localhost: {
          url: "http://127.0.0.1:8545",
          chainId: 31337
      }
  },
  namedAccounts: {
      deployer: {
          default: 0
      }
  },
  etherscan: {
      enabled: true,
      apiKey: {
          sepolia: process.env.ETHERSCAN_API_KEY
      }
  }
};
