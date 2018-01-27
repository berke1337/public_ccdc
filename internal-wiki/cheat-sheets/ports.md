## Well-known ports

The port numbers in the range from 0 to 1023 are the ''well-known ports'' or ''system ports''. They are used by system processes that provide widely used types of network services. On Unix-like operating systems, a process must execute with superuser privileges to be able to bind a network socket to an IP address using one of the well-known ports.


| Port | TCP | UDP | Description | Status|
|------|-----|-----|-------------|-------|
| 0   | n/a | n/a | In programming APIs (not in communication between hosts), requests a system-allocated (dynamic) port | n/a
| 0   | TCP | UDP | Reserved | Official
| 1   | TCP | UDP | TCP Port Service Multiplexer (TCPMUX). Historic. Both TCP and UDP have been assigned to TCPMUX by IANA, | Official
| 4   | TCP | UDP | Unassigned | Official
| 5   | TCP | UDP | Remote job entry | Official
| 6   | TCP | UDP | Unassigned | Official
| 7   | TCP | UDP | Echo Protocol | Official
| 8   | TCP | UDP | Unassigned | Official
| 9   |     | UDP | Wake-on-LAN | Unofficial
| 10  | TCP | UDP | Unassigned | Official
| 11  | TCP | UDP |  Active Users (Systat (protocol)|systat service) | Official
| 12  | TCP | UDP | Unassigned | Official
| 13  | TCP | UDP | Daytime Protocol | Official
| 14  | TCP | UDP | Unassigned | Official
| 15  | TCP | UDP | Previously netstat service | Unofficial
| 16  | TCP | UDP | Unassigned | Official
| 17  | TCP | UDP | QOTD|Quote of the Day (QOTD) | Official
| 18  | TCP | UDP | Message Send Protocol | Official
| 19  | TCP | UDP | Character Generator Protocol (CHARGEN) | Official
| 20  | TCP | UDP | File Transfer Protocol (FTP) data transfer | Official
| 21  | TCP | UDP | File Transfer Protocol (FTP) control (command) | Official
| 22  | TCP | UDP | Secure Shell (SSH), secure logins, file transfers (secure copy|scp, SSH file transfer protocol|sftp) and port forwarding | Official
| 23  | TCP | UDP | Telnet protocol—unencrypted text communications | Official
| 25  | TCP | UDP | Simple Mail Transfer Protocol (SMTP), used for email routing between mail servers | Official
| 26  | TCP | UDP | Unassigned | Official
| 37  | TCP | UDP | Time Protocol | Official
| 38  | TCP | UDP | Route Access Protocol (RAP)Importance inline|date=October 2016 | Official
| 39  | TCP | UDP | Resource Location Protocol (RLP)Importance inline|date=September 2016—used for determining the location of higher level Service (systems architecture)|services from Host (network)|hosts on a Computer network|network | Official
| 40  | TCP | UDP | Unassigned | Official
| 42  | TCP | UDP | ARPA Host Name Server Protocol|Host Name Server Protocol | Official
| 43  | TCP | UDP | WHOIS protocol | Official
| 49  | TCP | UDP | TACACS+ Login Host protocolUpdate inline|?=yes|date=September 2016|reason=As of to date, there is ongoing work on publishing a new TACACS standard at IETF under draft document draft-ietf-opsawg-tacacs. | Official
| 50  | TCP | UDP | Remote Mail Checking ProtocolImportance inline|date=September 2016 | Official
| 51  |  |  | Reserved | Official
| 51  | TCP | UDP | Previously Interface Message Processor logical address managementCitation needed|date=October 2016 | Unofficial
| 52  | TCP | UDP | Xerox Network Systems (XNS) Time ProtocolImportance inline|date=October 2016 | Official
| 53  | TCP | UDP | Domain Name System (DNS) | Official
| 54  | TCP | UDP | Xerox Network Systems (XNS) clearinghouseImportance inline|date=October 2016 | Official
| 56  | TCP | UDP | Xerox Network Systems (XNS) authenticationImportance inline|date=October 2016 | Official
| 57  | TCP | UDP | Any private terminal accessElucidate|date=October 2016 | Official
| 58  | TCP | UDP | Xerox Network Systems (XNS) MailImportance inline|date=October 2016 | Official
| 67  | TCP | UDP | Bootstrap Protocol (BOOTP) server; also used by Dynamic Host Configuration Protocol (DHCP) | Official
| 68  | TCP | UDP | Bootstrap Protocol (BOOTP) client; also used by Dynamic Host Configuration Protocol (DHCP) | Official
| 69  | TCP | UDP | Trivial File Transfer Protocol (TFTP) | Official
| 70  | TCP | UDP | Gopher (protocol)|Gopher protocol | Official
| 71–74  | TCP | UDP | NETRJS protocol | Official
| 75  | TCP | UDP | Any private dial out serviceElucidate|date=October 2016 | Official
| 77  | TCP | UDP | Any private Remote job entryElucidate|date=October 2016 | Official
| 79  | TCP | UDP | Finger protocol | Official
| 80  | TCP | UDP | Hypertext Transfer Protocol (HTTP) | Official
| 80  |     | UDP | QUIC (from Chromium (web browser)|Chromium) for HTTP | Unofficial
| 81  |     |     | Unassigned | Official
| 81  | TCP |     | TorPark onion routingVerify source|date=October 2016 | Unofficial
| 82  |     | UDP | TorPark controlVerify source|date=October 2016 | Unofficial
| 87  |     |     | Any private terminal linkElucidate|date=October 2016 | Official
| 88  | TCP | UDP | Kerberos (protocol)|Kerberos authentication system | Official
| 90  | TCP | UDP | PointCast (dotcom)Third-party inline|date=October 2016 | Unofficial
| 99  | TCP |     | WIP message protocolVerify source|date=October 2016 | Unofficial
| 100 |     |     | Unassigned (with known unauthorized useElucidate|date=October 2016)<!-- Previous list item for port 100 was "CyberGate RAT protocol" --> | Official
| 102 | TCP | UDP | International Organization for Standardization|ISO Transport Service Access Point (TSAP) Class 0 protocol; | Official
| 105 | TCP | UDP | CCSO Nameserver | Official
| 107 | TCP | UDP | Rtelnet|Remote User Telnet Service (RTelnet) | Official
| 108 | TCP | UDP | IBM Systems Network Architecture (SNA) gateway access server | Official
| 109 | TCP | UDP | Post Office Protocol, version 2 (POP2) | Official
| 110 | TCP | UDP | Post Office Protocol, version 3 (POP3) | Official
| 111 | TCP | UDP | Open Network Computing Remote Procedure Call ('''ONC RPC''', sometimes referred to as '''Sun RPC''') | Official
| 113 | TCP |     | Ident protocol|Ident, authentication service/identification protocol, used by Internet Relay Chat|IRC servers to identify users | Official
| 113 | TCP | UDP | Authentication Service (auth), the predecessor to ''identification protocol''. Used to determine a user's identity of a particular TCP connection. | Official
| 114 |     |     | Unassigned (deprecated since June 2004) | Official
| 115 | TCP | UDP | Simple File Transfer Protocol | Official
| 117 | TCP | UDP | UUCP Mapping Project (path service)Citation needed|date=October 2016 | Official
| 118 | TCP | UDP | Structured Query Language (SQL) ServicesTechnical statement|date=October 2016 | Official
| 119 | TCP | UDP | Network News Transfer Protocol (NNTP), | Official
| 123 | TCP | UDP | Network Time Protocol (NTP), used for time synchronization | Official
| 126 | TCP | UDP | Formerly Unisys Unitary Login, renamed by Unisys to NXEdit. Used by Unisys Programmer's Workbench for Clearpath MCP, an IDE for Unisys MCP programming languages|Unisys MCP software development | Official
| 135 | TCP | UDP | Distributed Computing Environment|DCE Communication endpoint|endpoint resolution | Official
| 135 | TCP | UDP | Microsoft EPMAP (End Point Mapper), also known as DCE/Remote procedure call|RPC Locator service, used to remotely manage services including DHCP server, Domain Name System|DNS server and Windows Internet Name Service|WINS. Also used by Distributed Component Object Model|DCOM | Official
| 137 | TCP | UDP | NetBIOS Name Service, used for name registration and Name resolution (computer systems)|resolution | Official
| 138 | TCP | UDP | NetBIOS Datagram Service | Official
| 139 | TCP | UDP | NetBIOS Session Service | Official
| 143 | TCP | UDP | Internet Message Access Protocol (IMAP), | Official
| 152 | TCP | UDP | Background File Transfer Program (BFTP)Importance inline|date=October 2016 | Official
| 153 | TCP | UDP | Simple Gateway Monitoring Protocol (SGMP), a protocol for remote inspection and alteration of gateway management information | Official
| 156 | TCP | UDP | Structured Query Language (SQL) ServiceTechnical statement|date=October 2016 | Official
| 158 | TCP | UDP | Distributed Mail System Protocol ('''DMSP''', sometimes referred to as '''Pcmail''')Importance inline|date=October 2016 | Official
| 161 | TCP | UDP | Simple Network Management Protocol (SNMP)Citation needed|reason=Please add citations for SNMPv2 and SNMPv3 protocols.|date=October 2016 | Official
| 162 | TCP | UDP | Simple Network Management Protocol Trap (SNMPTRAP)Citation needed|reason=Please add citations for SNMPv2 and SNMPv3 protocols.|date=October 2016 | Official
| 170 | TCP | UDP | Print serverVerify source|date=October 2016 | Official
| 177 | TCP | UDP | X Display Manager Control Protocol (XDMCP), used for remote logins to an X Display Manager serverSelf-published inline|certain=yes|date=October 2016 | Official
| 179 | TCP | UDP | Border Gateway Protocol (BGP), used to exchange routing and reachability information among Autonomous system (Internet)|autonomous systems (AS) on the Internet | Official
| 194 | TCP | UDP | Internet Relay Chat (IRC) | Official
| 199 | TCP | UDP | SNMP multiplexing protocol (SMUX)Importance inline|date=October 2016 | Official
| 201 | TCP | UDP | AppleTalk Routing Maintenance | Official
| 209 | TCP | UDP | Quick Mail Transfer Protocol | Official
| 210 | TCP | UDP | ANSI Z39.50 | Official
| 213 | TCP | UDP | Internetwork Packet Exchange (IPX) | Official
| 218 | TCP | UDP | Message posting protocol (MPP) | Official
| 220 | TCP | UDP | Internet Message Access Protocol (IMAP), version 3 | Official
| 259 | TCP | UDP | Efficient Short Remote Operations (ESRO) | Official
| 262 | TCP | UDP | Arcisdms | Official
| 264 | TCP | UDP | Border Gateway Multicast Protocol (BGMP) | Official
| 280 | TCP | UDP | http-mgmt | Official
| 300 | TCP |     | ThinLinc Web Access | |Unofficial
| 308 | TCP |     | Novastor Online Backup | Official
| 311 | TCP |     | Mac OS X Server Admin) | Official
| 318 | TCP | UDP | PKIX Time Stamp Protocol (TSP) | Official
| 319 |     | UDP | Precision Time Protocol (PTP) event messages | Official
| 320 |     | UDP | Precision Time Protocol (PTP) general messages | Official
| 350 | TCP | UDP | Mapping of Airline Traffic over Internet Protocol (MATIP) type A | Official
| 351 | TCP | UDP | MATIP type B | Official
| 356 | TCP | UDP | cloanto-net-1 (used by Cloanto Amiga Explorer and VMs) | Official
| 366 | TCP | UDP | On-Demand Mail Relay (ODMR) | Official
| 369 | TCP | UDP | Rpc2portmap | Official
| 370 | TCP |     | codaauth2, Coda authentication server | Official
| 370 |     | UDP | codaauth2, Coda authentication server | Official
| 370 |     | UDP | securecast1, outgoing packets to McAfee|NAI's SecureCast serversAs of|2000 | Official
| 371 | TCP | UDP | ClearCase albd | Official
| 383 | TCP | UDP | HP data alarm manager | Official
| 384 | TCP | UDP | A Remote Network Server System | Official
| 387 | TCP | UDP | AURP (AppleTalk Update-based Routing Protocol) | Official
| 389 | TCP | UDP | Lightweight Directory Access Protocol (LDAP) | Official
| 399 | TCP | UDP | Digital Equipment Corporation DECnet (Phase V+) over TCP/IP | Official
| 401 | TCP | UDP | Uninterruptible power supply (UPS) | Official
| 427 | TCP | UDP | Service Location Protocol (SLP) | Official
| 433 | TCP | UDP | NNSP, part of Network News Transfer Protocol | Official
| 434 | TCP | UDP | Mobile IP Agent (RFC 5944) | Official
| 443 | TCP | UDP | Hypertext Transfer Protocol over Transport Layer Security|TLS/Secure Sockets Layer|SSL (HTTPS) | Official
| 443 |     | UDP | QUIC (from Chromium) for HTTPS | Unofficial
| 444 | TCP | UDP | Simple Network Paging Protocol (SNPP), RFC 1568 | Official
| 444 | TCP |     | Well known Slither.io port | Unofficial
| 445 | TCP |     | Microsoft-DS Active Directory, Windows shares | Official
| 445 | TCP |     | Microsoft-DS Server Message Block|SMB file sharing | Official
| 464 | TCP | UDP | Kerberos (protocol)|Kerberos Change/Set password | Official
| 465 | TCP |     | URL Rendezvous Directory for SSM (Cisco protocol) | Official
| 465 | TCP |     | Authenticated Simple Mail Transfer Protocol|SMTP over Transport Layer Security|TLS/Secure Sockets Layer|SSL (SMTPS) | Unofficial
| 475 | TCP | UDP | tcpnethaspsrv, Aladdin Knowledge Systems Hasp services | Official
| 491 | TCP |     | GO-Global|GO-Global remote access and application publishing software | Unofficial
| 497 | TCP |     | Retrospect (software)|Dantz Retrospect | Official
| 500 | TCP | UDP | Internet Security Association and Key Management Protocol (ISAKMP) / Internet Key Exchange (IKE) | Official
| 502 | TCP | UDP | Modbus Protocol | Official
| 504 | TCP | UDP | Citadel/UX|Citadel, multiservice protocol for dedicated clients for the Citadel groupware system | Official
| 510 | TCP | UDP | FirstClass Protocol (FCP), used by FirstClass client/server groupware system | Official
| 512 | TCP |     | Remote Process Execution|Rexec, Remote Process Execution | Official
| 512 |     | UDP | comsat, together with Biff (computing)|biff | Official
| 513 | TCP |     | rlogin | Official
| 513 |     | UDP | Who | Official
| 514 | TCP |     | Remote Shell, used to execute non-interactive commands on a remote system (Remote Shell, rsh, remsh) | Official
| 514 |     | UDP | Syslog, used for system logging | Official
| 515 | TCP |     | Line Printer Daemon protocol|Line Printer Daemon (LPD), print service | Official
| 517 |     | UDP | Talk | Official
| 518 |     | UDP | NTalk | Official
| 520 | TCP |     | efs, extended file name server | Official
| 520 |     | UDP | Routing Information Protocol (RIP) | Official
| 521 |     | UDP | Routing Information Protocol#RIPng|Routing Information Protocol Next Generation (RIPng) | Official
| 524 | TCP | UDP | NetWare Core Protocol (NCP) is used for a variety things such as access to primary NetWare server resources, Time Synchronization, etc. | Official
| 525 |     | UDP | Timed, Timeserver | Official
| 530 | TCP | UDP | Remote procedure call (RPC) | Official
| 531 | TCP | UDP | AOL Instant Messenger | Unofficial
| 532 | TCP |     | netnews | Official
| 533 |     | UDP | netwall, For Emergency Broadcasts | Official
| 540 | TCP |     | Unix-to-Unix Copy Protocol (UUCP) | Official
| 542 | TCP | UDP | commerce (Commerce Applications) | Official
| 543 | TCP |     | klogin, Kerberos (protocol)|Kerberos login | Official
| 544 | TCP |     | kshell, Kerberos (protocol)|Kerberos Remote shell | Official
| 545 | TCP |     | OSIsoft PI (VMS), OSISoft PI Server Client Access | Unofficial
| 546 | TCP | UDP | DHCPv6 client | Official
| 547 | TCP | UDP | DHCPv6 server | Official
| 548 | TCP |     | Apple Filing Protocol (AFP) over Transmission Control Protocol|TCP | Official
| 550 | TCP | UDP | new-rwho, new-who | Official
| 554 | TCP | UDP | Real Time Streaming Protocol (RTSP) | Official
| 556 | TCP |     | Remotefs, Remote File System|RFS, rfs_server | Official
| 560 |     | UDP | rmonitor, Remote Monitor | Official
| 561 |     | UDP | monitor | Official
| 563 | TCP | UDP | NNTP over Transport Layer Security|TLS/Secure Sockets Layer|SSL (NNTPS) | Official
| 564 | TCP |     | 9P (protocol)|9P (Plan 9 from Bell Labs|Plan 9) | Unofficial
| 585 | N/a | N/a | De-registeredWhen|date=October 2016 (with recommendation to use port 993 instead) | Official
| 585 | TCP | Dunno | Legacy use of Internet Message Access Protocol over Transport Layer Security|TLS/Secure Sockets Layer|SSL (IMAPS) | Unofficial
| 587 | TCP |     | Mail submission agent|email message submission (Simple Mail Transfer Protocol|SMTP) | Official
| 591 | TCP |     | FileMaker 6.0 (and later) Web Sharing (HTTP Alternate, also see port 80) | Official
| 593 | TCP | UDP | HTTP RPC Ep Map, Remote procedure call over Hypertext Transfer Protocol, often used by Distributed Component Object Model services and Microsoft Exchange Server | Official
| 601 | TCP |     | Reliable Syslog Service — used for system logging | Official
| 604 | TCP |     | TUNNEL profile, a protocol for BEEP Peer-to-peer|peers to form an application layer Tunneling protocol|tunnel | Official
| 623 |     | UDP | ASF Remote Management and Control Protocol (ASF-RMCP) & IPMI Remote Management Protocol | Official
| 625 | TCP |     | Open Directory Proxy (ODProxy) | Unofficial
| 631 | TCP | UDP | Internet Printing Protocol (IPP) | Official
| 631 | TCP | UDP | Common Unix Printing System (CUPS) administration console (extension to IPP) | Unofficial
| 635 | TCP | UDP | RLZ DBase | Official
| 636 | TCP | UDP | Lightweight Directory Access Protocol over Transport Layer Security|TLS/Secure Sockets Layer|SSL (LDAPS) | Official
| 639 | TCP | UDP | MSDP, Multicast Source Discovery Protocol | Official
| 641 | TCP | UDP | SupportSoft Nexus Remote Command (control/listening), a proxy gateway connecting remote control traffic | Official
| 643 | TCP | UDP | SANity | Official
| 646 | TCP | UDP | Label Distribution Protocol (LDP), a routing protocol used in Multiprotocol Label Switching|MPLS networks | Official
| 647 | TCP |     | Dynamic Host Configuration Protocol|DHCP Failover protocol | Official
| 648 | TCP |     | Registry Registrar Protocol (RRP) | Official
| 651 | TCP | UDP | IEEE-MMS | Official
| 653 | TCP | UDP | SupportSoft Nexus Remote Command (data), a proxy gateway connecting remote control traffic | Official
| 654 | TCP |     | Media Management System (MMS) Media Management Protocol (MMP) | Official
| 655 | TCP | UDP | Tinc (protocol)|Tinc VPN daemon | Official
| 657 | TCP | UDP | IBM RMC (Remote monitoring and Control) protocol, used by IBM System p|System p5 IBM AIX (operating system)|AIX Integrated Virtualization Manager (IVM) and IBM Hardware Management Console|Hardware Management Console to connect managed LPAR|logical partitions (LPAR) to enable dynamic partition reconfiguration | Official
| 660 | TCP |     | Mac OS X Server administration, | Official
| 666 | TCP | UDP | Doom (game)|Doom, first online first-person shooter | Official
| 666 | TCP |     | [http://www.aircrack-ng.org/doku.php?id=airserv-ng airserv-ng], aircrack-ng's server for remote-controlling wireless devices | Unofficial
| 674 | TCP |     | Application Configuration Access Protocol (ACAP) | Official
| 688 | TCP | UDP | REALM-RUSD (ApplianceWare Server Appliance Management Protocol) | Official
| 690 | TCP | UDP | Velneo Application Transfer Protocol (VATP) | Official
| 691 | TCP |     | Microsoft|MS Microsoft Exchange Server|Exchange Routing | Official
| 694 | TCP | UDP | Linux-HA high-availability heartbeat | Official
| 695 | TCP |     | IEEE Media Management System over Transport Layer Security|SSL (IEEE-MMS-SSL) | Official
| 698 |     | UDP | Optimized Link State Routing protocol|Optimized Link State Routing (OLSR) | Official
| 700 | TCP |     | Extensible Provisioning Protocol (EPP), a protocol for communication between domain name registry|domain name registries and domain name registrar|registrars (RFC 5734) | Official
| 701 | TCP |     | Link Management Protocol (LMP), a protocol that runs between a pair of Node (networking)|nodes and is used to manage Teletraffic engineering|traffic engineering (TE) Telecommunications link|links | Official
| 702 | TCP |     | IRIS (RFC 3983) | Official
| 706 | TCP |     | SILC (protocol)|Secure Internet Live Conferencing (SILC) | Official
| 711 | TCP |     | Cisco Tag Distribution Protocol | Official
| 712 | TCP |     | Topology Broadcast based on Reverse-Path Forwarding routing protocol (TBRPF; RFC 3684) | Official
| 749 | TCP | UDP | Kerberos (protocol) administration | Official
| 750 |     | UDP | kerberos-iv, Kerberos (protocol)|Kerberos version IV | Official
| 751 | TCP | UDP | kerberos_master, Kerberos (protocol)|Kerberos authentication | Unofficial
| 752 |     | UDP | passwd_server, Kerberos (protocol)|Kerberos password (kpasswd) server | Unofficial
| 753 | TCP |     | Reverse Routing Header (RRH) | Official
| 753 |     | UDP | Reverse Routing Header (RRH) | Official
| 753 |     | UDP | userreg_server, Kerberos (protocol)|Kerberos userreg server | Unofficial
| 754 | TCP |     | tell send | Official
| 754 | TCP |     | krb5_prop, Kerberos (protocol)|Kerberos v5 slave propagation | Unofficial
| 754 |     | UDP | tell send | Official
| 760 | TCP | UDP | krbupdate [kreg], Kerberos (protocol)|Kerberos registration | Unofficial
| 782 | TCP |     | Conserver serial-console management server | Unofficial
| 783 | TCP |     | SpamAssassin spamd daemon | Unofficial
| 800 | TCP | UDP | mdbs-daemon | Official
| 808 | TCP |     | Microsoft Net.TCP Port Sharing Service | Unofficial
| 829 | TCP |     | Certificate Management Protocol| Unofficial
| 830 | TCP | UDP | NETCONF over Secure Shell|SSH | Official
| 831 | TCP | UDP | NETCONF over BEEP| Official
| 832 | TCP | UDP | NETCONF for SOAP over HTTPS | Official
| 833 | TCP | UDP | NETCONF for SOAP over BEEP | Official
| 843 | TCP |     | Adobe Flash| Unofficial
| 847 | TCP |     | Dynamic Host Configuration Protocol#Reliability|DHCP Failover protocol | Official
| 848 | TCP | UDP | Group Domain Of Interpretation (GDOI) protocol | Official
| 853 | TCP | UDP | Domain Name System|DNS over Transport Layer Security|TLS (RFC 7858) | Official
| 860 | TCP |     | iSCSI (RFC 3720) | Official
| 861 | TCP | UDP | OWAMP control (RFC 4656) | Official
| 862 | TCP | UDP | TWAMP control (RFC 5357) | Official
| 873 | TCP |     | rsync file synchronization protocol | Official
| 888 | TCP |     | cddbp, CD database|CD DataBase (CDDB) protocol (CDDBP) | Unofficial
| 888 | TCP |     | IBM Endpoint Manager Remote Control | Unofficial
| 897 | TCP | UDP | Brocade Communications Systems|Brocade SMI-S RPC | Unofficial
| 898 | TCP | UDP | Brocade Communications Systems|Brocade SMI-S RPC SSL | Unofficial
| 902 | TCP | UDP | VMware ESXi | Unofficial
| 903 | TCP |     | VMware ESXi | Unofficial
| 914-988 | |     | Unassigned | Official
| 944 |     | UDP | Network File System ServiceCitation needed|date=October 2016 | Unofficial
| 953 | TCP |     | BIND remote name daemon control (RNDC) | Unofficial
| 981 | TCP |     | Remote HTTPS management for firewall devices running embedded Check Point VPN-1 software | Unofficial
| 987 | TCP |     | Microsoft Windows SBS SharePointCitation needed|date=October 2016 | Unofficial
| 989 | TCP | UDP | FTPS Protocol (data), FTP over Transport Layer Security|TLS/Secure Sockets Layer|SSL | Official
| 990 | TCP | UDP | FTPS Protocol (control), FTP over Transport Layer Security|TLS/Secure Sockets Layer|SSL | Official
| 991 | TCP | UDP | Netnews Administration System (NAS) | Official
| 992 | TCP | UDP | Telnet protocol over Transport Layer Security|TLS/Secure Sockets Layer|SSL | Official
| 993 | TCP |     | Internet Message Access Protocol over Transport Layer Security|TLS/Secure Sockets Layer|SSL (IMAPS) | Official
| 994 | TCP | UDP | Reserved | Official
| 994 | TCP | UDP | Internet Relay Chat over Transport Layer Security|TLS/Secure Sockets Layer|SSL (IRCS) | Unofficial
| 995 | TCP |     | Post Office Protocol 3 over Transport Layer Security|TLS/Secure Sockets Layer|SSL (POP3S) | Official
| 1010| TCP |     | ThinLinc web-based administration interfaceSelf-published inline|date=October 2016 | Unofficial
| 1023| TCP | UDP | Reserved | Official
