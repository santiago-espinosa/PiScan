#!/bin/bash
clear

#echo "$(tput setaf 2)Setting wireless wlan0 interface to monitor mode..."
sudo ip link set wlan0 down;
sudo iw wlan0 set monitor control;
sudo ip link set wlan0 up;

#echo "$(tput setaf 2)Scanning for devices nearby...$(tput setaf 0)";
sudo tshark -i wlan0 -Y "!(wlan.tag)" -T fields -e wlan.sa_resolved -a duration:15 > temp/raw.txt

#echo "$(tput setaf 2)Creating address list..."
cat temp/raw.txt | sort -u > temp/add_list.txt;
cat temp/add_list.txt >> data/prev_add.txt;
cat data/prev_add.txt | sort -u > temp/temp.txt;
mv temp/temp.txt data/prev_add.txt;

#echo "Setting wlan0 back to managed mode..."
sudo ip link set wlan0 down;
sudo iw wlan0 set type managed;
sudo ip link set wlan0 up;

wc temp/add_list.txt -l | cut -d " " -f 1 > temp/temp.txt;

#echo "Number of devices nearby: $(tput setaf 7) ";
#cat temp.txt;
#echo "$(tput setaf 2)Done!";

A=$(date '+%Y-%m-%d %H:%M:%S');
B=$(cat temp/temp.txt);
echo "$A $B" >> data/add_count.txt;

#echo "Cleaning up..."
rm temp/add_list.txt;
rm temp/temp.txt;
rm temp/raw.txt;
#echo "Done!"
