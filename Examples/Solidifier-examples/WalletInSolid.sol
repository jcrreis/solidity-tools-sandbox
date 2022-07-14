pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract Wallet {

    address payable owner;
    uint saldo;


    constructor() public payable {
        //require(balance == 0);
        Verification.Assume(saldo == 0);

        saldo += msg.value;
        owner = msg.sender;

        Verification.Assert(saldo == msg.value && owner == msg.sender);
    }

    function deposit() public payable{
        //require(msg.value > 0, "You should send some ether to deposit.");
        Verification.Assume(msg.value > 0);

        uint saldo_antes = saldo;
        saldo += msg.value;
        Verification.Assume(saldo > msg.value + saldo_antes);
        Verification.CexPrinti(saldo);
        Verification.Assert(saldo == saldo_antes + msg.value);
    }

    // function withdraw(uint amount) public {
    //     //require(amount > 0);
    //     //require(amount <= balance, "No funds to withdraw that amount.");
    //     Verification.Assume(amount > 0 && amount <= saldo);

    //     uint saldo_antes = saldo;
    //     saldo -= amount;
    //     owner.transfer(amount);

    //     Verification.Assert(saldo_antes == saldo + amount);
    // }

    // function getBalance() public view  returns(uint) {
    //     return balance;
    // }

    // function getOwner() public view returns (address){
    //     return owner;
    // }

    function transferTo(address walletAddress, uint amount) public {
        //require(amount > 0, "Invalid amount input.");
        //require(walletAddress != owner, "You can't transfer ether to yourself!");
        //require(amount <= balance, "No funds to transfer that amount.");
        //require(balance > 0, "You have no funds to transfer.");
        Verification.Assume(amount > 0);
        Verification.Assume(walletAddress != address(this));

        balance -= amount;
        Wallet(address(walletAddress)).deposit{value: amount}();
    }

    // function killWallet() public payable {
    //     selfdestruct(payable(owner));

    // }
}
