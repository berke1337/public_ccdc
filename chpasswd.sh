#!/bin/sh
# setpass

passfile=passwords.txt
passfile=passwords.txt
>$passfile

list="alpha bravo charlie"

list=awk -F':' '{ if ( $7 !~ "nologin" && $7 !~ "false" ) print $1 }' "/etc/passwd"

for user in $list
 do
   if  ! grep -w ^$user /etc/passwd > /dev/null
   then
    echo "user NOT present: $user"
  else
   echo "user present: $user"
  pass=$(pwgen 16 1)
  echo "$user:$pass">>$passfile
 fi
done
cat $passfile | chpasswd
