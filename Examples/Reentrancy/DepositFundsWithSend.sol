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

        bool sent = payable(msg.sender).send(bal); //2300 gas limit, returns false if transfer fails
        require(sent, "An error occured");

        balances[msg.sender] = 0;
    }
}
