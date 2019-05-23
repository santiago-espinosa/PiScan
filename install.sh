#/!bin/bash
ISTALLDIR=$1
CDIR=$2
HOSTNAME=$(ifconfig -a | awk '/^[a-z]/ { iface=$1; mac=$NF; next } /inet addr:/ { print iface, mac }')
INTERFACES=$(iwconfig 2>/dev/null | grep "wlan" | cut -d ' ' -f1)

echo "Updating system"
sudo apt-get update
sudo apt-get upgrade

echo "Making sure scripts are executable"
sudo chmod 755 $CDIR/bash/*

#install dependent programs
echo "intalling tcpdump"
sudo apt-get install tcpdump

#echo "Installing files and systemd service"
#setting API key?

#moving files, creating folders and setting API key (mac address)
sudo mkdir $ISTALLDIR/PiScan
sudo cp $CDIR/scripts/*.sh $ISTALLDIR/PiScan
mkdir $ISTALLDIR/info $ISTALLDIR/data $ISTALLDIR/temp
touch $ISTALLDIR/info/API.key
echo "$hostname" > $ISTALLDIR/info/API.key

#create folders corresponding to the interfaces
for i in $INTERFACES; do
    if [ ! -d "$INSTALLDIR/data/$i" ]; then
        mkdir $INSTALLDIR/data/$1;
        mkdir $INSTALLDIR/temp/$1;
    fi
done

#Installing and starting systemd service
sudo cp $ISTALLDIR/services/*.service /lib/systemd/system/


#start scripts
sudo systemctl daemon-reload
sudo systemctl start tcpdumpsetup.service
sudo systemctl start tcpdumpchanhop.service
sudo systemctl start tcpdump.service

#checking if service has started
`pgrep PiScan >/dev/null 2>&1`
STATS=$(echo $?)
if [[  $STATS == 1  ]]; then
    echo "Service failed to start"
    exit -1;
else
    echo "Done!"
    read -p "Remove pre-installation files? (y)" answer
    if [ "$answer" == 'y']; then
        rm -r $CDIR/
    fi
fi
