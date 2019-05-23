## Incomplete PiScan Application

### Current structure when installed:

:file_folder: **install Dir (/usr/bin/ by default)**
Contains all scripts in this structure:

* :file_folder: **/usr/bin/bash**   |   contains all Bash scripts
  * runtcpdump.sh      |   Runs tcpdump every 10 seconds for 15 seconds on mon0
  * tcpdumpchanhop.sh  |   Hops channels for tcpdump
  * tcpdumpsetup.sh    |   Sets up interfaces and tcpdump

:file_folder: **System service dir (must be /lib/systemd/system/)**   |   contains systemd description files
  * tcpdump.service
  * tcpdumpsetup.service
  * tcpdumpchanhop.service
