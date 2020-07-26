#!/bin/bash

set -x
ansible-playbook -i '192.168.3.200,' cent8init.yml --user=root --become -bkK

## CloudImage
## $ ssh -i ~/.ssh/id_rsa_chef centos@192.168.0.103
## $ sudo su -
## $ passwd centos
## → CentOSアカウントのパスワード初期化
## $ ansible-playbook -i '192.168.0.103,' cent7init.yml --user=centos --become -K --private-key=~/.ssh/id_rsa_chef
set +x

