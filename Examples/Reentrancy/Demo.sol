// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;

contract Ownership{  // It can have an owner!
        address owner = msg.sender;
        function Owner() public{
                owner = msg.sender;
        }
        modifier isOwner(){
                require(owner == msg.sender);
                _;
        }
}
contract Pausable is Ownership{ //It is also pausable. You can pause it. You can resume it.
    bool is_paused;
    modifier ifNotPaused(){
        require(!is_paused);
        _;
    }
    function paused() isOwner public{
        is_paused = true;
    }
    function resume() isOwner public{
        is_paused = false;
    }
}
contract Token is Pausable{ //<< HERE it is.
    mapping(address => uint) public balances; // It maintains a balance sheet
    function transfer(address to, uint value) ifNotPaused public{  //and can transfer value
        balances[msg.sender] -= value; // from one account
        balances[to] += value;         // to the other
    }
}


contract TestToken is Token{
        constructor() {
                //here lets initialize the thing
                balances[msg.sender] = 10000; //deployer account owns it all!
        }

        function crytic_test_balance() view public returns (bool){
                return balances[msg.sender] >= 10000; //nobody can have more than 100% of the tokens
        }

        // function crytic_test_owner() view public returns (bool){
        //     return owner == msg.sender;
        // }

        // function teste() pure public returns (bool) {
        //     return true;
        // }

}
//https://asciinema.org/a/xd0XYe6EqHCibae0RP6c7sJVE
//manticore-verifier Demo.sol --contract TestToken
