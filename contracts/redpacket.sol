// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AssignRedPacket {
    address payable owner;
    uint256 public totalAmount;
    uint256 public count;
    bool isEqual;
    mapping(address => bool) isGrabbed;

    constructor(uint256 _count, bool _isEqual) {
        owner = payable(msg.sender);
        count = _count;
        isEqual = _isEqual;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    function deposit() public payable {
        require(msg.value>0,"not enough");
        totalAmount += msg.value;
    }
    function withdraw() public payable {
        require(msg.sender==owner,'not the owner');
        require(totalAmount>0,"not enough");
        totalAmount = 0;
        payable(owner).transfer(address(this).balance);
    }
    function grabRedPacket() public payable {
        require(totalAmount > 0, "not enough");
        require(count > 0, "no redpackets left");
        require(!isGrabbed[msg.sender], "already grab it!");
        isGrabbed[msg.sender] = true;
        if (count == 1) {
            payable(msg.sender).transfer(totalAmount);
        } else {
            if (isEqual) {
                uint256 amount = totalAmount / count;
                totalAmount -= amount;
                payable(msg.sender).transfer(amount);
            } else {
                uint256 random = (uint256(
                    keccak256(
                        abi.encodePacked(
                            msg.sender,
                            owner,
                            count,
                            totalAmount,
                            block.timestamp
                        )
                    )
                ) % 8) + 1;
                uint256 amount = (totalAmount * random) / 10;
                totalAmount -= amount;
                payable(msg.sender).transfer(amount);
            }
        }
        count--;
    }
}