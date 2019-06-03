FILES=$(ls -d /tmp/PiScan/*)

while :
    cat "$FILES" | while read -r line; do
        printf %s "$line" | md5sum | cut -f1 -d' '
    done
    sleep 1
done
