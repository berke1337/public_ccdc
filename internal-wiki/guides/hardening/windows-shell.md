## Useful CLI Programs
* [`net view /ALL`](https://technet.microsoft.com/en-us/library/hh875576(v=ws.11).aspx): List Shared Folders, Network Computers
* `reg add hklm\system\currentcontrolset\control\ session manager\memory management /v moveimages /t REG_DWORD /d 1 /f`: Set ASLR?
  * [`reg add <KeyName> /v <ValueName> /t <Type> /d <Data>`](https://technet.microsoft.com/en-us/library/cc742162(v=ws.11).aspx): Add Key with value to registry (`/f` doesn't prompt for confirmation)
* `bcdedit /set nx AlwaysOn`: Set DEP?
  * [`bcdedit /<Command>`](https://technet.microsoft.com/en-us/library/cc731662(v=ws.11).aspx): Modifying Boot Settings
* `wmic /node:<RemoteComputer> computersystem get username`: Check past users and login logs
  * [`wmic <Command>`](https://msdn.microsoft.com/en-us/library/aa394531(v=vs.85).aspx): Windows Management Instrumentation's CLI
* `ntdsutil set d p` or `dsmgmt set d p`: Set Directory Services Restore Mode (DSRM)
  * [`ntdsutil <Command>`](https://technet.microsoft.com/en-us/library/cc753343(v=ws.11).aspx): Management for Active Directory Domain Services
  * [`dsmgmt <Command>`](https://technet.microsoft.com/en-us/library/cc732473(v=ws.11).aspx): Manage AD Lightweight Directory Services paritions
* [`net accounts /domain`](https://technet.microsoft.com/en-us/library/bb490698.aspx): Windows XP  Accounts and Login Requirements Database
  * [`net user`](https://technet.microsoft.com/en-us/library/cc771865(v=ws.11).aspx) is the more general version
* [`net localgroup`](https://technet.microsoft.com/en-us/library/cc725622(v=ws.11).aspx): Display and Modify Groups
* [`cacls`](https://technet.microsoft.com/en-us/library/bb490872.aspx): Modify ACL for Folders
* [`dir`](https://technet.microsoft.com/en-us/library/cc755121(v=ws.11).aspx): Directory Info
* [`sfc`](https://technet.microsoft.com/en-us/library/ff950779(v=ws.11).aspx): Scan Vital Files and Replace if Needed
* `sigverif`: File Signature Verification?
  * [`sigcheck`](https://technet.microsoft.com/en-us/sysinternals/bb897441.aspx): SysInternals Tool for File Information
* 
