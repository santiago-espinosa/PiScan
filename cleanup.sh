#/!/bin/bash

A=$(wc ../data/add_count.txt -l | cut -d " " -f 1)
if [ 90 -lt $A ]
then
        tail -n 90 ../data/add_count.txt > ../data/add_count1.txt
        mv ../data/add_count1.txt ../data/add_count.txt
fi
