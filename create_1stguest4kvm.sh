#!/bin/bash

#-- Create KVM Instance Script for CentOS6.5
#-- Create 2014.8.5 ogalush

#-- http://ymotongpoo.hatenablog.com/entry/20100806/1281084634
#-- hvm \ <-- 完全仮想化にします
#-- virt-type=kvm \ <-- 仮想化方法はKVM
#-- network=bridge:br0 \ <-- 仮想NICは先ほど作成したbr0のブリッジインタフェースを使います
##--   --vnc --vncport=5900  --vnclisten=0.0.0.0 \

virsh list --all
virsh destroy test
virsh undefine test

###dd if=/dev/zero of=/tmp/Test.img bs=1M count=4000
###virt-install --name=test --connect=qemu:///system --ram=512 --vcpus=1 --virt-type=qemu --hvm --os-type=linux --disk=/tmp/Test.img --cdrom=/usr/local/src/CentOS-6.5-x86_64-minimal.iso --network=bridge:virbr0 -–nographics --keymap=ja

qemu-img create -f qcow2 /tmp/Test.qcow2 4G
virt-install --virt-type=qemu --name=centos-6.5 --ram=512 \
--cdrom=/usr/local/src/CentOS-6.5-x86_64-minimal.iso \
--disk=/tmp/Test.qcow2,format=qcow2 \
--network=network=default \
--graphics vnc,listen=0.0.0.0 --noautoconsole \
--os-type=linux --os-variant=rhel6

virsh list --all

echo 'virsh console test'
