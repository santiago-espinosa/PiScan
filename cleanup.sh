#/!/bin/bash

A=$(wc data/add_count.txt -l | cut -d " " -f 1)
if [ 90 -lt $A ]
then
        tail -n 90 data/add_count.txt > data/add_count_cleanup_cache.txt
        rm data/add_count.txt
        mv data/add_cleanup_cache.txt data/add_count.txt
        rm data/add_cleanup_cache.txt
fi
