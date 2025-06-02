const SimpleWallet = artifacts.require("SimpleWallet");

module.exports = function (deployer) {
  // Deploy the SimpleWallet
  deployer.deploy(SimpleWallet)
    .then(() => {
      console.log("SimpleWallet contract deployed successfully.");
    })
    .catch(error => {
      console.error("Error deploying SimpleWallet contract:", error);
    });
}