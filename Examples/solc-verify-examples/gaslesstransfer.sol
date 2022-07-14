// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract C {
    
    constructor() payable {

    }


    /// @notice postcondition address(this).balance == __verifier_old_uint(address(this).balance) - n
    function pay(uint n, D2 d) public payable {
        //bool succ = d.send(n);
        //return succ;

        address d1 = address(d);
        payable(d1).transfer(n);
        //(bool ok, ) = d1.call{value: n}("");
        //if (!ok) revert("");

        
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