#!/bin/bash

#-- qemu install Script for CentOS6.5
#-- Create 2014.8.5 ogalush

BAK=/root/MAINTENANCE/`date '+%Y%m%d'`/bak
mkdir -p $BAK
ls -al $BAK/selinux || cp -p /etc/selinux/config $BAK
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
cat /etc/selinux/config

yum -y update
yum -y install qemu-kvm.x86_64 qemu-kvm-tools.x86_64 qemu-img.x86_64 qemu-guest-agent.x86_64 libvirt.x86_64 libvirt-python.x86_64 python-virtinst.noarch virt-viewer.x86_64

