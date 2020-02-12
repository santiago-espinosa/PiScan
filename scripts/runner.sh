#!/bin/bash

bash setup.sh || { echo "Setup failed. Exiting."; exit 1 }
echo "Starting channel hop"
sudo channel_hop.sh >/dev/null 2>&1

folder=$(ls -d /home/pi/logs/*/ | tail -1)

for i in {1..3}
do
    this_round=$(date +%s%N | cut -b1-13)
    echo "Running tcpdump"
    sudo tcpdump -i mon0 -e -s 0 -l type mgt subtype assoc-req or type mgt subtype reassoc-req or type data subtype null | grep -P --line-buffered -o '(?<=SA:)(([a-f]|[0-9]){2}:){5}([a-f]|[0-9]){2}' | awk -Winteractive -v folder=$folder '{system("bash hasher.sh "folder$0)}'
    sleep 5
done