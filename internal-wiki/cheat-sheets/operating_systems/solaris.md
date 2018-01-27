# Solaris

## History, Overview
Solaris is a Unix operating system originally developed by Sun Microsystems. It superseded their earlier SunOS in 1993. Oracle Solaris, so named as of 2010, has been owned by Oracle Corporation since the Sun acquisition by Oracle in January 2010.
At some point, Sun open-sourced parts of Solaris as OpenSolaris. Oracle discontinued the OpenSolaris project. It has been forked as illumos. OpenIndiana is a popular illumos distribution.

## OpenIndiana
### Package Management
The package manager is `pkg`.

### Networking
* Show interfaces: `dladm show-ether`
* Rename interface: `dladm rename-link rtls0 eth0 `
* Setup DHCP: `ipadm create-addr –T dhcp eth0/v4dhcp `

### Service Management
* restart service: `svcadm restart ssh`
