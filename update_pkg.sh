#!/bin/bash

set -x
##TARGETHOST='192.168.0.220'
TARGETHOST='192.168.0.200,192.168.0.210,192.168.0.220'
##TARGETHOST='192.168.0.120,192.168.0.122,192.168.0.123,192.168.0.127,192.168.0.128'
##TARGETHOST='www.teamlush.biz'
fab -I -P -z 5 -H $TARGETHOST -f update_pkg.py update_pkg
##fab -I -P -z 5 -H $TARGETHOST -f update_pkg.py reboot
set +x
