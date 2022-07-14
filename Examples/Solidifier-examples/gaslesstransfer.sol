pragma solidity ^0.5.17;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract C {

   
    constructor() public {

    }

    function pay(uint n, D1 d) public payable {
        
        uint old_balance = address(this).balance;

        address d1 = address(d);
        //payable(d1).send(n);
        (bool sent, ) = d1.call{value: n}("");
        require(sent);

       
        uint actual_balance = address(this).balance;
        assert(actual_balance == old_balance - n);
    }

    function balance() public view returns (uint){
        return address(this).balance;
    }
}

contract D1 {
        uint public count = 0;
        fallback() external payable{ count++; }

        function balance() public view returns (uint){
        return address(this).balance;
    }

}

contract D2 { 
    
    fallback() external payable{}  
    function balance() public view returns (uint){
        return address(this).balance;
    }
}