
# Command to create a DLC contract over LN
FROM your_dlc_image

RUN dlc create -a <oracle_address> -f <fund_amount> -p <pubkey> -r <rvalue> -s <contract_size> -d <dlc_output_file>

# Other DLC-related commands...

RUN  create -a <oracle_info>
RUN  create -a <oracle_utxo>
RUN  create -a <multsig>
RUN create -a <open_channel>
RUN create -a <close_channel>
