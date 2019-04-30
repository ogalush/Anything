#!/bin/bash

set -x
NAS='/mnt/nas'
USBDISK='/mnt/usbdisk1'
sudo rsync -av --include='.*' --delete-before --progress  /etc /home /usr/local/src $NAS/liva
sudo rsync -av --include='.*' --delete-before --log-file=${USBDISK}/rsync-`date +"%Y%m%d"`.log --progress ${NAS}/* ${USBDISK}/linux
set +x
