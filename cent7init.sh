#!/bin/bash

set -x
ansible-playbook -i '192.168.0.210,' cent7init.yml --user=root --become -K -k

## CloudImage
## $ ssh -i ~/.ssh/id_rsa_chef centos@192.168.0.103
## $ sudo su -
## $ passwd centos
## → CentOSアカウントのパスワード初期化
## $ ansible-playbook -i '192.168.0.103,' cent7init.yml --user=centos --become -K --private-key=~/.ssh/id_rsa_chef
set +x

