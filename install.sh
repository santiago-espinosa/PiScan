#/!bin/bash

if [ ! -w /etc/init.d ]; then
    echo "Script must be run as root in order to install programs as system services."
    exit -1
fi
echo "Updating system"
sudo ./spinner.sh apt-get update -qq -y
echo "  -update done"
sudo ./spinner.sh apt-get upgrade -qq -y
echo "  -upgrade done"

echo "intalling dependent programs"
sudo ./spinner.sh apt-get install tcpdump -qq -y
echo "  -tcpdump install done"

echo "Making sure scripts are executable"
sudo chmod u+x bash/*.sh

echo "Installing files and systemd service"
sudo mkdir -p ~/piscan
sudo mkdir -p ~/piscan/info ~/piscan/data /tmp/piscan /tmp/piscan/logs ~/piscan/bash
echo "  - folders created"
sudo cp bash/*.sh ~/piscan/bash/
sudo cp services/*.service /lib/systemd/system/

echo "Starting services"
sudo systemctl daemon-reload >> /dev/null
sudo systemctl start tcpdumpsetup.service >> /dev/null
echo "  - setup.sh service running"
sudo systemctl start tcpdumpchanhop.service >> /dev/null
echo "  - chanhop.sh service running"
sudo systemctl start tcpdump.service >> /dev/null
echo " - tcpdump.sh service running"

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
