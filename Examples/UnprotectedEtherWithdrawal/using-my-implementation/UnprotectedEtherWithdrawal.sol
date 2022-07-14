// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.11;


contract Wallet {

    uint balance;
    address owner;

    constructor() payable {
        require(balance == 0);

        owner = msg.sender;
        balance += msg.value;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function deposit() public payable{
        require(msg.value > 0, "You should send some ether to deposit.");

        balance += msg.value;
    }
    /*
        Mythril cannot handle modifiers!
    */ 
    function protectedWithdraw(uint amount) public onlyOwner{
        require(amount > 0);
        require(amount <= balance, "No funds to withdraw that amount.");

        assert(msg.sender == owner);

        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    /*
        Mythril gives a ==== Unprotected Ether Withdrawal ==== in both methods
        Slither only works if we implement our own onlyOwner modifier...
        SMTChecker and solc-verfiy are definetely the best
     */
    function unProtectedWithdraw(uint amount) public {
        require(amount > 0);
        require(amount <= balance, "No funds to withdraw that amount.");

        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

}