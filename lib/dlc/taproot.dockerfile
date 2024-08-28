#!/bin/bash

FROM rust-dlc
FROM cfd-dlc
FROM --platform=arm64 rust-dlc

# Command to create a DLC contract
RUN dlc create -a <oracle_address> -f <fund_amount> -p <pubkey> -r <rvalue> -s <contract_size> -d <dlc_output_file>

# Other DLC-related commands...

RUN DLC create -a <oracle_info>
RUN  DLC  create -a <oracle_utxo>
RUN DLC create -a <multsig>

RUN dlclist
RUN DLC list -a <oracle_address>
RUN DLC list -a <oracle_utxo>
RUN DLC list -a <multsig>

RUN dlc show <dlc_id>