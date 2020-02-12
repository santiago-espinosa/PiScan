#!/bin/bash
date_today=$(date +%F)

while read p; do
  touch ~/piscan/output/$1.hash
  echo "$date_today $p" | md5sum | cut -f1 -d' ' > ~/piscan/output/$1.hash
  echo -e "$p\t $1\n" >> ~/piscan/output/$1.hash
done < ~/piscan/mac_addresses/$1
