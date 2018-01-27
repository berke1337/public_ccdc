# Linux Hardening

## General Hardening
Do this first for every \*nix machine!

1. Briefly check for physical tempering (tape under the mouse, raspberry pi under the table, Keyloggers, ... )
1. Change your user password and the root password.
1. Watch out for suspicious aliases
  * List all set aliases with `alias`.
1. Look at history for different users: `history` or `~/.bash_history`
1. __Inventory__
  * `hostname`
  * `cat /proc/version` (might say RedHat instead of CentOS)
  * or `uname -a`
  * `lsb_release -a` (not available everywhere)
1. __Firewall off__ the system except for ports that are in use
    * Get a list of ports you need to keep open
      * `netstat -plunt` for listening ports
      * `netstat -punt` for open connections. It does not show UDP connections. Can not reliably detect short-lived connections as well.
      * At this stage, you might want to leave some ports open when you are not sure about whether they are being used. Come back later and close them when you know more.
    * Use firewallmy.system, e.g.
      `curl http://firewallmy.systems/iptables/t22/t80/u5000/ | /bin/bash`
        * __Warning__: Rules are only appended. So check all rules with `iptables -L --line-numbers` after running this. Delete rules, e.g. `iptables -D INPUT 4` to delete the 4th input rule.
1. __System Exploration__
  * look at `getent passwd`, `getent group`, `getent shadow`, `/etc/sudoers`
  * __change all user account passwords__: `bash <(curl -sL https://t0b.pw/chpasswd.sh)`
  * `ps auxww | less`, if output is not too noisy
  * `netstat -punt`
  * Check for installed SSH keys: `bash <(curl -sL https://t0b.pw/ssh-key-list.sh)`
  * Check DNS resolver `less /etc/resolv.conf`
  * if running webserver, find webroots: `bash <(curl -sL https://goo.gl/aKdZTI)`
  * (Optional) check package sources `/etc/apt/sources.list` or  `/etc/yum.repos.d/*` and the sub-directories. For other package managers see OS-overview.md.
1. __Change passwords__ for __all__ services. This includes all mysql users, all web applications, etc.
  * Do this carefully. Do not overlook any service.
  * For WebApps it is a good idea to first just __disable__ admin accounts, as changing their passwords would take too much time. Do that by prepending `000_` to the password hash.
  * By now you should have a detailed overview of which services are running on the machine. Pay particular attention to which services might be dangerous, which services might get scored and which services might be critical for other services to function properly.
  * Uninstall/kill any unnecessary services.
1. Setup __basic auditing__
      * Create a list of processes so that we can diff it later.
        * `mkdir /root/normal/ && cd /root/normal/ && git init`
        * `ps auxww > ps.txt`
        * `netstat -plunt > netstat-plunt.txt`
        * `netstat -punt > netstat-punt.txt`
        * `git add * && git commit`
      * put the following directories in version control:
        * `cd /etc/`, `git init`, `git add *`, `git commit`
          * /etc/
          * /home/
          * /var/www or other web application folders
1. __>>>BACKUP DATA<<<__
  * see backup guide
1. check __setuid/setgid__ files and make list of valid ones. `find / -user root -perm /6000 -exec ls -ldb {} \; 2>/dev/null`
1. __restrict crontab__
    * remove crontab completely if not needed: `service crontab stop`, might also be called `cron` or `crond`
    * Otherwise disable crontab for users other than root:
      * `rm /etc/cron.deny /etc/at.deny`
      * `echo "root" > /etc/cron.allow`
      * `chmod 600 /etc/cron.allow`
      * `echo "root" > /etc/at.allow`
      * `chmod 600 /etc/at.allow`
1. __Harden__
  * __On older systems:__ Enable Data Execution Prevention (DEP) and ASLR. If the files do not exist, DEP and ASLR are probably already activated by default. Not needed for FreeBSD.
        * `echo 1 > /proc/sys/kernel/exec-shield`,
        * `echo 2 > /proc/sys/kernel/randomize_va_space`
        * `/etc/sysctl.conf`: `kernel.exec-shield = 1` and `kernel.randomize_va_space = 2`.
  * Disable IPv6
      * `sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1`
      * `sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1`
      * `/etc/sysconfig/network`: `NETWORKING_IPV6=no`, `IPV6INIT=no`
1. Run __lynis__. Good way to be assured we did not overlook something important.
    * `git clone https://github.com/CISOfy/lynis`
    * `./lynis/lynis audit system`, note down relevant system information
      * option `--reverse-colors` helpful for bright terminals
1. __Update__ internet-facing software. Including website software like Roundcube, Joomla, Wordpress, zen-cart, etc. These web-apps are known to have lots of RCEs.
1. Check if __system package upgrades__ are available: `apt-get upgrade --dry-run`, `yum check-update`

__Now is a good time to switch to a different machine. Continue here later__

## Second priority

1. Double-check that all default credentials have been changed.
  * Think of Users in WebApps, E-Mail users managed through a database, any VMs that might be running, etc.
1. __Privilege separation__
    * Check under which privileges exposed services are running.
    * Check file permissions of sensitive data. And permissions of scripts, including web software (e.g. `/var/www/`).
1. (Optional) configure __auditd__. Therefore see cheat-sheets/auditd.md
1. Make logs append-only: `chattr +a /var/log/foo`
1. Harden host-specific applications
    * PHP (very important)
    * Web Applications
      * If they are older than a few month there is usually a remote code execution exploit available. Update web applications if possible. If not possible, consider mod_security.
    * Webserver
    * Databases
    * etc.
1. Harden SSH
  ```
  vi /etc/ssh/sshd_config
  Protocol 2
  AllowUsers root admin webmaster
  AllowGroup sshusers
  PasswordAuthentication no
  HostbasedAuthentication no
  RSAAuthentication yes
  PubkeyAuthentication yes
  PermitEmptyPasswords no
  PermitRootLogin no
  ServerKeyBits 2048
  IgnoreRhosts yes
  RhostsAuthentication no
  RhostsRSAAuthentication no
  ```

## Things to consider when enough time
1. Get a safe toolchain
  * Download busybox: http://packetstormsecurity.com/files/125705/Busybox-Statically-Compiled-With-Ash.html
    * Mirror under https://github.com/berke1337/public_ccdc
    * Short link: __ http://bit.do/busyboxtar __
  * `tar xf busyboxtar && cd busybox && chmod u+x busybox64`
  * see available commands `./busybox64 | less`
  * Get Almquist shell: `PATH='' ./busybox64 ash`
1. Secure mount options
```
in /etc/fstab
	set "nosuid,noexec,nodev" for
		/tmp
		/var/tmp
		/var/log
		/var/log/audit
		/var/www
	set "nosuid" for
		/var
```
1. check PAM configuration (very system dependent). Good place to start is `/etc/pam.d/common-auth`.
