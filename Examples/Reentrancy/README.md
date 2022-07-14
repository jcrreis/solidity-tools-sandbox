#### REENTRANCY

This folder contains some contracts using many methods to transfer ether from an account to another:

DepositFundsWithCall.sol -> Uses call method to transfer ether (Reentrancy prone)

DepositFundsWithCallAndReentrancyGuard.sol -> Use call method to transfer ether and Reentrancy Guard library to prevent reetrancy (Can't be attack with Reentrancy)

DepositFundsWithSend.sol -> Uses send method to transfer ether (Can't be attack with Reentrancy, because this method only forwards 2300 gas to callee contract)

DepositFundsWithTransfer.sol -> Uses transfer method to transfer ether (Can't be attack with Reentrancy, because this method only forwards 2300 gas to callee contract)

You can execute a reentrancy attack using script.py, which automatically deploys contracts and tries to breach them:

USAGE: python3 script.py < contract >