# firewallmy.systems
You can setup firewall rules really easily through
`curl http://firewallmy.systems/ipfw/t22/t80/u5000/ | /bin/bash`

```
Usage: firewallmy.systems/FIREWALL/PORTSPEC
  FIREWALL = iptables | pf | ipfw
  PORTSPEC = (t|u|tu|ut)PORTNUMBER [PORTSPEC]
    t for TCP
    u for UDP

The firewalls generated are actually shell scripts that set up those firewalls,
so feel free to pipe the output of this command into bash or something.

Example: generate an iptables firewall script opening TCP 22, 80, and UDP 5000
  firewallmy.systems/iptables/t22/t80/u5000/
```

# Example Printouts
If the website is not available you'll be glad to have these printouts.

http://firewallmy.systems/iptables/t22/t80/u5000/
```
# backup
iptables -S > fms-backup.iptables

# reset
iptables -F

# preamble

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
# Allow loopback
iptables -A INPUT -i lo -j ACCEPT
# Allow pings
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
# Allow open connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# specific rules follow:
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p udp --dport 5000 -j ACCEPT

echo ' >>> DONE! <<<'
```

http://firewallmy.systems/ipfw/t22/t80/u5000/
```
# backup
ipfw list > fms-backup.ipfw

# reset
ipfw -q -f flush

# preamble
ipfw -q add 10 allow all from any to any via lo0
ipfw -q add 20 deny all from any to 127.0.0.0/8
ipfw -q add 30 deny all from 127.0.0.0/8 to any
ipfw -q add 40 deny tcp from any to any frag
ipfw -q add 50 check-state
ipfw -q add 60 allow tcp from any to any established
ipfw -q add 70 allow all from any to any out keep-state
ipfw -q add 80 allow icmp from any to any

# open ports
ipfw -q add 90 allow tcp from any to any 22 in
ipfw -q add 100 allow tcp from any to any 80 in
ipfw -q add 110 allow udp from any to any 5000 in
ipfw -q add 220 deny all from any to any

echo ' >>> DONE! <<<'
```

http://firewallmy.systems/pf/t22/t80/u5000/
```
# backup
pfctl -sr > fms-backup.pf

echo '
set block-policy drop
set skip on lo0
match in all scrub (no-df max-mss 1440)
block in all
block out quick inet6 all
block in quick inet6 all
block in quick from { urpf-failed no-route } to any
pass out quick inet keep state

pass in proto tcp from any to any port 22 flags S/SA synproxy state
pass in proto tcp from any to any port 80 flags S/SA synproxy state
pass in proto udp from any to any port 5000 flags S/SA synproxy state

' > ./fms-firewall-rules.pf

pfctl -f ./fms-firewall-rules.pf

echo ' >>> DONE! <<<'
```
