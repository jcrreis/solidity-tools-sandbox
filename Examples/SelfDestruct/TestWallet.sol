//manticore-verifier WalletSelfDestructableByAnyone.sol --contract TestWallet

import "./Wallet.sol";

contract TestWallet is Wallet{

    function crytic_test_deposit(uint amount) public payable returns (bool){
        uint old_balance = balance;
        this.deposit{value: amount}();            
        return old_balance + amount != balance;
    }

    function crytic_test_withdraw(uint amount) public returns (bool){
        uint old_balance = balance;
        this.withdraw(amount);
        return test_ownership() && (old_balance - amount == balance);
    }

    function test_ownership() public view returns  (bool) {
        return msg.sender == this.getOwner();
    }
}