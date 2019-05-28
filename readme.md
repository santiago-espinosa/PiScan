# Incomplete PiScan Application

## Current structure when installed:

### :file_folder: **install Dir (/usr/bin/ by default)**
Contains all scripts in this structure:

* :file_folder: **/usr/bin/bash**   |   contains all Bash scripts
  * runtcpdump.sh           |     Runs tcpdump every 5.5 seconds for 15 seconds as a background process on wlan0 and instructs the process to kill itself once finished
  * tcpdumpchanhop.sh       |     Hops channels of wlan0 for tcpdump
  * tcpdumpsetup.sh         |     Sets up wlan0 interface to monitor mode and creates folders for scan session (format: "day{#}")

### :file_folder: **System service dir (must be /lib/systemd/system/)**   |   contains systemd description files
  * tcpdump.service             |   runs runtcpdump.sh continuously
  * tcpdumpchanhop.service      |   runs tcpdumpchanhop.sh continuously
  * tcpdumpsetup.service        |   runs tcpdumpsetup.sh once
