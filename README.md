# Solidity static analysis tools sandbox

## Vulnerabilities studied:
* Reentrancy
* Type Casts
* Gasless Send/Transfer
* Phishing Tx Origin
* Unprotected SelfDestruct
* Dangerous Delegate Call Injection
* Unprotected Ether Withdrawal

## Tools used for our research:

* [Slither](https://github.com/crytic/slither)
* [Solc-verify ](https://github.com/SRI-CSL/solidity)
* [SMTChecker](https://docs.soliditylang.org/en/v0.8.15/smtchecker.html)
* [Mythril](https://github.com/ConsenSys/mythril)
* [Solidifier](https://github.com/blockhousetech/research/tree/master/Solidifier)


## Summary

|                              | Slither | Mythril | SMTChecker | Solc-verify | Solidifier |
|------------------------------|---------|---------|------------|-------------|------------|
| Type Casts                   |         |         |            |             |            |
| Reentrancy                   | X       | X       |            | X           |            |
| Phishing with tx.origin      | X       | X       | X          |             | X          |
| Delegatecall Injection       | X       | X       |            |             |            |
| Unprotected Selfdestruct     | X       | X       |            |             |            |
| Gasless send/transfer        |         |         |            |             |            |
| Unprotected Ether Withdrawal | X       | X*      | X          | X*          | X*         |



