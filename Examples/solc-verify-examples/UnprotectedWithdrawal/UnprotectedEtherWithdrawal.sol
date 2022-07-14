// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

import "./Ownable.sol";

contract Wallet is Ownable{

    uint balance;

    
    constructor() payable {
        require(balance == 0);

        balance += msg.value;
    }

    function deposit() public payable{
        require(msg.value > 0, "You should send some ether to deposit.");

        balance += msg.value;
    }

    /// @notice postcondition msg.sender == owner()
    function protectedWithdraw(uint amount) public onlyOwner{
        require(amount > 0);
        require(amount <= balance, "No funds to withdraw that amount.");

        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    /// @notice postcondition msg.sender == owner()
    function unProtectedWithdraw(uint amount) public {
        require(amount > 0);
        require(amount <= balance, "No funds to withdraw that amount.");

        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

}