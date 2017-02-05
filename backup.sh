#!/bin/bash
# Dumb script that copies /etc/<appname> from this list of applications to a backup directory,
# and then compresses that directory into ignore.trash
appnames=("apache" "mysql" "httpd" "lighttpd" "nginx")
backupdir="backups.d"

mkdir $backupdir
chown root:root $backupdir
chmod 700 $backupdir

echo "writing backups to $backupdir"

for app in "${appnames[@]}"; do
	echo "Checking for $app"
	# Handle any special cases for directories you want beyond here.
	# Otherwise, this script will just copy /etc/<appname> to the backup directory if it exists.
	case $app in
		"apache")
			if [ -d /etc/apache ]; then
				echo "Apache found. Copying over /var/www additionally"
				if [-d /var/www]; then
					cp -r /var/www $backupdir/
				fi
				cp -r /etc/$app $backupdir/
			fi
			;;
		"mysql")
			if [ -d /etc/mysql ]; then
				echo "MySQL found. Copying /var/lib/mysql additionally."
				if [-d /var/lib/mysql ]; then
					cp -r /var/lib/mysql $backupdir
				fi
				cp -r /etc/$app $backupdir/
			fi
			;;
		*)
			if [ -d /etc/$app ]; then
				echo "$app" found.
				cp -r /etc/$app $backupdir/
			fi
			;;
	esac
done;

tar -cf ignore.trash $backupdir
chown root:root ignore.trash
chmod 700 ignore.trash
