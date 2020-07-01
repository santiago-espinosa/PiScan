#!/bin/bash
time=$(date +%F%T)
mon_mode=$(iw dev | grep 'managed')

echo -e "$time\t Started  setup"

iplink show wlan0 >/dev/null 2>&1 || { echo "No wireless interface found. Exiting"; exit 1; }

if [[ "$mon_mode" == *"managed"* ]]; then
    sudo ip link set wlan0 down;
    sudo iw wlan0 set monitor control;
    sudo ip link set wlan0 up;
else
    echo "wlan0 already in monitor mode"
fi

tcpdump >/dev/null 2>&1 || { echo >&2 "Installing tcpdump."; sudo apt install tcpdump -y; }

echo "Creating folders"

rootfolder=/home/pi/logs/
i=0  
while [[ -e $rootfolder$i ]] ; do  
    let i++
done  

folder=$rootfolder$i
mkdir -m 600 -p $folder/mac_addresses $folder/output

echo "$time\t setup finished"