# Centralized Logging
TODO: Nicer UI; one that actually may be useful for incident reports (i.e. ELK?)

For CCDC, Centralized Logging generally means setting up syslog environment with a Linux machine in the center,
though it should be one that is user friendly.

## Data Collectors and Forwarders
### Linux
#### rsyslog server
Install `rsyslog`, and then on the server side, add these lines to
`/etc/rsyslog.conf` to enable listening on UDP and TCP (both port 514 for
convenience):

    # Listen on UDP
    module(load="imudp")
    input(type="imudp" port="514")

    # Listen on TCP
    module(load="imtcp")
    input(type="imtcp" port="514")

    # Put remove logs into their own directory based on hostname
    $template RemoteLog, "/var/log/remote/%HOSTNAME%.log"
    :inputname, isequal, "imtcp" ?RemoteLog
    :inputname, isequal, "imudp" ?RemoteLog

### rsyslog Client
Install the `rsyslog` package, and then add this line to the rsyslog config
(probably located at `/etc/rsyslog.conf`. Make sure you know the IP of the
syslog server set up in the previous part:

    *.* @@<ip or domain name of syslog server>:514

Also make sure the hostname of the client is set to something reasonable, not
`localhost` or something weird, since that is what the server will use to put
the logs in the right place.


## Windows
| Product | Notes |
| ------- | ----- |
| [Event Log Forwarder](http://www.solarwinds.com/free-tools/event-log-forwarder-for-windows) | Used in 2017; no dependencies |
| [OSSEC](https://ossec.github.io/index.html) | Untested; Windows can only send |
| [Logstash](https://www.elastic.co/products/logstash) | Untested |
| [Splunk](https://www.splunk.com/) | Installation Issues; try again later |
| [rsyslog Windows Agent](http://www.rsyslog.com/windows-agent/about-rsyslog-windows-agent/) | Used in 2017; depends on .NET 3.5 |

