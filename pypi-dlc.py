import hashlib
import base64
import json
from bitcoinlib.keys import Key  # Assuming you're using bitcoinlib for key/address handling

# Define a function to calculate the contract's payout address
def calculate_payout_address(contract):
    # Hash the contract's oracle public key
    contract_hash = hashlib.sha256(contract["oracle_pubkey"].encode("utf-8")).digest()
    # Generate the Bitcoin address from the public key hash using bitcoinlib
    contract_payout_address = Key(public_key=contract_hash).address()
    return contract_payout_address

# Define a function to calculate the payout based on the oracle's outcome
def calculate_payout(contract, oracle_outcome):
    if oracle_outcome == "HEADS":
        return contract["alice_amount"]
    elif oracle_outcome == "TAILS":
        return contract["bob_amount"]
    else:
        return 0

# Example DLC contract
contract = {
    "alice_amount": 1,  # In BTC or satoshis
    "bob_amount": 2,    # In BTC or satoshis
    "oracle_pubkey": "oracle_pubkey_here",  # Replace with actual oracle public key
    # Add more contract details as needed
}

# Example oracle outcome
oracle_outcome = "HEADS"

# Calculate the payout
payout = calculate_payout(contract, oracle_outcome)

# Calculate the contract's payout address
payout_address = calculate_payout_address(contract)

print(f"Payout: {payout}")
print(f"Payout Address: {payout_address}")

