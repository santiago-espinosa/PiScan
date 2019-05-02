#!/bin/bash
#check if there are any arguments and exit otherwise
[ "$#" -ne 1 ] && exit

#Scan for nearby devices. Exclude anything with wlan.tag (APs)
sudo tshark -i $1 -Y "!(wlan.tag)" -T fields -e wlan.sa_resolved -a duration:20 > temp/$1/raw.txt

#Create address list
cat temp/$1/raw.txt | sort -u > temp/$1/add_list.txt
cat temp/$1/add_list.txt >> data/$1/prev_add.txt | sort -u > temp/$1/temp.txt
mv temp/$1/temp.txt data/$1/prev_add.txt

#count number of devices based on unique MAC addresses
wc temp/$1/add_list.txt -l | cut -d " " -f 1 > temp/$1/temp.txt

#output data to file with timestamp
A=$(date '+%Y-%m-%d %H:%M:%S')
B=$(cat temp/$1/temp.txt)
echo "$A $B" >> data/add_count.txt

#clean up
rm temp/$1/*
