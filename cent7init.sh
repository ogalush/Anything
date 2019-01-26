#!/bin/bash

set -x
ansible-playbook -i '192.168.0.210,' cent7init.yml --user=root --become -K -k
set +x
