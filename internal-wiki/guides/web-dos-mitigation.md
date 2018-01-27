# Web Denial of Service Attack Mitigation

To be honest, I have no idea. So asked the firewall admin for help! Here is what
I found on the internet:

* Set Apache `MaxClients` to ~100 (default is 256. 256 processes might be too
  much to handle for the system)
* Apache `KeepAlive Off` (default is On)
* Disable compression `sudo a2dismod deflate` on Debian/Ubuntu and on other just
  edit the `httpd.conf`
* Apache `LimitXMLRequestBody 10485760`

Revise these apache settings:
```
# wait up to 300 seconds for slow clients
TimeOut 300
# allow connections to be reused between requests
KeepAlive On
# allow a maximum of 100 requests per connection
MaxKeepAliveRequests 100
# wait up to 15 seconds for the next
# request on an open connection
KeepAliveTimeout 15
# impose no limits on the request body
LimitRequestBody 0
# allow up to 100 headers in a request
LimitRequestFields 100
# each header may be up to 8190 bytes long
LimitRequestFieldsize 8190
# the first line of the request can be
# up to 8190 bytes long
LimitRequestLine 8190
# limit the XML request body to 1 million bytes(Apache 2.x only)
LimitXMLRequestBody 1000000
# keep 5 servers ready to handle requests
MinSpareServers 5
# do not keep more than 10 servers idle
MaxSpareServers 10
# start with 5 servers
StartServers 5
# allow a max of 150 clients at any given time
MaxClients 150
# allow unlimited requests per server
MaxRequestsPerChild 0
```
