ISTALLDIR="/usr/bin"
CDIR=$(pwd)

help:
	echo "delete:	Deletes all pre-installation files"
	echo "help:		Show this message"
	echo "install:	Install services"

delete:
	rm -r $CDIR/

install:
	if [ ! -w /etc/init.d ]; then echo "Make must be run as root in order to install as system services."; exit -1; fi
	echo ""
	echo "Install dir: $INSTALLDIR/PiScan"
	echo "Current dir: $CDIR/"
	read -p "Press Enter to continue or Ctrl-C to cancel"
	sudo ./install.sh $INSTALLDIR $CDIR

.PHONY: delete install help
