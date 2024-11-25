const { network, run } = require('hardhat');
const fs = require('fs');

module.exports = async ({getNamedAccounts, deployments}) => {

    const { deploy, log } = deployments;
    const { deployer } = await getNamedAccounts();

    // Deploying Marketplace..
    const Marketplace = await deploy('Marketplace', {
        from: deployer,
        args: [],
        log: true
    })

    // Deploying NFTCollectionFactory..
    const NFTCollectionFactory = await deploy('NFTCollectionFactory', {
        from: deployer,
        args: [],
        log: true
    })

    if(network.name !== 'sepolia' || network.name !== 'baseSepolia') {
        fs.writeFileSync('./src/constants/constants.js', `const NFTCollectionFactoryAddress = "${NFTCollectionFactory.address}"; \nconst Marketplace = "${Marketplace.address}";`);
    }

}