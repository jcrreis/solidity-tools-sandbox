// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;

contract DepositFunds {

    mapping(address => uint) public balances;

    constructor() {
    }

    function deposit() public payable {
        uint bal = balances[msg.sender];
        balances[msg.sender] = bal + msg.value;

        uint final_balance = balances[msg.sender];
        assert(bal == final_balance - msg.value);
       
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        uint old_balance = address(this).balance;

        (bool sent, ) = msg.sender.call{value: bal}(""); //235099 gas used
        require(sent, "Failed to send Ether");
        balances[msg.sender] = 0;

        /*
            SMTChecker can't prove this assertion, it stays stuck in perhaps an 
            infinite loop?
        */
        uint final_balance = address(this).balance;
        assert(old_balance == final_balance + bal);
    }
}



contract Reentrancy {

    mapping(address => uint) public balances;

    constructor() {
    }

    function deposit() public payable {
        uint bal = balances[msg.sender];
        balances[msg.sender] = bal + msg.value;

        uint final_balance = balances[msg.sender];
        assert(bal == final_balance - msg.value);
       
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool sent, ) = msg.sender.call{value: bal}(""); //235099 gas used
        require(sent, "Failed to send Ether");
        balances[msg.sender] = 0;
    }
}

