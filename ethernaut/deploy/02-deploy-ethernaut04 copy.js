const { deployments, network, ethers } = require("hardhat");
const { developmentChains, networkConfig } = require("../helper-hardhat-config");
const { verify } = require("../utils/verify");

module.exports = async function ({ getNamedAccounts, deployment }) {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = network.config.chainId;
  const rpc = process.env.GOERLI_RPC_URL;
  const provider = new ethers.providers.JsonRpcProvider(rpc);
  const signer = provider.getSigner();

  const ethernaut = await deploy("Ethernaut04", {
    from: deployer,
    log: true,
    waitConfirmations: network.config.blockConfirmations || 1,
  });

  const contractInstance = new ethers.Contract(ethernaut.address, ethernaut.abi, signer);
  contractInstance.hack();

  if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
    log("Verifying...");
    await verify(ethernaut.address);
  }
  log("-----------------------------------------");
};

module.exports.tags = ["all", "telephone"];
