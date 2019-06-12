#/!bin/bash
INSTALLDIR="/usr/bin"
CDIR=$(pwd)
if [ ! -w /etc/init.d ]; then
    echo "Script must be run as root in order to install programs as system services."
    exit -1
fi
echo "Updating system"
sudo ./spinner.sh apt-get update -qq -y
echo "  -update done"
sudo ./spinner.sh apt-get upgrade -qq -y
echo "  -upgrade done"

echo "Making sure scripts are executable"
sudo chmod u+x $CDIR/bash/*

echo "intalling dependent programs"
sudo ./spinner.sh apt-get install tcpdump -qq -y
echo "  -tcpdump install done"

echo "Installing files and systemd service"
sudo mkdir -p $INSTALLDIR/PiScan
sudo mkdir -p $INSTALLDIR/PiScan/info $INSTALLDIR/PiScan/data /tmp/PiScan /tmp/PiScan/logs $INSTALLDIR/PiScan/bash
echo "  -create folders done"
sudo cp $CDIR/bash/* $INSTALLDIR/PiScan/bash/
sudo cp $CDIR/services/* /lib/systemd/system/
echo "  -copy scripts done"

echo "Starting services"
sudo systemctl daemon-reload >> /dev/null
sudo systemctl start tcpdumpsetup.service >> /dev/null
echo "  -setup.sh service running"
sudo systemctl start tcpdumpchanhop.service >> /dev/null
echo "  -chanhop.sh service running"
sudo systemctl start tcpdump.service >> /dev/null
echo " -tcpdump.sh service running"

echo "Install finished"

echo "Remove pre-installation files? (y/n)"
read answer
yes="y"
if [ "$answer" == "$yes" ]; then
    rm -r ./
    exit 1
else
    exit 1
fi
