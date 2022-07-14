// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;



/// @notice invariant address(this).balance >= balance
contract Wallet{

    address owner;
    uint balance;



    constructor() payable {
        require(balance == 0);

        balance += msg.value;
        owner = msg.sender;
    }

    function deposit() public payable{
        require(msg.value > 0, "You should send some ether to deposit.");

        balance += msg.value;

    }

    function withdraw(uint amount) public {
        require(amount > 0);
        require(amount <= balance, "No funds to withdraw that amount.");

        payable(owner).transfer(amount);
        balance -= amount;
    }

    function getBalance() public view  returns(uint) {
        return balance;
    }

    // function transferTo(address walletAddress, uint amount) public {
    //     require(amount > 0, "Invalid amount input.");
    //     require(walletAddress != address(this), "You can't transfer ether to yourself!");
    //     require(amount <= balance, "No funds to transfer that amount.");
    //     require(balance > 0, "You have no funds to transfer.");
        
    //     balance -= amount;
    //     Wallet(address(walletAddress)).deposit{value: amount}();
        
    // }

    /*
        Solc-verify doesn't support selfdestruct
    */
    // function killWallet() public payable{
    //     selfdestruct(payable(owner));

    // }

    /*
        Solc-verify doesn't support delegatecall
    */
    /// @notice postcondition balance == address(this).balance
    function delegateCallToAnotherContract(address _contract) public  {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)")
        );
    }
}

