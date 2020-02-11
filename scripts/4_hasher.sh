#!/bin/bash
date_today=$(date +%F)

while read p; do
  echo "$date_today $p" | md5sum | cut -f1 -d' ' > ~/piscan/output/$1.hash
  echo "$p\t $1\n" >> ~/piscan/output/$1.hash
done < ~/piscan/mac_addresses/$1
