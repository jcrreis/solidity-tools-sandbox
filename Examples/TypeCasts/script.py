from web3 import Web3
from web3 import contract as c

from solcx import compile_files

import sys


def get_contract_abi_bin(contract_file):
    compiled_sol = compile_files( contract_file,
        output_values=['abi', 'bin']
    )

    return compiled_sol

def deploy_contract(abi, bin):
    Contract = w3.eth.contract(abi=abi, bytecode=bin)
    tx_hash = Contract.constructor().transact()
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    contract = w3.eth.contract(
    address=tx_receipt.contractAddress,
    abi=abi
    )
    print(f"CONTRACT DEPLOYED WITH ADDRESS: {contract.address}")
    return contract


w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))
accounts = w3.eth.accounts

w3.eth.default_account = accounts[0]

compiled_contracts = get_contract_abi_bin("./TypeCasts.sol")

for ctr in compiled_contracts:

    if(ctr == 'TypeCasts.sol:CounterLibrary'):
        #COMPILE AND DEPLOY COUNTERLIBRARY CONTRACT
        abi = compiled_contracts[ctr]['abi']
        bin = compiled_contracts[ctr]['bin']
        counter_library = deploy_contract(abi, bin)

    if(ctr == 'TypeCasts.sol:FakeCounter'):
        #COMPILE AND DEPLOY FakeCounter CONTRACT
        abi = compiled_contracts[ctr]['abi']
        bin = compiled_contracts[ctr]['bin']
        fake_counter = deploy_contract(abi, bin)

    if(ctr == 'TypeCasts.sol:Game'):
        #COMPILE AND DEPLOY Game CONTRACT
        abi = compiled_contracts[ctr]['abi']
        bin = compiled_contracts[ctr]['bin']
        game = deploy_contract(abi, bin)

impl_counter_library = c.ImplicitContract(counter_library)
impl_fake_counter = c.ImplicitContract(fake_counter)
impl_game = c.ImplicitContract(game)

counter = game.functions.play(counter_library.address).transact() #FIRST INCREMENT 
counter = game.functions.play(counter_library.address).transact() # SECOND INCREMENT
counter = game.functions.play(fake_counter.address).transact() #THIRD INCREMENT

counter = game.functions.getCounter(counter_library.address).call() #THIS SHOULD RETURN 3

assert counter == 3, f'counter should be 3 instead got {counter}'