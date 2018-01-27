# Firewall Quickstart
## Good Stuff to Know
### [IPv4 Address Ranges For Private Networks](https://tools.ietf.org/html/rfc5735)
Block the following ranges on public interfaces:
* 10.0.0.0/8 (A)
* 172.16.0.0/12 (B)
* 192.168.0.0/16 (C)
* 224.0.0.0/4 ("D"/Multicast)
* 240.0.0.0/5 ("E")
* 127.0.0.0/8 (Loopback)

## [Linux - nftables](https://wiki.nftables.org/wiki-nftables/index.php/Main_Page)
nftables is supposed to replace the other *tables programs. Its syntax seems easier to deal with.

Matches: See man page. Basically descriptions that can apply to packets.

Statements
* Log (level {emerg, alert, ... })
* Reject
* Limit
* Nat
* Drop
* Accept

> List Current Tables
  ```bash
  nft list tables {ip, arp, ip6, bride, inet, netdev}
  ```

> List Current Chains
  ```bash
  nft list chain (table)
  ```

> List Current Rules
  ```bash
  nft list chain {table} {chain}
  ```

> Rule Creation
  ```bash
  nft add rule {ip, arp, ...} {table} {chain} {match} {statement}
  ```


## [Linux - iptables](http://linux.die.net/man/8/iptables)
iptables is a user-space application program that allows a system administrator to configure the tables provided by the Linux kernel firewall (implemented as different Netfilter modules) and the chains and rules it stores. Different kernel modules and programs are currently used for different protocols; iptables applies to IPv4, ip6tables to IPv6, arptables to ARP, and ebtables to Ethernet frames.

### [CentOS Instructions](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/sec-Using_Firewalls.html#sec-Using_iptables)
CentOS (or RHEL) uses [firewalld](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-7) by default, so follow these commands to switch to iptables.
  ```bash
  systemctl disable firewalld  
  systemctl stop firewalld  
  yum install iptables-services  
  systemctl start iptables  
  systemctl enable iptables  
  service iptables save  
  ```

### Definitions
* __Chains:__ Lists of rules applicable to packets, ordered.
* __Targets:__ What to do when a rule is matched. It is specified by `-j` or `--jump`. Targets include user-defined chains, special "extensions" such as auditing or editing, __ACCEPT__ to let packet through, __DROP__, and __RETURN__ to break chain progression.
* __Tables:__ Contains packet filter rules. There are always at least five present. __filter__ contains chains for packets going to local sockets (__INPUT__), routed to others (__FORWARD__), or locally-generated (__OUTPUT__). __nat__ deals with new connections for __PREROUTING__, __OUTPUT__, and __POSTROUTING__. There is also __mangle__ for packet alteration, __security__ for Mandatory Access Control, and __raw__ for special usage. 

### Important Commands
__Note:__ Commands missing -t arguments use the __filter__ table by default. Similarly, not specifying the chain will try to apply the command onto all chains in the default table.
     
  ```bash
  iptables -L --line-numbers
  ```
> List rules from all chains, marked with rules' positions on chain

  ```bash
  iptables -F
  ```
> Deletes rules from all chains in table

  ```bash
  iptables -N *chain*
  ```
> Creates new chain *chain*
     
  ```bash
  iptables -X
  ```
> Deletes user-defined chain only if chain has no rules.

  ```bash
  iptables -P *chain* *target*
  ```
> Sets policy for chain *chain* to target *target*.


### Examples

Delete 4th rule form chain INPUT?
  ```bash
  iptables -D INPUT 4
  ```
or
  ```bash
  iptables -D INPUT -s 202.54.1.1 -j DROP
  ```

Block 202.54.1.1?
  ```bash
  iptables -A INPUT -s 202.54.1.1 -j DROP
  ```

[Logging](http://ipset.netfilter.org/iptables-extensions.man.html)?
  ```bash
  iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j LOG --log-prefix "IP_SPOOF A: "
  ```

[Restrict number of active connections to 5](http://ipset.netfilter.org/iptables-extensions.man.html)?

  ```bash
  iptables -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 5 -j REJECT
  ```


### Loading Rules

1. List firewall rules

  ```bash 
  iptables-save | tee iptables.rules
  ```

2. Edit the file you created in the last step to lock it down, or start from
   scratch. Here is an example file:

  ```
# Drop incoming packets by default
*filter
:INPUT DROP
:FORWARD DROP
:OUTPUT ACCEPT

  # Allow established connections
# If conntrack is supported use this:
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
# Otherwise use
# -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

  # Allow pings to this box
-A INPUT -p icmp -j ACCEPT

  # Allow traffic on loopback
-A INPUT -i lo -j ACCEPT

  # For each port you want to open (i.e. ssh)
-A INPUT -p tcp --dport 22 -j ACCEPT

  # Save rules
COMMIT
```

3. Load the firewall rules you just created
  ```bash 
  iptables-restore < iptables.rules
  ```

## [Solaris - ipf](https://docs.oracle.com/cd/E23824_01/html/821-1453/euqex.html)

1. List active rules
  ```bash
  ipfstat -io
  ```

2. Create a file to store firewall rules, here is an example:
  ```
  # Allow all traffic on loopback.
pass in quick on lo0 all
pass out quick on lo0 all

  # Allow all out, including incoming packets from established connections
pass out quick keep state

  # Allow pings in
pass in quick proto icmp keep state

  # Allow certain ports (i.e. ssh)
pass in quick proto tcp from any to any port = 22 keep state

  # Drop incoming packets by default
block in all
```

3. Load rules
  ```bash
  # Make sure ipfilter is enabled
  svcadm enable network/ipfilter
  # Load rules
  ipf -Fa -f ipf.rules
  ```
