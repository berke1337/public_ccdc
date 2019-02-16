**Secure AD domain controllers and DNS servers first**

### Acronyms and Common Items
* ADUC: [Active Directory Users and Computers](https://technet.microsoft.com/en-us/library/cc754217(v=ws.11).aspx)
  * Domain Controller only. Either in Server Manager options, or clip-on using MMC.
* GPM: [Group Policy Management Console](https://technet.microsoft.com/en-us/library/cc753298(v=ws.11).aspx)
  * Usually Domain Controller. Run `gpmc.msc`, or find under Admin. Tools 
* LSP: [Local Security Policy](https://technet.microsoft.com/en-us/library/dn135243(v=ws.10).aspx)
  * Non-Domain only. Run `secpol.msc`, or find under Admin. Tools
* MMC: [Microsoft Management Console](https://technet.microsoft.com/en-us/library/cc709659(v=ws.11).aspx)
  * Run `mmc.msc`
* SysInternals: Referring the the Suite of Tools, it ranges from more detailed looks at processes to networking information to logging

### Physical Tampering
* Check all ports for malicious tampering (USBs, dongles)
  * If given choice, use wired keyboard?
* Check surroundings for wireless devices

### User accounts
* Change Administrator password
  * i.e. CTRL-ALT-DELETE
    * Failures may result from bad configuration in LSP or GPM.
* Change other passwords
  * Must do in either MMC's Local Users and Groups or ADUC
    * If competition requires notification, do so first to make sure passwords are not the reason for downtime
  * Try `%SystemRoot%\system32\control userpasswords2`?
* Check User Privileges and Groups
  * Add users to Protected Users (against Mimikatz)
  * Disable all unnecessary/unrequired user accounts
    * `net user <username> /active:no` or AD Users and Groups interface
  * Remove admin privileges wherever possible
    * `net localgroup administrators <username> /delete` or ADUC
  * Later want to check other groups, some of which have limited admin priv
    * E.g., Cryptographic Operators, Network Configuration Operators, Power Users
* If possible, in LSP or GPM:
  * Rename administrator
  * Disable Guest 
  * **Set Important Policies**

### Patching
* ms08_067 https://support.microsoft.com/en-us/kb/958644
* ms09_050 http://support.microsoft.com/kb/975518
* KB2871997 https://support.microsoft.com/en-us/kb/2871997
* Explore BatchPatch, WSUS Offline Update, WSUS Later

### Firewall and Program/Services
* Verify Firewall is Running
  * Do so in GPM or in Control Panel
* Verify exceptions are only for necessary services and minimum ports
* For Necessary Services (i.e. SQL Server, Web Apps, IIS/Apache/nginx):
  * Remove unnecessary accounts
  * Change default passwords
* For Unnecessary Services (e.g. VNC, RDP, telnet, fileshares, *FTP, etc.):
  * Suspend using Process Explorer (SysInternals) before deletion
  * Control Panel's Programs and Features (incl. Windows Features)
  * Admin. Tools has Services, Server Manager (for roles)
  * [Revo Uninstaller?](http://www.revouninstaller.com/revo_uninstaller_free_download.html)
  * [CCleaner?](https://www.piriform.com/ccleaner/download)
* Verify Port Usage
  * Use [nmap](https://nmap.org/download.html)
  * `netstat -abno`
  * TCPview (SysInternals)

### Re-verify Program Details
* Task Manager (CTRL-ALT-DEL) or Process Explorer (SysInternals)
* [System Configuration](https://support.microsoft.com/en-us/help/950093/how-to-use-the-system-configuration-utility-to-troubleshoot-configuration-errors-in-windows-vista) (`msconfig`) or 'Master Control Panel' (`explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}`)
* [File Ownership](https://www.saotn.org/powershell-find-files-owned-user/)?
* Make sure all Program Files* Directories are checked

### Malware and Viruses
* Microsoft Defender works fine for Windows 8+
* Windows MSE for Windows 7+
* Malwarebytes for others or for overkill
* [Microsoft Security Scanner](https://www.microsoft.com/security/scanner/en-us/default.aspx) (overkill)

### Other Things
* [EMET](https://support.microsoft.com/en-us/kb/2458544), but has a .NET v4 requirement
* [OSSEC](http://ossec.github.io/), though Windows only act as clients
* Syslog/Centralized Logging: See Centralized Logging Guide
* [Nessus](https://www.tenable.com/products/nessus-home) if there is much spare time
* Microsoft Baseline Security Analyzer, Microsoft Security Assessment Tool, Microsoft Security Compliance Manager
* [CIS-CAT](https://learn.cisecurity.org/cis-cat-landing-page) for Windows 10
* Wireshark, Snort, Bro?
* Edit Registry
  * In `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurityProviders\WDigest`, set `UseLogonCrednetial` to 0.

### Active Directory
* GPO, file system encryption, DNS, remote access, Exchange, SharePoint, etc…
* Forest > Trees > Domains
* Domains can be grouped into organizational units (OUs), but placing objects in OUs doesn’t necessarily assign the OUs right to the object
* Document what you have
  * Be aware of admin users/groups in forests and trees, not just domains
  * Distribution of admin accounts
    * Multiple admin accounts that perform diff tasks is ideal
    * Realistically, each admin user has a diff account
*  Reset DSRM password
* IPsec?
* Under GPO:
  * Audit logons (esp failed), policy changes, account management, and object access
  * Disable LM hash storage, NTLM v2 and refuse LM and NTLM
* Windows Server Backup

### Playbook
Link to the github: https://github.com/berke1337
Checklist for hardening Windows 2008 Server: https://www.utsa.edu/oit/ImagesAndPDF/PDF2/server_hardening_checklist_win_2008r2.pdf


Steps to harden the system:

Sign in and change the admin VM password
Send the ctrl+alt+delete and reset password to new password
Turn on the firewall (two ways)
Go to firewall settings and turn it on from there
Method a may not work due to group policy access permissions. If so, use an admin command prompt and run
Type netsh advfirewall set allprofiles state on. [1] to turn on the firewall
Type netsh advfirewall show allprofiles to show the firewall status
Start installing and running updates on the machine -> may need to restart the machine so want to do this as early as possible so as to minimize service interruptions
If updates need to wait then apply specific patches to cover areas 
Run password changing script 
[TODO] also see if you can write a script to de-escalate privileges (remove admin privileges from  every account except Admin cred then manually confirm the rest of the privileges, also remove all guest account from the device)
Submit password changes in password change form 
Go through programs installed on the computer and remove/isolate the programs and disable them from being run 
Start changing firewall rules
Still need to determine exactly which ports need to stay open for both inbound and outbound traffic
Netstat -ab 
Netstat –an –b | find /I “’Listening”
IP address in normally given so can run NMAP scan
Follow steps to redirect UDP traffic from dynamic ports to port 135 
Follow security setting steps on the Hardening checklist
Add all the devices to the active directory and give all users access through 

For script we have:

# short url for this file: bash <(curl -sL https://goo.gl/DyNqxK)
# alt link https://t0b.pw/chpasswd.sh


http://techgenix.com/domain-controllers-required-ports/
https://blogs.msmvps.com/acefekay/2011/11/01/active-directory-firewall-ports-let-s-try-to-make-this-simple/

https://support.microsoft.com/en-us/help/224196/restricting-active-directory-rpc-traffic-to-a-specific-port


https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd772723(v=ws.10)


Patch for ms08-067:
https://docs.microsoft.com/en-us/security-updates/securitybulletins/2008/ms08-067



Check what ports are open:

Netstat -ab 
Netstat –an –b | find /I “’Listening”
         


Hardening steps:
https://www.utsa.edu/oit/ImagesAndPDF/PDF2/server_hardening_checklist_win_2008r2.pdf



Change user pwd via command line
admin cmd
net user  -> gets you all users
net user USERNAME NEWPASS


### Links:
* [O'Reilly Books](http://proquest.safaribooksonline.com/); must be in Berkeley IP zone
* [Windows 2008 Checklist](https://utsacloud-public.sharepoint.com/Pages/Security/PDF/Server_Hardening_Checklist_Win_2008R2.pdf) from UT Austin
* [Windows 2012 Checklist](https://wikis.utexas.edu/display/ISO/Windows+Server+2012+R2+Hardening+Checklist) from UT Austin
* https://technet.microsoft.com/en-us/library/cc526440.aspx
* https://technet.microsoft.com/en-us/magazine/2006.05.smarttips
* https://technet.microsoft.com/library/Bb727032
* https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-ds/plan/security-best-practices/reducing-the-active-directory-attack-surface

