from web3 import Web3
from web3 import contract as c

from solcx import compile_files

import sys


def get_contract_abi_bin(contract_file):
    compiled_sol = compile_files( contract_file,
        output_values=['abi', 'bin']
    )
    if (len(compiled_sol) == 1):
        _, contract_interface = compiled_sol.popitem()
    else:
        compiled_sol.popitem()
        _, contract_interface = compiled_sol.popitem()

    return contract_interface['abi'],contract_interface['bin']

def deploy_deposit_funds(abi, bin):
    Contract = w3.eth.contract(abi=abi, bytecode=bin)
    tx_hash = Contract.constructor().transact()
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    contract = w3.eth.contract(
    address=tx_receipt.contractAddress,
    abi=abi
    )
    print(f"DEPOSIT FUNDS CONTRACT DEPLOY WITH ADDRESS: {contract.address}")
    return contract

def deploy_attacker_contract(abi, bin, target_address):
    Contract = w3.eth.contract(abi=abi, bytecode=bin)
    tx_hash = Contract.constructor(target_address).transact()
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    contract = w3.eth.contract(
    address=tx_receipt.contractAddress,
    abi=abi
    )
    print(f"ATTACKER CONTRACT DEPLOY WITH ADDRESS: {contract.address}")
    return contract

if(len(sys.argv) != 2):
    print("USAGE: python3 teste.py |DEPOSITFUNDS.SOL|")
    sys.exit(0)

#### CONNECT WEB3PY TO GANACHE
w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))
accounts = w3.eth.accounts

######## VICTIM ###############

w3.eth.default_account = accounts[0] #set account[0] as default account

abi, bin = get_contract_abi_bin(sys.argv[1])
contract = deploy_deposit_funds(abi, bin)
concise = c.ImplicitContract(contract)

concise.deposit(transact={'value': 10000000000000000000}) #deposits 10 ether into contract
concise.deposit(transact={'value': 10000000000000000000}) #more 10 ether

target_contract_address = contract.address #STORE CONTRACT ADDRESS

########  ATTACKER ################

w3.eth.default_account = accounts[1] #Change account
init_balance = w3.eth.get_balance(accounts[1]) #store attacker initial balance

abi, bin = get_contract_abi_bin("./Attack.sol")
contract = deploy_attacker_contract(abi, bin, target_contract_address)
concise = c.ImplicitContract(contract)

print("TRYING REENTRANCY ATTACK.....")
try:
    concise.attack(transact={'value': 1000000000000000000})
except Exception as e:
    print(e)
    print("Reentrancy attack failed, this contract is secure.")
    exit(0)

concise.withdraw()
stolen_ether = w3.eth.get_balance(accounts[1]) - init_balance
stolen_ether = w3.fromWei(stolen_ether, 'ether')
print(f"Reentrancy attack succeded: {stolen_ether} ETH stoled by the attacker")