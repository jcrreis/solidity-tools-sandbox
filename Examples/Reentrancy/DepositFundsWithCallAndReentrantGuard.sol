// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;


import "./ReentrancyGuard.sol";


contract DepositFunds is ReentrancyGuard{
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public nonReentrant{
        uint bal = balances[msg.sender];
        require(bal > 0);
        
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: bal}(""); //235099 gas used
        require(sent, "Failed to send Ether");
    }
}