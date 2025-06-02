const AssignRedPacket = artifacts.require("AssignRedPacket");

module.exports = function (deployer) {
  // Deploy the AssignRedPacket
  const packetCounts = 5;
  const isEqualPacket = false;
  deployer.deploy(AssignRedPacket,packetCounts, isEqualPacket)
    .then(() => {
      console.log("AssignRedPacket contract deployed successfully.");
    })
    .catch(error => {
      console.error("Error deploying AssignRedPacket contract:", error);
    });
}