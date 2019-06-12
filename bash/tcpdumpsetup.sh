#!/bin/bash

# Put device in monitor mode

#start TCP dump in the background for each interface. rotate one file with max 100Mb size. all aoutput to /dev/null
D=$(iw dev | grep 'managed')
if [[ "$D" == *"managed"* ]]; then
    sudo ip link set wlan0 down;
    sudo iw wlan0 set monitor control;
    sudo ip link set wlan0 up;
fi

mkdir /tmp/PiScan
