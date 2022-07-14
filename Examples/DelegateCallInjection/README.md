#### DELEGATE CALL INJECTION

This folder contains a Wallet contract which can be selfdestructable by anone because it has a dangerous  arbitrary delegatecall injection:
* It is dangerous to let an arbitrary delegatecall be called by another contract that is not the owner of the contract with the delegatecall
* To solve this contract, either you hardcode the contract which is called by delegatecall or make this function only callable by the owner of the contract.

You can execute the exploit by running script.py file.

USAGE: python3 script.py < contract >