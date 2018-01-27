# Email (i.e. POP3, SMTP)

## Postfix
The default Mail Transfer Agent in [many](https://wiki.debian.org/Postfix) Linux distributions, Postfix uses Simple Mail Transfer Protocol to do its job. It replaced sendmail in popularity. It can be configured by modifying the `/etc/postfix/main.cf` file. Its status can be verified through Telnet (i.e. `telnet localhost 25`) or nmap (i.e. `nmap -sT -p 25 localhost`)

If starting on scratch and [on Ubuntu](https://help.ubuntu.com/community/Postfix#Configuration), run `sudo dpkg-reconfigure postfix` to get a quick configuration up and running.

### [Configurations](http://www.postfix.org/postconf.5.html)
Should be edited through [postconf](http://www.postfix.org/postconf.1.html), Postfix's configuration utility. 'postconf -e "<name>=<value>' edits main.cf and affects the program after next reload, which can be done as `postfix reload`.

* `mydestination`
    * List of email domains to give mail to. Default $myhostname, localhost.$mydomain, localhost
* `inet_interfaces`
    * Which networks to listen on. Default is all, though some highly restrict it to just localhost.
* `smtpd_client_connection_rate_limit`
    * Max attempts per client per unit time. Default 0.
* `smtpd_client_message_rate_limit`
    * Max delivery requests per client per unit time. Default 0.
* `smtpd_client_event_limit_exceptions`
    * Exclude various networks from limits. Default is $mynetworks


### Aliases
`/etc/aliases` is the file where plaintext [email aliases](https://wiki.debian.org/Postfix#Forward_Emails) can be configured in `<username>: <email>` format. Always run `newaliases` after modifying to update the datahase and run `postfix reload` to refresh the DB with Postfix.

* Note: It doesn't send a local copy back to the server unless the username is also specified on the side with emails.

### [SASL](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/sec-Securing_Services.html#sect-Security_Guide-Securing_Postfix-Configuring_Postfix_to_Use_SASL)
SMTP Authentication can be done by the Dovecot or Cyrus SASL implementations. Dovecot configuration can be found in `/etc/dovecot/conf.d/` with settings like using Unix sockets or TCP sockets. It doesn't encrypt the emails though. That instead can be done using [TLS on Postfix](https://www.sans.org/reading-room/whitepapers/email/protecting-email-hostile-world-tls-postfix-578).

## qmail
Another MTA, most of its configuration can be found in `/var/qmail/control` and in `~<username>/.qmail-*`.

`~<username>/.qmail-*` is used to direct where mail actually goes (`./Mailbox` for mbox, `./Maildir`, `&a@b.com` for forwarding, and `<Username>` for local copy).

### Aliasing
```bash
echo \&<Username> > /var/qmail/alias/.qmail-<Alias>
```

## Dovecot
The most common IMAP and POP3 server

## Roundcube
A browser-based IMAP client.


## Mail-in-a-Box
Running in a Ubuntu 14.04 container, this handles all configuration for a hopefully cheap and fast setup of a mail server with online interface. *Untested*

## Links
### Postfix
* [Ubuntu Community Help Wiki on Postfix](https://help.ubuntu.com/community/Postfix)
* [Arch Wiki on Postfix](https://wiki.archlinux.org/index.php/Postfix)
### qmail
* [Dave Sill's *Life with qmail*](http://www.lifewithqmail.org/lwq.html)
### Dovecot
* [Dovecot 2.0 Documentation](https://wiki2.dovecot.org/)
### Roundcube
* [Roundcube Github Repo](https://github.com/roundcube/roundcubemail)
### Mail-in-a-box
* [Homepage](https://mailinabox.email/)

