pragma solidity ^0.5.17;


library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract DepositFunds {

    mapping(address => uint) balances;

    constructor() public {
    }

    function deposit() public payable {
        uint bal = balances[msg.sender];
        balances[msg.sender] = bal + msg.value;

        uint final_balance = balances[msg.sender];
        assert(bal == final_balance - msg.value);
       
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        Verification.CexPrinti(bal);
        Verification.Assume(bal > 0);
        
        uint old_balance = address(this).balance;

        //(bool sent, ) = msg.sender.call.value(bal); //235099 gas used
        //require(sent, "Failed to send Ether");
        msg.sender.transfer(bal);
        balances[msg.sender] = 0;

        /*
            SMTChecker can't prove this assertion, it stays stuck in perhaps an 
            infinite loop?
        */
        uint final_balance = address(this).balance;
        Verification.CexPrinti(final_balance);
        Verification.Assert(old_balance == final_balance + bal);
    }
}

