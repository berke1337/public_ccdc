#!/bin/sh

# Make sure we have bro-cut available.
PATH=/opt/bro/bin:$PATH

archive='/var/bro/logs/2013-03-30'
current='/var/bro/logs/current'

echo '<html>'
echo '<body>'
echo '<h1>Top-5 Attacker Statistics</h1>'
echo '<p>This page lists various connection-level information about blocked hosts, ports, and HTTP attacks. In all reports, the <em>first</em> column represents the number of connections and the <em>second</em> column a piece of evidence gathered from our Bro IDS logs.</p>'

echo '<h2>Top 5 Blocked Hosts</h2>'
echo '<p>The hosts below are attacker IP addresses blocked by our firewall.</p>'
echo '<pre>'
zcat -f $(ls $archive/conn*gz | tail -1) $current/conn.log \
  | bro-cut id.orig_h id.resp_h conn_state \
  | awk '$1 ~ /10\.1[23]/ && $2 != "10.10.9.132" && $3 ~/REJ|S0/ { print $1 }' \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -n 5
echo '</pre>'

echo '<h2>Top 5 Blocked Ports</h2>'
echo '<p>The hosts below show attacker TCP ports blocked at our firewall.</p>'
echo '<pre>'
zcat -f $(ls $archive/conn*gz | tail -1) $current/conn.log \
  | bro-cut id.orig_h id.resp_p conn_state \
  | awk '$1 ~ /10\.1[23]/ && $3 ~/REJ|S0/ { print $2 }' \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -n 5
echo '</pre>'

echo '<h2>Top 5 HTTP Attacks</h2>'
http=/tmp/http-forensics.log
zcat -f $archive/http*gz $current/http.log \
  | bro-cut -d ts id.orig_h id.resp_h uri user_agent \
  > $http

echo '<h3>Directory Traversal</h3>'
echo '<pre>'
awk '$4 ~ /\.\.\/\.\.\// { print $4 }' $http \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -n 3
awk '$5 ~ /DirBuster/ { print $4 }' $http \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -n 2
echo '</pre>'

echo '<h3>Cross-Site Scripting (XSS)</h3>'
echo '<pre>'
awk '$4 ~ /<script>./ { print $4 }' $http \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -n 5 \
  | sed -e 's/<script>/\&lt;script\&gt;/'
echo '</pre>'

echo '<h3>Command Injection (XSS)</h3>'
echo '<pre>'
awk -F'\t' '$3 ~ /10\.10\.9/ && $4 !~ /serverInfo/ && $4 ~ /cmd=|echo./ { print $4 }' $http \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -n 5
echo '</pre>'
echo '</body>'
echo '</html>'

rm -f /tmp/http-forensics.log
