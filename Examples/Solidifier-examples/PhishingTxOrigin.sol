pragma solidity ^0.5.17;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}
contract Wallet {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    function transfer(address payable _to, uint _amount) public payable{
        Verification.Assume(tx.origin == owner);
        //require(tx.origin == owner, "Not owner");
        //require(msg.sender == owner, "Not owner");

        _to.transfer(_amount);
       
        Verification.Assert(msg.sender == owner);
    }
}

