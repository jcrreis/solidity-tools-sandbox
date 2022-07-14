// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;

//import "/home/joao/Desktop/SMTChecker/node_modules/hardhat/console.sol";


interface WalletI {
    function deposit() external payable;
    function withdraw(uint amount) external;
    function getBalance() external returns (uint);
    function transferTo(address walletAddress, uint amount) external;
    function killWallet() external payable;
}


contract Wallet is WalletI {

    address owner;
    uint balance;

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    constructor() payable {
        require(balance == 0);

        balance += msg.value;
        owner = msg.sender;
        
        assert(balance == msg.value && owner == msg.sender);
    }

    function deposit() public payable{
        require(msg.value > 0, "You should send some ether to deposit.");

        uint old_balance = balance;
        balance += msg.value;

        assert(old_balance == balance - msg.value);
    }

    function withdraw(uint amount) public onlyOwner{
        require(amount > 0);
        require(amount <= balance, "No funds to withdraw that amount.");

        uint old_balance = balance;
        balance -= amount;
        payable(owner).transfer(amount);

        assert(old_balance == balance + amount);
    }

    function getBalance() public view onlyOwner returns(uint) {
        return balance;
    }

    function transferTo(address walletAddress, uint amount) public onlyOwner{
        require(amount > 0, "Invalid amount input.");
        require(walletAddress != address(this), "You can't transfer ether to yourself!");
        require(amount <= balance, "No funds to transfer that amount.");
        require(balance > 0, "You have no funds to transfer.");
        
        uint old_amount_this = balance;
        uint old_amount_to = Wallet(address(walletAddress)).getBalance();

        balance -= amount;
        Wallet(address(walletAddress)).deposit{value: amount}();

        uint new_balance_to = Wallet(address(walletAddress)).getBalance();
        assert(old_amount_this == balance + amount);
        assert(old_amount_to == new_balance_to - amount);
    }

    function killWallet() public payable onlyOwner{
        selfdestruct(payable(owner));

        assert(balance == 0);

    }

    function delegateCallToAnotherContract(address _contract) public  {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)")
        );
    }
}
//manticore-verifier WalletSelfDestructableByAnyone.sol --contract TestWallet

contract Attack {

    fallback() external payable{
        selfdestruct(payable(msg.sender));
    }
}