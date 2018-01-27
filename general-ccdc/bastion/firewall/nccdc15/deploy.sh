#!/bin/sh

set -e

echo "*** generating firewalls"
python /opt/capirca/aclgen.py -d /fw -o /fw -p /fw/nccdc15-corporate.pol
python /opt/capirca/aclgen.py -d /fw -o /fw -p /fw/nccdc15-control.pol
echo "*** enabling corporate firewall"
pfctl -f /fw/nccdc15-corporate.pf
echo "*** corporate firewall enabled"
