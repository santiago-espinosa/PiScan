#!/bin/bash

# Put device in monitor mode
A=$(iwconfig 2>/dev/null | grep "wlan" | cut -d ' ' -f1)


#start TCP dump in the background for each interface. rotate one file with max 100Mb size. all aoutput to /dev/null
for i in $A;
do
    D=$(iw dev | grep 'managed')
    if [[ "$D" == *"managed"* ]]; then
        sudo ip link set $i down;
        sudo iw $i set monitor control;
        sudo ip link set $i up;
    fi
done

# Create a folder for this boot session
rootfolder=/home/pi/logs/day
i=0
while [[ -e $rootfolder$i ]] ; do
    let i++
done
folder=$rootfolder$i

mkdir $folder
