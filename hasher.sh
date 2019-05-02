#!/bin/bash
#check if there are any arguments and exit otherwise
[ "$#" -ne 1 ] && exit
while IFS='' read -r line || [[ -n "$line" ]]; do
    md5sum $line >> data/prev_add_hashed.txt
done < data/$i/prev_add.txt
rm  data/$i/prev_add.txt
