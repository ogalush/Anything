#!/bin/bash

#==== Information
# $ sudo arping -c 1 192.168.3.248
# ARPING 192.168.3.248
# 60 bytes from 24:5e:be:22:dc:b3 (192.168.3.248): index=0 time=414.623 usec
#==== Information (END)
set -x
/usr/bin/wakeonlan 24:5e:be:22:dc:b3
set +x
