#!/bin/sh

# short url for this file: bash <(curl -sL https://goo.gl/DyNqxK)
# alternative: https://t0b.pw/chpasswd.sh

passfile=passwords.txt
passfile_csv=passwords.csv

list="alpha bravo charlie"
list=`awk -F':' '{ if ( $7 !~ "nologin" && $7 !~ "false" ) print $1 }' "/etc/passwd"`

rm -f $passfile
rm -f $passfile_csv

for user in $list
  do
    if  ! grep -w ^$user /etc/passwd > /dev/null
    then
      echo "user NOT present: $user"
    else
      read -p "Include $user in password change list? [y/n]" -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
        pass=$(</dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c16)
        echo "$user:$pass">>$passfile
        echo "$user,$pass">>$passfile_csv
      fi
    fi
done
cat $passfile | chpasswd
