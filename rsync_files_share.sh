#!/bin/bash
set -x
##sudo rsync -avz --include='.*' --delete-before --progress  /mnt/nas2/* /mnt/usbdisk1/share
NAS='/mnt/nas2'
USBDISK='/mnt/usbdisk1'
find ${NAS} -type f -name '.*' -exec sudo rm -v {} \;
sudo rsync -av --exclude='seck' --include='.*' --delete-before --log-file=${USBDISK}/rsync-`date +"%Y%m%d"`.log --progress  ${NAS}/* ${USBDISK}/share
set +x
