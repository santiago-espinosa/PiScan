ISTALLDIR = $(/usr/bin)
CDIR = $(pwd)

help:
	echo ""

clean:
	rm -r $CDIR

install:
	if [ ! -w /etc/init.d ]; then echo "Make must be run as root in order to install."; exit -1; fi
	sudo ./install.sh $INSTALLDIR $CDIR

.PHONY: clean install help
