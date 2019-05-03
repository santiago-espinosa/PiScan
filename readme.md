## Incomplete PiScan Application

### Current structure when installed:

:file_folder: **install Dir (/usr/bin/ by default)**
Contains all scripts in this structure:

* :file_folder: **/usr/bin/python** | Contains all python scripts
  * getMacAdd.py | Gets mac address. Still to be integrated

* :file_folder: **/usr/bin/bash** | contains all Bash scripts
  * cleanup.sh | cleans up any records after ~ 5 mins
  * driver.sh  | main driving program
  * hasher.sh  | hashes values to preserve privacy

* :file_folder: **/usr/bin/services** | contains scripts to be used for as the system services
  * PiScan_service_overwatch.sh
  * PiScan.service

:file_folder: **System service dir (must be /lib/systemd/system/)** | contains systemd description files
  * PiScan_service_overwatch.service
  * PiScan.service
