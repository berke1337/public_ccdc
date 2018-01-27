#!/bin/sh

truth=/usr/lib/bin
out=/var/lib/log
server=10.0.0.1
port=12345

echo "$(hostname) $0 $@" >> $out &
#echo "$(hostname) $0 $@" | nc $server $port &
PATH="$truth:$PATH" exec "$(basename "$0")" "$@"
