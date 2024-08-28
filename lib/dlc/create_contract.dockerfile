#!/bin/bash

# Command to create a DLC contract
FROM alpine:latest

RUN apk add --no-cache bash

RUN command dlc create -a <oracle_address> -f <fund_amount> -p <pubkey> -r <rvalue> -s <contract_size> -d <dlc_output_file>

# Other DLC-related commands...

RUN DLC create -a <oracle_info>
RUN DLC  create --oracle-utxo <oracle_utxo>dlc create -a <multsig>
