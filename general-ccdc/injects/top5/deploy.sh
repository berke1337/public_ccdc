#!/bin/sh

dir=/home/angel/ccdc/injects/top5
file=index.html
cd $dir
./top5.sh > $file
scp -i top5 $file root@10.10.9.16:/var/www/top5
rm -f $file
