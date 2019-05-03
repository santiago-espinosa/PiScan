#!/bin/bash
#!/usr/bin/env bash

#find all wifi chips
A=$(iwconfig | grep "wlan" | cut -d ' ' -f1)

while :
do
    for i in $A; do

        #create dir if it downad't exist
        if [ ! -d "$INSTALLDIR/data/$i" ]; then
            mkdir $INSTALLDIR/data/$1;
            mkdir $INSTALLDIR/temp/$1;
        fi

        #Set given wireless interface to monitor mode if not the case
        D=$(iw dev  | grep "managed")
        if [[ "$D" == *"managed"* ]]; then
            sudo ip link set $i down;
            sudo iw $i set monitor control;
            sudo ip link set $i up;
        fi

        #run scan scripts in the background and continue execution
        nohup ./$INSTALLDIR/driver.sh $i &>/dev/null &;
        nohup ./$INSTALLDIR/hasher.sh $i &>/dev/null &;

        sleep 15;
    done
done
