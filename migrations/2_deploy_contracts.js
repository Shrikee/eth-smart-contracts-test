const Shops = artifacts.require("./Shops.sol");

module.exports = function (deployer) {
    deployer.deploy(Shops);
};