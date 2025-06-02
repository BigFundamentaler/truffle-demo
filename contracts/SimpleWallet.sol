// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    // 记录每个地址的余额
    mapping(address => uint256) private balances;
    
    // 事件：记录充值
    event Deposit(address indexed user, uint256 amount);
    
    // 事件：记录提现
    event Withdraw(address indexed user, uint256 amount);
    
    // 事件：记录转账
    event Transfer(address indexed from, address indexed to, uint256 amount, string message);
    
    // 充值功能 - 向合约发送ETH
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    
    // 提现功能 - 从合约提取ETH
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
    
    // 转账功能 - 带消息的转账
    function transfer(address to, uint256 amount, string memory message) public {
        require(to != address(0), "Invalid recipient address");
        require(amount > 0, "Transfer amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount, message);
    }
    
    // 查询余额
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
    
    // 查询自己的余额
    function getMyBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
    
    // 接收ETH的回调函数
    receive() external payable {
        deposit();
    }
}