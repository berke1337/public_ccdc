firewall {
    family inet {
        replace:
        /*
        ** $Id: ./nccdc14.jcl $
        ** $Date: 2014/04/24 $
        **
        ** ingress filter
        */
        filter edge-inbound {
            interface-specific;
            term permit-icmp {
                from {
                    protocol icmp;
                }
                then {
                    accept;
                }
            }
            term permit-voip {
                from {
                    protocol icmp;
                }
                then {
                    accept;
                }
            }
            term permit-mail {
                from {
                    destination-address {
                        10.66.66.10/32; /* mail, blog: Fedora - Mail, POP3, HTTP */
                    }
                    protocol tcp;
                    destination-port 25;
                }
                then {
                    accept;
                }
            }
            term permit-pop3 {
                from {
                    destination-address {
                        10.66.66.10/32; /* mail, blog: Fedora - Mail, POP3, HTTP */
                    }
                    protocol tcp;
                    destination-port 110;
                }
                then {
                    accept;
                }
            }
            term permit-dns {
                from {
                    destination-address {
                        10.66.66.4/32; /* dns: Windows 2012 - DNS */
                        172.16.66.201/32; /* n/a: NetBSD */
                    }
                    protocol udp;
                    destination-port 53;
                }
                then {
                    accept;
                }
            }
            term permit-http {
                from {
                    destination-address {
                        10.66.66.4/32; /* dns: Windows 2012 - DNS */
                        172.16.66.204/32; /* n/a: Debian */
                    }
                    protocol tcp;
                    destination-port 80;
                }
                then {
                    accept;
                }
            }
            term permit-https {
                from {
                    destination-address {
                        10.66.66.20/32; /* store: Windows 2008 - IIS */
                    }
                    protocol tcp;
                    destination-port 443;
                }
                then {
                    accept;
                }
            }
            term permit-ssh {
                from {
                    destination-address {
                        10.66.66.21/32; /* sql: BSD - MySQL, SSH */
                    }
                    protocol tcp;
                    destination-port 22;
                }
                then {
                    accept;
                }
            }
            term permit-minecraft {
                from {
                    destination-address {
                        172.16.66.202/32; /* n/a: Ubuntu */
                    }
                    protocol tcp;
                    destination-port 25565;
                }
                then {
                    accept;
                }
            }
            term permit-unreal-tournament {
                from {
                    destination-address {
                        172.16.66.203/32; /* n/a: Mandriva */
                    }
                    protocol udp;
                    destination-port [ 7777-7783 27900 ];
                }
                then {
                    accept;
                }
            }
            term permit-moh {
                from {
                    destination-address {
                        172.16.66.210/32; /* n/a: Windows XP */
                    }
                    protocol udp;
                    destination-port [ 12203-12218 12300 23000-23009 ];
                }
                then {
                    accept;
                }
            }
            term permit-quake2 {
                from {
                    destination-address {
                        172.16.66.211/32; /* n/a: Windows Vista */
                    }
                    protocol [ tcp udp ];
                    destination-port 27910;
                }
                then {
                    accept;
                }
            }
            term permit-ventrilo {
                from {
                    destination-address {
                        172.16.66.212/32; /* n/a: Solaris */
                    }
                    protocol [ tcp udp ];
                    destination-port 3784;
                }
                then {
                    accept;
                }
            }
            term permit-teamspeak {
                from {
                    destination-address {
                        172.16.66.213/32; /* n/a: Windows 2003 */
                    }
                    protocol [ tcp udp ];
                    destination-port 8767;
                }
                then {
                    accept;
                }
            }
            term permit-udp-established {
                from {
                    destination-address {
                        10.66.66.0/24;
                        176.16.66.0/24;
                    }
                    protocol udp;
                    source-port 1024-65535;
                }
                then {
                    accept;
                }
            }
            term default-deny {
                then {
                    discard;
                }
            }
        }
    }
}
firewall {
    family inet {
        replace:
        /*
        ** $Id: ./nccdc14.jcl $
        ** $Date: 2014/04/24 $
        **
        ** egress filter
        */
        filter edge-outbound {
            interface-specific;
            term deny-to-bad-destinations {
                from {
                    destination-address {
                        0.0.0.0/8; /* reserved */
                        10.0.0.0/8; /* non-public */
                        127.0.0.0/8; /* loopback */
                        169.254.0.0/16; /* special use IPv4 addresses -
                                        ** netdeploy */
                        172.16.0.0/12; /* non-public */
                        192.0.0.0/24;
                        192.0.2.0/24;
                        192.18.0.0/15;
                        192.168.0.0/16; /* non-public */
                        198.51.100.0/24;
                        203.0.113.0/24;
                        224.0.0.0/3; /* IP multicast */
                    }
                }
                then {
                    discard;
                }
            }
            term default-accept {
                then {
                    accept;
                }
            }
        }
    }
}
