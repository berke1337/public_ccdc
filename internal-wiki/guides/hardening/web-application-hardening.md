# Web Application Hardening

!!Patch all installed web apps if possible!! If they are EOL (end of life),
google for patches regardless. Often there are community-supplied patches for
the many vulnerabilities still.

## General stuff
```bash
nikto -host 10.0.0.1
```

## Common Web Applications and Hardening them

### Joomla
http://web.site/administrator/ is the `admin` interface.


## mod_security

### Install

Debian:

```bash
apt-get install libapache2-modsecurity modsecurity-crs
a2enmod mod_security
```

RHELs:

```bash
yum install mod_security mod_security_crs
```

### Lock down
Completely fail on rule match:

```bash
# In rules directory:
find . -name "*.conf" -print | xargs sed -i 's/phase:[0-9]/phase:1/g'
```

Custom enhancements (in a conf):
```
SecRuleEngine On
SecRequestBodyAccess On
SecResponseBodyAccess On
SecResponseBodyMimeType text/plain text/html text/xml

SecArgumentSeparator &

SecAuditEngine RelevantOnly
SecAuditLogRelevantStatus "^(?:5|4(?!04))"
SecAuditLogParts ABIJDEFHZ
SecAuditLogType Serial
SecAuditLog /var/log/modsec_audit.log
```

## Apache Reverse Proxy
If the web server on the box is something other than Apache, in order to protect
it, the easiest way is to run mod_security on Apache and reverse proxy through
it to the other web server.

1. Install Apache
2. Move the existing web server to a different port (8080 will be used for this
   guide)
3. Add the following to your apache config (in /etc/httpd or /etc/apache2)
```
ProxyPass / http://localhost:8080/
ProxyPassReverse / http://localhost:8080/
```

If the proxied site is SSL, then you have to find the key files, and add this as
well:
```
SSLEngine On
SSLProxyEngine On
SSLCertificateFile $CERTIFICATE.crt
SSLCertificateKeyFile $KEY.key
SSLProtocol all -SSLv2
SetEnvIf User-Agent ".*MSIE.*" nokeepalive ssl-unclean-shutdown
```
