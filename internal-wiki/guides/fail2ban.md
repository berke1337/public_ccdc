# Fail2ban

Fail2ban scans log files (e.g. /var/log/apache/error_log) and bans IPs that show
malicious signs -- too many password failures, seeking for exploits, etc.
Generally Fail2Ban is then used to update firewall rules to reject the IP
addresses for a specified amount of time, although any arbitrary other action
(e.g. sending an email) could also be configured. Out of the box Fail2Ban comes
with filters for various services (apache, courier, ssh, etc).

In the competition, fail2ban helps reducing the noise produced by red team
activity, especially automated scanning.
The red team probably will not heavily rely on online password bruteforcing but
we have seen automated vulnerability scans on web applications in the past.

fail2ban relies on __python__.
