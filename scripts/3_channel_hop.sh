#!/bin/bash
time=$(date +%s%N)

echo "$time\t Started Channel hop loop\t (tcpdump_channel_hop.sh)"
while :
do
    for channel in {1..14}
    do
        sudo iwconfig wlan0 channel $channel
        sleep 0.05s
    done
done
