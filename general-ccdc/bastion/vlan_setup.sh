#!/bin/sh
# VLAN setup script.

# TODO:
# - Make variables configurable via the command line.
# - Disable IPv6.
set -e

IPCOMMAND="/sbin/ip"
IP="10.10.9.132/24"
GATEWAY="10.10.9.1"
BRIDGE="br0"
PHYSICAL="eth0"

# Number of interfaces to create for the script
SWITCH_INTERFACES="25"
VM_INTERFACES="20"

echo -n "Installing Kernel module..."
modprobe 8021q
echo " Done."

if ! command -v brctl > /dev/null 2>&1
then
  echo "bridge-utils missing"
  exit 1
fi

if ! command -v ip > /dev/null 2>&1
then
  echo "iproute2 missing"
  exit 1
fi

# Create the bridge.
echo -n "Adding bridge interface..."
brctl addbr $BRIDGE
echo " Done."

for PORT in 1 $(seq -s " " 100 1$SWITCH_INTERFACES) $(seq -s " " 200 2$VM_INTERFACES)
do
    # Create one VLAN for each port.
    VLAN="$PHYSICAL.$PORT"
    echo -n "Creating $VLAN..."
    $IPCOMMAND link add link $PHYSICAL name $VLAN type vlan id $PORT
    $IPCOMMAND link set $VLAN up

    # Add all VLANS to br0.
    echo -n " Adding to bridge..."
    brctl addif $BRIDGE $VLAN
    echo " Done."
done

# Migrate the IP address of the physical to the trunk interface.
echo -n "Adding IP to $TRUNK_BRIDGE..."
$IPCOMMAND addr add $IP dev $BRIDGE
echo " Done."
echo -n "Bringing $BRIDGE up..."
$IPCOMMAND link set $BRIDGE up
echo " Done."
echo -n "Removing IP from $PHYSICAL..."
$IPCOMMAND addr flush $PHYSICAL
echo " Done."
echo -n "Adding default route..."
$IPCOMMAND route add default via $GATEWAY dev $BRIDGE
echo " Done."
echo "Bastion setup complete! YAY!"
