#!/bin/bash





while :
do
    amount=$(/root/go/bin/zetacored q bank balances $(/root/go/bin/zetacored keys show wallet -a) | grep amount | awk '{print $3}' | tr -d '"')

    if [ "$amount" -gt 3000000000000000000 ]; then
        /root/go/bin/zetacored tx staking delegate $(/root/go/bin/zetacored keys show wallet --bech val -a) 3000000000000000000azeta --from wallet --chain-id athens_7001-1 --gas-prices 0.1azeta --gas-adjustment 1.5 --gas auto -y
        sleep 3
    else
        break
    fi

    echo "$amount"
    sleep 10
    echo -e "\n"
done

