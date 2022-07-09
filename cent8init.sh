#!/bin/bash

set -x
ansible-playbook -i '192.168.3.210,' cent8init.yml --user=centos -bkK

## CloudImage
## $ ssh -i ~/.ssh/id_rsa_chef centos@192.168.0.103
## $ sudo su -
## $ passwd centos
## → CentOSアカウントのパスワード初期化
## $ ansible-playbook -i '192.168.3.200,' cent8init.yml --user=centos --become -kK --list-hosts
## $ ansible-playbook -i '192.168.3.200,' cent8init.yml --user=centos --become -kK

## Only OS Update
## ansible-playbook -i '192.168.3.200,' cent8init.yml --become -bK --skip-tags='*' --tags='dnf_update' --list-tags
## ansible-playbook -i '192.168.3.200,' cent8init.yml --become -bK --skip-tags='*' --tags='dnf_update' --list-hosts
## ansible-playbook -i '192.168.3.200,' cent8init.yml --become -bK --skip-tags='*' --tags='dnf_update'
set +x

