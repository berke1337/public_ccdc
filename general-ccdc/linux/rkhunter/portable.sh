# To run this, run this as root: <busybox path> sh portable.sh <busybox path> 
# This script needs to be run in the directory that comes from unzipping rkhunter (usually called rkhunter-1.4.0)
# Additionally, the rkhunter.conf file needs to be moved in to the files/ directory in that same folder
# Upon running this, it will move all of rkhunter's necessary files in to /tmp and set up the required variables so it runs without installing all over the system
# Then, rkhunter is instructed to check all critical system commands and runs an app scan as well (looks for old versions)
# rkhunter is now available in your path for more intensive checks
$1 rm -rf /tmp/rkhunter
$1 mkdir -p /tmp/rkhunter
$1 mkdir -p /tmp/rkhunter/tmp
$1 mkdir -p /tmp/rkhunter/db
$1 chmod 700 /tmp/rkhunter
$1 cp -r files /tmp/rkhunter
$1 cp -r files/i18n /tmp/rkhunter/db/
$1 ln -s /tmp/rkhunter/files/rkhunter.conf /etc/rkhunter.conf
$1 ln -s /tmp/rkhunter/files/rkhunter /usr/bin/rkhunter
rkhunter --update
rkhunter --rwo --enable system_commands,apps
