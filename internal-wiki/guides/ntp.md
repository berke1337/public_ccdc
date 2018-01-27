# Network Time Protocol (NTP)

## Windows
### [W32tm][w32tm]: Local Time Changes

```powershell
w32tm /config /manualpeerlist:pool.ntp.org /syncfromflags:MANUAL`
Stop-Service w32time
Start-Service w32time
```

* For 2008 and below, may need to append `0x8` to manualpeerlist
* Can force a resync with `w32tm /resync`

[w32tm]: https://technet.microsoft.com/en-us/library/ff799054.aspx

### Group Policy (Copied from [SysAdminLab][SysAL])
* In [Group Policy Management Console][gpmc] (`gpmc.msc`), create WMI Filter for
  PDC Emulator (`Select * from Win32_ComputerSystem where DomainRole = 5`)
* Create GPO with
  `Comp Config/Policies/Admin Temp/System/Win Time Serv/Time Prov`
* Assign it to PDC Emulator

[gpmc]: https://technet.microsoft.com/en-us/library/cc754347(v=ws.11).aspx
[SysAL]: http://www.sysadminlab.net/windows/configuring-ntp-on-windows-using-gpo

## Linux
### Install NTP client/server

First install ntp with `apt-get install ntp` or `yum install ntp` or whatever
it is based on your OS's package manager. On recent versions of Linux,
`timedatectl` and `timesyncd` replace `ntpdate` and `ntpd`. Check the status of
`timedatectl` with `timedatectl status`, which will also show if NTP is being
used in place of `timedatectl` with the `NTP synchronized: yes` line.

#### Manual

To check the system time, run `date`, which will show the current date and time
of the system. It is useful to do this before syncing, so that you can tell
that the time has actually been updated successfully.

To manually sync time, run `sudo ntpdate <ntp server IP>`.

#### Automatic (recommended, since it's probably an inject at some point)

Edit `/etc/ntp.conf` (`/etc/systemd/timesyncd.conf` if using `timedatectl`) and
add the server to sync from (probably will want a local server, since that's a
common inject before setting up centralized logging in another inject). The NTP
server will want to synchronize from somewhere else that isn't local:

    # For the NTP server
    server us.pool.ntp.org

or

    # For NTP clients
    server <local server>

To provide an NTP server, additionally add this line: `restrict 192.168.1.0
mask 255.255.255.0 nomodify notrap` with the IP and mask adjusted accordingly
so that only hosts within the local network can access the server (read-only
too). In total, make sure these lines are on the NTP server (the two last lines
should be included by default):

    # Permit time synchronization with our time source, but do not
    # permit the source to query or modify the service on this system.
    restrict <subnet IPs> mask <subnet mask> nomodify notrap
    restrict default kod nomodify notrap nopeer noquery
    restrict -6 default kod nomodify notrap nopeer noquery

Make sure the `ntp` or `ntpd` service is running and enabled to start on boot so
that clients can connect to it. NTP's status can be checked on the server with
`sudo ntpq -p`.

### Set timezone

* Ubuntu/Debian/CentOS 7+: `sudo timedatectl set-timezone America/Los_Angeles`
* CentOS 6: `ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime`
