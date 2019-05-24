#!/bin/bash
#start TCP dump in the background
FOLDER=$(ls -d /home/pi/piScan/logs/*/ | tail -1)

while :
do
    sudo nohup tcpdump -i wlan0 -G 15 -e -s 0 -l type mgt subtype probe-req or type data subtype null or type mgt subtype assoc-req or type mgt subtype reassoc-req | grep -P --line-buffered -o '(?<=SA:)(([a-f]|[0-9]){2}:){5}([a-f]|[0-9]){2}' | awk -Winteractive -v folder=$FOLDER '{system("touch "folder$0)}' -
    sleep 5
done
