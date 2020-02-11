#!/bin/bash
time=$(date +%s%N)
mon_mode=$(iw dev | grep 'managed')

echo "$time\t Started TCPDump setup"

if [[ "$mon_mode" == *"managed"* ]]; then
    sudo ip link set wlan0 down;
    sudo iw wlan0 set monitor control;
    sudo ip link set wlan0 up;
else
    echo "wlan0 already in monitor mode"
fi

echo "creating folders"
mkdir -p ~/piscan/mac_addresses ~/piscan/output
