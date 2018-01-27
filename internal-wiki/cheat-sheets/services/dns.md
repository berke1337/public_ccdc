# DNS
At worst case/high paranoia, just replace your internal network with filled-in hostfiles, rather than an internal DNS server

## Linux (i.e. BIND/named)
Most DNS operations will be handled in `/etc/named.conf`,`/etc/named/*.zone` and `/etc/resolv.conf`.

### Forwarding
In `named.conf`:
```bash
zone "example.com" IN {
    type forward;
    forwarders { X.X.X.X; };
    forward only;
};
```
* Note: `forward only` may be omitted if lookup doesn't have to use forwarders.

### Master
In zone file for `domain.com`:
```bash
@       IN      SOA     ns1.domain.com. admin.domain.com. (
                                    12083   ; serial number # Don't forget to update this on change
                                    3h      ; refresh interval
                                    30m     ; retry interval
                                    3w      ; expiry period
                                    1h      ; negative TTL
)
www    IN       A       X.X.X.X
```

In `named.conf`:
```bash
zone "domain.com" {
    type master;
    file "/etc/bind/zones/domain.com.zone";
};
```


### ACLs
Before `options`:
#### Allow Only
```bash
acl goodclients {
    X.X.X.X
    X.X.X.X/X;
    localhost;
    localnets;
};
```

#### Allow But
```bash
acl badclients {
    !X.X.X.X;
    !X.X.X.X/X;
    any;
};
```

* localnets tries to guess current subnet using given IP address and subnet mask.
* Can shorten subnet (i.e. X/X, X.X/X, X.X.X/X)
* Can nest ACLs in other ACLs
* `none` and `any` are base ACLs

Then in `options`:
```bash
options {
        ...
        allow-query { goodclients; };
        ...
};
```

* ACLs affect any `allow-` attributes

## Windows
Windows DNS Server (a role found in Server Manager) should be relatively self-intuitive.

### Filtering
DNS servers can restrict who they reply back to with various configurations.
```powershell
dnscmd <ServerName> /ResetListenAddresses [<ListenAddress> ...]
```

### Rate Limiting
Starting from Windows 2016, one can enable rate limiting by using
```powershell
Set-DNSServerRRL
```
One can set exception lists like this (where EQ means equal):
```powershell
Add-DnsServerResponseRateLimitingExceptionlist -Name “SafeList1” -Fqdn “EQ,*.contoso.com”   

Add-DnsServerResponseRateLimitingExceptionlist -Name “SafeInterface” -ServerInterface “EQ,20.0.0.1”
```

## Links
### Linux
* [Zytrax's *DNS for Rocket Scientists*](http://www.zytrax.com/books/dns/)
* [Digital Ocean's *An Introduction to Managing DNS*](https://www.digitalocean.com/community/tutorial_series/an-introduction-to-managing-dns)
* [Digital Ocean's DNS Guides](https://www.digitalocean.com/community/tags/dns?type=tutorials)

### Windows
* [Window Server 2016 DNS](https://technet.microsoft.com/en-us/windows-server-docs/networking/dns/dns-top)
  * [Windows Rate Limiting](https://technet.microsoft.com/itpro/powershell/windows/dnsserver/set-dnsserverresponseratelimiting)
* [Windows Server 2012 DNS](https://technet.microsoft.com/en-us/library/hh831667(v=ws.11).aspx)
* [Windows Server 2008 DNS](https://technet.microsoft.com/en-us/library/cc730921(v=ws.11).aspx)
