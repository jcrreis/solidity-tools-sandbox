//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./ReentrancyGuard.sol";

/// @notice invariant __verifier_sum_uint(balances) <= address(this).balance
contract Reentrancy is ReentrancyGuard{

    mapping(address =>  uint) balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insuficient Funds");
        
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        
        //payable(msg.sender).send(amount);

        //(bool ok, ) = msg.sender.call{value: amount}("");
        //if (!ok) revert("");


    }
}



//on selfdestruct this can receive ether, so <= instead ==
