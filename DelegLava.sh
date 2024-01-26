#!/bin/bash

export PATH=$PATH:/root/go/bin/lavad
lavad_path="/root/go/bin/lavad"

if [ ! -x "$lavad_path" ]; then
    echo "Error: lavad not found or does not have execute permissions."
    exit 1
fi

while :
do
    amount=$(/root/go/bin/lavad q bank balances $(/root/go/bin/lavad keys show wallet -a) | grep amount | awk '{print $3}' | tr -d '"')

    if [ "$amount" -gt 100000 ]; then
        /root/go/bin/lavad tx staking delegate $(/root/go/bin/lavad keys show wallet --bech val -a) 70000ulava --from wallet --chain-id lava-testnet-2 --gas-prices 0.1ulava --gas-adjustment 1.5 -y
        sleep 3
    else
        break
    fi

    echo "$amount"
    sleep 10
    echo -e "\n"
done