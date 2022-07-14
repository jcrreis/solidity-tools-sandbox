// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
// encontrar contratos reais que usem estas expressões
contract D1 {
        uint public count = 0;
        fallback() external payable{ count++; }

        function balance() public view returns (uint){
        return address(this).balance;
    }

    function transferEther(uint value) public{
        
    }

}

contract C {

    constructor() payable {

    }

    function pay(uint n, D1 d) public payable {
        address d1 = address(d);
        payable(d1).transfer(n);
    }

    function pay1(uint n, D1 d) public payable {
        address d1 = address(d);
        bool sent = payable(d1).send(n);
    }

    function pay2(uint n, D1 d) public payable {
        d.transferEther(n);
    }

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