#/!bin/bash
ISTALLDIR=$1
CDIR=$2

if [ ! -w /etc/init.d ]; then echo "Make must be run as root in order to install as system services."; exit -1; fi

echo "Updating system"
sudo apt-get update -qq -y >> /dev/null
sudo apt-get upgrade -qq -y >> /dev/null

echo "Making sure scripts are executable"
sudo chmod 755 $CDIR/bash/*.sh

#install dependent programs
echo "intalling tcpdump"
sudo apt-get install tcpdump -qq -y >> /dev/null


#moving files, creating folders and setting API key (mac address)
echo "Installing files and systemd service"
sudo mkdir $ISTALLDIR/PiScan
sudo mkdir $ISTALLDIR/PiScan/info /tmp/PiScan /tmp/PiScan/logs $ISTALLDIR/PiScan/scripts

sudo cp $CDIR/scripts/*.sh $ISTALLDIR/PiScan/scripts/

#HOSTNAME=$(ifconfig -a | awk '/^[a-z]/ { iface=$1; mac=$NF; next } /inet addr:/ { print iface, mac }')
#touch $ISTALLDIR/PiScan/info/API.key
#echo "$hostname" > $ISTALLDIR/info/API.key
#g++ $CDIR/c++/hasher.cpp -o $ISTALLDIR/PiScan/bin/exec


#Installing and starting systemd service
sudo cp $CDIR/services/*.service /lib/systemd/system/

#start scripts
sudo systemctl daemon-reload
sudo systemctl start tcpdumpsetup.service
sudo systemctl start tcpdumpchanhop.service
sudo systemctl start tcpdump.service

echo "Install finished"
read -p "Remove pre-installation files? (y/n)" answer
if [ "$answer" == 'y']; then
    rm -r $CDIR/
fi
