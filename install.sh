#/!bin/bash
echo "Updating packages"
sudo apt-get update
sudo apt-get upgrade

echo "Making sure scripts are executable"
sudo chmod 755 $2/scripts/*

#install dependent programs
echo "Installing T-shark"
sudo apt-get install tshark
echo "Making sure mail is to date"
sudo apt-get install ssmtp mailutils
sudo chmod 774 /etc/ssmtp/ssmtp.conf

:'
echo "root=postmaster" >> /etc/ssmtp/ssmtp.conf
echo "hostname=pi1" >> /etc/ssmtp/ssmtp.conf
echo "mailhub=SSMTP:PORT" >> /etc/ssmtp/ssmtp.conf
echo "AuthUser=EMAIL" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=PASSWORD" >> /etc/ssmtp/ssmtp.conf
echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf

echo "root:EMAIL:SSMTP:PORT" >> /etc/ssmtp/revaliases
'
echo "Installing files and systemd service"

#moving files
sudo mkdir $1/PiScan
sudo cp $2/scripts/* $1/PiScan

ISTALLDIR=$1

#Installing and starting systemd service
sudo cp $2/service/* /lib/systemd/system/
#add install dir to scripts

##MUST TEST SED BEFORE DEPLOYING
sed  -i "1 INSTALLDIR=$($1)" /lib/systemd/system/PiScan.service
sed  -i "1 INSTALLDIR=$($1)" /lib/systemd/system/PiScan_services_overwatch.service
#start scripts
sudo systemctl start PiScan
sudo systemctl start PiScan_services_overwatch

`pgrep PiScan >/dev/null 2>&1`
STATS=$(echo $?)
if [[  $STATS == 1  ]]; then
    echo "Service failed to start"
    exit -1;
else
    echo "Done!"
fi
