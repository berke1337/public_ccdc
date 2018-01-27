# Version Control with git

Hosting configuration files in git helps not only to smoothly roll-back
configuration changes (possibly malicious ones), but also provides a backup in
case of data loss.

### Create a central repository (with creating a user)

```bash
adduser git
mkdir /backups
chown git:git /backups
su git
git init --bare /backups
```

### Put a directory under version control

```bash
# Can be done right away
cd /
git init
git checkout -b $HOSTNAME
git add $DIRS
git commit -m 'Initial import of $HOSTNAME'

# After central repo has been set up
git remote add origin ssh://git@$GITHOST/backups
git fetch origin
git push origin HEAD
```

When you change files in a version controlled directory, make sure to commit
_and_ push the changes. Also make sure to periodically fetch from origin so that
the backups are distributed across our network.
