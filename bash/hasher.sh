while :
    cat "$1" | while read -r line; do
        printf %s "$line" | md5sum | cut -f1 -d' ' >> ~/piscan/data/$1.data
    done
done
