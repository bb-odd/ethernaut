const { ethers } = require("hardhat");

const networkConfig = {
  5: {
    name: "Goerli",
  },
  31337: {
    name: "hardhat",
  },
};

const developmentChains = ["hardhat", "localhost"];

module.exports = {
  networkConfig,
  developmentChains,
};
