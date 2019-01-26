#!/bin/bash

set -x
ansible-playbook -i '192.168.0.210,' cent7init.yml --user=root --become -K -k


## 最初に以下のネットワークをしておく
## IPアドレス、サブネットマスクを変更
# sudo nmcli c m enp3s0 connection.autoconnect yes
# sudo nmcli c modify enp3s0 ipv4.addresses 192.168.0.210/24
# sudo nmcli c modify enp3s0 ipv4.gateway 192.168.0.254
# sudo nmcli c modify enp3s0 ipv4.dns 192.168.0.254
# sudo nmcli c modify enp3s0 ipv4.method manual
# sudo nmcli c down enp3s0; sudo nmcli c up enp3s0
# sudo nmcli d show enp3s0
set +x
