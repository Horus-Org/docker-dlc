#!/bin/bash

FROM rust-dlc
FROM cfd-dlc
FROM --platform=arm64 rust-dlc

# Command to create a DLC contract
dlc create -a <oracle_address> -f <fund_amount> -p <pubkey> -r <rvalue> -s <contract_size> -d <dlc_output_file>

# Other DLC-related commands...

dlc create -a <oracle_info>
dlc create -a <oracle_utxo>
dlc create -a <multsig>

dlc list
dlc list -a <oracle_address>
dlc list -a <oracle_utxo>
dlc list -a <multsig>

dlc show <dlc_id>