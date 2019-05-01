#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
    md5sum $line >> data/prev_add_hashed.txt
done < data/$i/prev_add.txt
rm  data/$i/prev_add.txt
