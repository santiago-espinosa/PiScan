#!/bin/bash
while :
do
    for channel in {1..14}
    do
        iwconfig mon0 channel $channel
        sleep 0.05s
    done
done
