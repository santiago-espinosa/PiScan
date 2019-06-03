ISTALLDIR="/usr/bin"
CDIR=$(pwd)

.PHONY : delete install help

help :
	@echo ""
	@echo "	delete:		Deletes all pre-installation files"
	@echo "	help:		Show this message"
	@echo "	install:	Install services"

delete :
	rm -r $CDIR/

install :
	@echo ""
	@echo "Install dir: $INSTALLDIR/PiScan"
	@echo "Current dir: $CDIR/"
	@read -p "Press Enter to continue or Ctrl-C to cancel. Different install directories are not yet supported."
	@chmod +x install.sh
	sudo ./install.sh $INSTALLDIR $CDIR
