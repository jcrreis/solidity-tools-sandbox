// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.5.17;

// /**
//  * @dev Provides information about the current execution context, including the
//  * sender of the transaction and its data. While these are generally available
//  * via msg.sender and msg.data, they should not be accessed in such a direct
//  * manner, since when dealing with meta-transactions the account sending and
//  * paying for execution may not be the actual sender (as far as an application
//  * is concerned).
//  *
//  * This contract is only required for intermediate, library-like contracts.
//  */
// contract Context {
//     function _msgSender() internal view returns (address) {
//         return msg.sender;
//     }

//     function _msgData() internal view returns (bytes memory) {
//         return msg.data;
//     }
// }

// /**
//  * @dev Contract module which provides a basic access control mechanism, where
//  * there is an account (an owner) that can be granted exclusive access to
//  * specific functions.
//  *
//  * By default, the owner account will be the one that deploys the contract. This
//  * can later be changed with {transferOwnership}.
//  *
//  * This module is used through inheritance. It will make available the modifier
//  * `onlyOwner`, which can be applied to your functions to restrict their use to
//  * the owner.
//  */
// contract Ownable is Context {
//     address private _owner;

//     event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

//     /**
//      * @dev Initializes the contract setting the deployer as the initial owner.
//      */
//     constructor() public {
//         _transferOwnership(_msgSender());
//     }

//     /**
//      * @dev Throws if called by any account other than the owner.
//      */
//     modifier onlyOwner() {
//         _checkOwner();
//         _;
//     }

//     /**
//      * @dev Returns the address of the current owner.
//      */
//     function owner() public view  returns (address) {
//         return _owner;
//     }

//     /**
//      * @dev Throws if the sender is not the owner.
//      */
//     function _checkOwner() internal view  {
//         require(owner() == _msgSender());
//     }

//     /**
//      * @dev Leaves the contract without owner. It will not be possible to call
//      * `onlyOwner` functions anymore. Can only be called by the current owner.
//      *
//      * NOTE: Renouncing ownership will leave the contract without an owner,
//      * thereby removing any functionality that is only available to the owner.
//      */
//     function renounceOwnership() public  onlyOwner {
//         _transferOwnership(address(0));
//     }

//     /**
//      * @dev Transfers ownership of the contract to a new account (`newOwner`).
//      * Can only be called by the current owner.
//      */
//     function transferOwnership(address newOwner) public  onlyOwner {
//         require(newOwner != address(0));
//         _transferOwnership(newOwner);
//     }

//     /**
//      * @dev Transfers ownership of the contract to a new account (`newOwner`).
//      * Internal function without access restriction.
//      */
//     function _transferOwnership(address newOwner) internal  {
//         address oldOwner = _owner;
//         _owner = newOwner;
//         emit OwnershipTransferred(oldOwner, newOwner);
//     }
// }


contract Wallet {

    uint balance;
    address owner;

    constructor() public payable{
        require(balance == 0);

        owner = msg.sender;
        balance += msg.value;
    }

    /*
        Solidifier doesn't support modifiers...
    */
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    

    function deposit() public payable{
        //require(msg.value > 0, "You should send some ether to deposit.");

        balance += msg.value;
    }

    function protectedWithdraw(uint amount) public onlyOwner{
        require(amount > 0);
        //require(amount <= balance, "No funds to withdraw that amount.");
        Verifcation. assume(...)
        //assert(msg.sender == owner());
        balance -= amount;
        msg.sender.transfer(amount);
    }

    function unProtectedWithdraw(uint amount) public {
        require(amount > 0);
        //require(amount <= balance, "No funds to withdraw that amount.");

        //assert(msg.sender == owner());
        balance -= amount;
        msg.sender.transfer(amount);
    }

}