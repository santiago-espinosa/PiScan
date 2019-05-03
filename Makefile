ISTALLDIR = "/usr/bin"
CDIR = $(pwd)

help:
	echo "delete:	Deletes all pre-installation files"
	echo "help:		Show this message"
	echo "install:	Install services"

delete:
	rm -r $CDIR/

install:
	if [ ! -w /etc/init.d ]; then echo "Make must be run as root in order to install."; exit -1; fi
	echo "Install dir: $INSTALLDIR"
	echo "Current dir: $CDIR"
	sudo ./install.sh $INSTALLDIR $CDIR

.PHONY: delete install help
