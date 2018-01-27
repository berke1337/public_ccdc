# auditd
## Installation
CentOS, RHEL, Fedora, etc.: Usually already installed. If not, do `yum install audit audit-libs`.

Debian/Ubuntu: `apt-get install auditd audispd-plugins`

## Rules
are located in `/etc/audit/rules.d/`
* List rules: `auditctl -l`
* Delete rules: `auditctl -D`
* reload rules: `auditctl -R /etc/audit/audit.rules`
* Watch a file: `auditctl -a exit,always -F path=/etc/passwd -F perm=wa`
  * Permissions: r = read, w = write, x = execute, a = attribute change
* Find events related to file access: `ausearch -f /etc/passwd`
  * Interesting fields: __auid__ is the userid of the logged in user performing the action. __exe__ is the executable used for this action.
* lookup syscall ids `ausyscall x86_64 188`
* restrict rule to userid `-F auid=80`
* Man page: `man audt.rules`


# Our Rule set
## basic rule set
```
# available keys: ps, critical, high, medium, low
# ps: process creation, fork, and network access. For forensic use.
# critical: needs urgent attention, needs to be monitored at all times
# high: highly suspicious behavior, should be regularly monitored
# medium: suspicious behavior, look at this when time allows
# low: important events that do not need to be monitored but important enough to log for later investigation in case of compromise

# Delete any preexisting rules before starting to define new ones.
-D

# Set the number of buffers to take the audit messages. Depending on the level of audit logging on your system, increase or decrease this figure.
-b 8192

# Set the failure flag to use when the kernel needs to handle critical errors. Possible values are 0 (silent), 1 (printk, print a failure message), and 2 (panic, halt the system).
-f 2

# watch forks and network activity under key ps
-a always,exit -F arch=b64 -S execve -S vfork -S fork -S clone -S exit -S exit_group -S connect -S bind -S sendto -k ps
-a always,exit -F arch=b32 -S execve -S vfork -S fork -S clone -S exit -S exit_group -S socketcall -k ps

# Enable an audit context for any linking operation, such as symlink, link, unlink, or rename.
-a always,exit -F arch=b64 -S unlink -S rename -S link -S symlink  -k high
-a always,exit -F arch=b32 -S unlink -S rename -S link -S symlink  -k high

# Enable an audit context for any operation related to extended file system attributes.
-a always,exit -F arch=b64 -S setxattr -k high
-a always,exit -F arch=b64 -S lsetxattr -k high
-a always,exit -F arch=b64 -S fsetxattr -k high
-a always,exit -F arch=b64 -S removexattr -k high
-a always,exit -F arch=b64 -S lremovexattr -k high
-a always,exit -F arch=b64 -S fremovexattr -k high

# Enable an audit context for the mknod system call, which creates special (device) files.
-a always,exit -F arch=b64 -S mknod -k high

# More high impact Watches by tobi
-w /etc/passwd -p wa -k critical
-w /etc/shadow -k critical
-w /etc/group -p wa -k critical
-w /etc/sudoers -k critical
-w /etc/sudoers.d/ -p wa -k critical

# More medium impact watches by tobi
-w /bin/ -p wa -k medium
-w /boot/ -p wa -k medium
-w /etc/ -p wa -k medium
-w /lib/ -p wa -k medium
-w /opt/ -p wa -k medium
-w /root/ -p wa -k medium
-w /sbin/ -p wa -k medium
-w /srv/ -p wa -k medium
-w /usr/ -p wa -k medium

# no executables in /tmp/
-w /tmp/ -p x -k high


# Adjust those lines to the system at hand!
# make sure not to include dirs for cache files
-w /var/www/ -p wa -k medium
```
Short-link: http://bit.do/auditd

# ausearch
`ausearch` is a tool to query audit daemon logs.
* `ausearch -f /etc/passwd` - search for event corresponding to specific file
* `ausearch -k critical` - search for key
* `ausearch -ts recent` - all events in last 10 minutes
* `ausearch -ts 15:10` - all events since 3.10pm

# Visualization
## auditps.rb
* get it: `git clone https://github.com/jethrogb/audittools.git`
* install ruby `yum install ruby`
* run: `ausearch -r -k ps|./auditps.rb|less -S`, where the 0:0 specifies a time
## other ways
Look at https://www.suse.com/documentation/sled10/audit_sp1/data/app_audit_mkbar.html
