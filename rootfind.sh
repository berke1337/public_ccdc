#!/bin/bash

# combs through /etc/
dirnames=("/etc/apache" "/etc/httpd" "/etc/lighttpd" "/etc/nginx")
keywords=("Alias" "Location" "root")
logname="./webroots.txt"
rm $logname
touch $logname

for d in "${dirnames[@]}"; do
	echo "checking for $d"
	printf "***$d:***\n\n" >> $logname
	if [ -d $d ]; then
		echo "Found directory for $d"
		echo "Found directory $d" >> $logname
		for kw in "${keywords[@]}"; do
			echo "Grepping through for $kw"
			printf "\n  **grep results for $kw:\n" >> $logname
			grep -A1 -i -r $kw $d | sed 's/^/    /g' >> $logname
		done
	else
		echo "No dir found for $d" >> $logname
	fi
	printf "\n\n" >> $logname
done;

echo
echo "Search for *** for application delimeters"
echo "Search for ** for specific grep keywords."
