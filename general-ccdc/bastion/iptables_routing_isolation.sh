#!/bin/sh

# Our team number.
# Used to compute 3rd octet in public IPs.
team=4

hush() {
  "$@" > /dev/null
  #echo $*
}

nat() {
  EXT_IF=eth0
  IF=$2
  NAME=$1
  B=${3##*.}
  INT_IP=172.21.$3
  EXT_IP=192.168.$((100 + $team)).$B
  LOC_IP=172.21.$B.2
  LOC_RT=172.21.$B.1/30
  echo -A POSTROUTING -o $EXT_IF -s $LOC_IP -m comment --comment $NAME -j SNAT --to-source $EXT_IP
  echo -A POSTROUTING            -s $LOC_IP -m comment --comment $NAME -j SNAT --to-source $INT_IP
  echo -A PREROUTING             -d $INT_IP -m comment --comment $NAME -j DNAT --to-destination $LOC_IP
  echo -A PREROUTING             -d $EXT_IP -m comment --comment $NAME -j DNAT --to-destination $LOC_IP
  hush ip addr add dev $IF $INT_IP/32
  hush ip addr add dev $IF $LOC_RT
}

echo \*nat

## TRANSLATION
nat starlord eth1 0.45
nat gamora eth1 0.18
nat rocket eth1 0.27
nat drax eth1 0.100
nat groot eth1 0.3

echo COMMIT
