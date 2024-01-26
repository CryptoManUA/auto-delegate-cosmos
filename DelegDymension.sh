#!/bin/bash





while :
do
    amount=$(/root/go/bin/dymd q bank balances $(/root/go/bin/dymd keys show wallet -a) | awk '/amount/ {gsub(/"/, "", $3); print $3}')

    echo "Amount: $amount"

    if [ -n "$amount" ]; then
        if [ "$(echo "$amount > 200000000000000000000" | bc)" -eq 1 ]; then
            /root/go/bin/dymd tx staking delegate $(/root/go/bin/dymd keys show wallet --bech val -a) 200dym --from wallet --chain-id froopyland_100-1 --gas-prices 0.1udym --gas-adjustment 1.5 -y
            sleep 3
        else
            break
        fi
        
    else
        echo "Error: Invalid or empty amount"
        break
    fi
    
done