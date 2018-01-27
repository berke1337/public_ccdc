# Apache Hardening

* Check global config in `/etc/apache*/httpd.conf or /usr/local/etc/apache*/httpd.conf`
* Disable SSI (Server Side Includes), if the web apps are not _super_ legacy and might need it:
  *	Look for the following lines and disable them:
```
#AddOutputFilter INCLUDES .shtml
#XBitHack on
#Options +Includes
```
* The option `Includes` should be disabled everywhere
* Check installed modules: the statically compiled with `httpd -l` and for
  dynamically loaded: `apachectl -M`. The minimal install has only `core.c`,
  `mod_so.c`, and `http_core.c` statically compiled. If there are more,
  check them!
* Check all sub-config files that are include in the httpd.conf
* Make sure the following is set in httpd.conf:
```
	<Directory />
		AllowOverride None
		Require all denied
		Options None
		Order deny,allow
		Deny from all
	</Directory>

	## allow access to specific dirs (check dirs!)
	<Directory "/usr/local/www/apache24/data">
		Require all granted
	</Directory>

	## should be default
	<Files ".ht*">
		Require all denied
	</Files>
```
* `Options` should never contain `Indexes` (this would enable directory listing)
* `ServerTokens Prod` - dont give away version number in header
* `Header set Server "Microsoft-IIS/5.0"` - make the red team laugh


## mod_security
More info on mod_security can be found here: https://www.feistyduck.com/library/apache-security/online/apachesc-CHP-12.html

* Check if it is loaded: `apachectl -M | grep --color security`.
* Otherwise install: `apt-get install libapache2-mod-security` /
  `yum install mod_security` / `pkg install www/mod_security`
* Now install the rule sets:
```
cd $APACHE_CONFIG_DIR
mkdir modsecurity
cd modsecurity
git clone https://github.com/SpiderLabs/owasp-modsecurity-crs crs
fetch https://raw.github.com/SpiderLabs/ModSecurity/master/unicode.mapping
cp crs/modsecurity_crs_10_setup.conf.example modsecurity_crs_10_setup.conf
```

* Edit the modsecurity config file:
```
<IfModule security2_module>
	  # Include ModSecurity configuration
	  Include modsecurity/modsecurity.conf

	  # Include OWASP Core Rule Set (CRS) configuration and base rules
	  Include modsecurity/modsecurity_crs_10_setup.conf
	  Include modsecurity/crs/base_rules/*.conf

    SecDebugLog "/var/log/modsec_audit.log"
    SecDebugLogLevel 5
    SecRuleEngine DetectionOnly

		SecRequestBodyAccess On
		SecResponseBodyAccess On
		SecRequestBodyLimit 13107200 ## this is 12.5MB
		SecServerSignature "Microsoft-IIS/5.0" #make the red team laugh

	  # Add custom configuration and CRS exceptions here. Example:
	  # SecRuleRemoveById 960015

    SecAuditLogParts ABCFHZ
</IfModule>
```

* Let the webapps run for a while to catch false positives in `/var/log/modsec_audit.log`. Resolve them.
* When everything looks good, switch `SecRuleEngine On`


### modsec.conf
```
[Definition]
failregex = \[.*?\]\s[\w-]*\s<HOST>\s
ignoreregex =
```

## Paranoid considerations
* Compile Apache statically to prevent dynamic loading of malicious modules.
* Isolate all web applications. For each one, install a separate apache in a
  chroot and setup nginx as a reverse proxy to redirect to the right apache
  instances.
