#!/bin/bash
time=$(date +%F)
mon_mode=$(iw dev | grep 'managed')

echo-e "$time\t Started TCPDump setup"

if [[ "$mon_mode" == *"managed"* ]]; then
    sudo ip link set wlan0 down;
    sudo iw wlan0 set monitor control;
    sudo ip link set wlan0 up;
else
    echo "wlan0 already in monitor mode"
fi

echo "Creating folders"
mkdir -p $(pwd)/piscan/mac_addresses $(pwd)/piscan/output
