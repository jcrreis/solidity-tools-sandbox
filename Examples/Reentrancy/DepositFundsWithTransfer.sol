// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;


contract DepositFunds {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        payable(msg.sender).transfer(bal); //2300 gas limit, throws error and reverts if transfer fails

        balances[msg.sender] = 0;
    }
}

