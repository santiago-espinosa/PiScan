#!/bin/bash
date_today=$(date +%F)

while read p; do
  touch $(pwd)/piscan/output/$1.hash
  echo "$date_today $p" | md5sum | cut -f1 -d' ' > $(pwd)/piscan/output/$1.hash
  echo -e "$p\t $1\n" >> $(pwd)/piscan/output/$1.hash
done < $(pwd)/piscan/mac_addresses/$1
