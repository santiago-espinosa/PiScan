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


#moving files, creating folders and setting API key (mac address)
echo "Installing files and systemd service"
sudo mkdir $ISTALLDIR/PiScan
sudo mkdir $ISTALLDIR/PiScan/info $ISTALLDIR/PiScan/log /home/pi/PiScan/data
sudo mkdir $ISTALLDIR/PiScan/bin $ISTALLDIR/PiScan/bin/scripts $ISTALLDIR/PiScan/bin/exec

sudo cp $CDIR/scripts/*.sh $ISTALLDIR/PiScan/bin/scripts

#touch $ISTALLDIR/info/API.key
#echo "$hostname" > $ISTALLDIR/info/API.key

#g++ $CDIR/c++/hasher.cpp -o $ISTALLDIR/PiScan/bin/exec


#Installing and starting systemd service
sudo cp $ISTALLDIR/services/*.service /lib/systemd/system/

#start scripts
sudo systemctl daemon-reload
sudo systemctl start tcpdumpsetup.service
sudo systemctl start tcpdumpchanhop.service
sudo systemctl start tcpdump.service

#checking if service has started
`pgrep tcpdumpsetup >/dev/null 2>&1`
STATS=$(echo $?)
if [[  $STATS == 1  ]]; then
    echo "Services failed to start"
fi

echo "Install finished"
read -p "Remove pre-installation files? (y/n)" answer
if [ "$answer" == 'y']; then
    rm -r $CDIR/
fi
