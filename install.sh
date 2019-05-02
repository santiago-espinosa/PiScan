#/!bin/bash
echo "Making sure scripts are executable"
sudo chmod 755 $2/scripts/*

#install dependent programs
echo "Installing T-shark"
sudo apt-get install tshark
echo "Making sure mail is to date"
sudo apt-get install mail

echo "Installing files and systemd service"

#moving files
sudo mkdir $1/PiScan
sudo cp $2/scripts/* $1/PiScan

#Installing adn starting systemd service
sudo cp $2/service/* /lib/systemd/system/
sudo systemctl start PiScan
sudo systemctl start PiScan_services_overwatch.service

`pgrep PiScan >/dev/null 2>&1`
STATS=$(echo $?)
if [[  $STATS == 1  ]]; then
    echo "Service failed to start"
    exit -1;
fi
