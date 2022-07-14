//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @notice invariant total == __verifier_sum_uint(balances)
contract Token {

    uint total;

    mapping(address =>  uint) balances;

    constructor() {
        total = 1000000;
        balances[msg.sender] = total;
    }


    /// @notice postcondition balances[msg.sender] == __verifier_old_uint(balances[msg.sender]) - amount
    /// @notice postcondition balances[to] == __verifier_old_uint(balances[to]) + amount
    function transfer(address payable to, uint amount) public {
        require(to != payable(msg.sender)); //"Self transfer"
        require(balances[msg.sender] >= amount); //"Insuficient balance"

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}