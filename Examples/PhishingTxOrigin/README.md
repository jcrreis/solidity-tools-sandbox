PhishingTxOrigin.sol has an Wallet which is badly implemented because it uses tx.origin instead of msg.sender for authorization.

To solve this contract just use msg.sender instead of tx.origin for authorization.

You can experiment this vulnerability by running script.py:

USAGE: python3 script.py