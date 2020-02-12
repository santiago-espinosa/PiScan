#!/bin/bash
tcp_dump=("sudo nohup tcpdump -i wlan0 -G 15 -e -s 0 -l type mgt subtype probe-req or type data subtype null or type mgt subtype assoc-req or type mgt subtype reassoc-req | grep -P --line-buffered -o '(?<=SA:)(([a-f]|[0-9]){2}:){5}([a-f]|[0-9]){2}'")

#check if setup has been run already
if [ ! -d "~/piscan" ]; then
    echo "Folder not found. Running setup."
    bash setup.sh
fi

for i in {1..3}
do
    this_round=$(date +%s%N | cut -b1-13)
    $tcp_dump > ~/piscan/mac_addresses/$this_round
    nohup bash hasher.sh $this_round
    sleep 5
done
