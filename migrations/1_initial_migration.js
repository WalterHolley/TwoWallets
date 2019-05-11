const Migrations = artifacts.require("Migrations");
const TwoWallets = artifacts.require("twoWallets");
module.exports = function(deployer, network, accounts) {
  deployer.deploy(Migrations);
  deployer.deploy(TwoWallets);
};
