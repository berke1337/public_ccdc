# Windows Hardening

1. Check for physical tampering
   * Look for keyloggers on mouse/keyboard cabling
   * Look for sources of interference (tape under mouse, poor ethernet cables)
2. Change passwords
3. Get a safe toolchain
   * Download Sys Interals Suite
     (http://download.sysinternals.com/files/SysinternalsSuite.zip)
      * Download with PowerShell if browser unavailable (hacksheet)
   * Scan running processes with Process Explorer
      * Show signatures and image paths (hacksheet)
   * Check autoruns with Autoruns tool
      * Verify code signatures and hide Microsoft entries (hacksheet)
   * Run a virus scan (Malwarebytes Anti-Malware:
     http://downloads.malwarebytes.org/mbam-download.php)
4. Harden network
   * Windows Server: activate Windows Firewall in block mode and only allow
     ports of required services (LDAP, DNS, Web) (hacksheet)
   * Windows XP: Stop known vulnerable services (Server service is necessary,
     don't stop it) (also see Seconfig XP at
     http://seconfig.sytes.net/getfile.php) (hacksheet)
   * Patch ms08_067 and ms09_050 immediately
      * Patch for ms08_067_netapi:
        http://www.microsoft.com/en-us/download/details.aspx?id=3205
      * Patch for ms09_050: http://support.microsoft.com/kb/975517
   * Check for suspicious connections using TCPView or the command line
     (hacksheet)
      * http://live.sysinternals.com/tools/Tcpview.exe if not already downloaded
      * Look first at LISTENING connections and associated processes
      * Then sort by “Remote Address” and look for suspicious connections
   * Nmap scan from a unix host to verify firewall status externally
5. Look for other users on the machine
   * PsLoggedonUsers
   * Task Manager to disconnect (hacksheet)
6. Lock down
   * Inspect local user accounts on system (hacksheet)
   * Determine if joined to a domain
   * Disable ipv6 (hacksheet)
   * Install OSSEC
   * Install [EMET](http://support.microsoft.com/kb/2458544):
     http://technet.microsoft.com/en-us/security/jj653751
