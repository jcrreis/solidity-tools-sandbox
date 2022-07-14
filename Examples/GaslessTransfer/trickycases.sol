// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.11;

contract D1 {
    
    function a(bool sent) public {
        require(sent);
    }

    function a1(bool sent) public returns(bool){
        require(sent);
        return sent;
    }

}

contract D {

    constructor() {

    }

    function pay(D1 d) public payable  {
        d.a(payable(address(d)).send(10));
    }
    function pay1(address payable d) public {
        a(d.send(10));
    }

    function pay2(D1 d) public payable  {
        bool sent = d.a1(payable(address(d)).send(10));
    }

    function pay3(address payable d) public {
        bool sent = a1(d.send(10));
    }

    function pay4(D1 d) public payable  {
        bool sent = d.a1(payable(address(address(address(d)))).send(10));
    }

    function a(bool sent) public {
        require(sent);
    }

    function a1(bool sent) public returns(bool){
        require(sent);
        return sent;
    }
}