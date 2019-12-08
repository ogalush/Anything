# -*- coding: utf-8 -*-
from fabric.api import run,env,sudo,parallel
import getpass

#-- Execute CommandLine.
## fab -I -H 192.168.0.200,192.168.0.210 -f backupfiles.py execbackup
## fab -I -H 192.168.0.220 -f backupfiles.py execbackupliva

def execbackup():
  sudo('mkdir -vp /mnt/nas', pty=True)
  sudo('mount -t nfs 192.168.3.248:/linux /mnt/nas', pty=True)
  sudo('mkdir -vp /mnt/nas/' + env.host, pty=True)
  sudo('rsync -rOtcvz --delete --verbose /home /mnt/nas/' + env.host, pty=True)
  sudo('rsync -rOtcvz --delete --verbose /etc /mnt/nas/' + env.host, pty=True)
  sudo('rsync -rOtcvz --delete --verbose /usr/local/src /mnt/nas/' + env.host, pty=True)
  run('sleep 10')
  sudo('umount /mnt/nas', pty=True)

def execbackupliva():
  sudo('mkdir -vp /mnt/nas', pty=True)
  sudo('mount -t nfs 192.168.3.248:/linux /mnt/nas', pty=True)
  sudo('mkdir -vp /mnt/nas/liva', pty=True)
  sudo('rsync -rOtcvz --delete --verbose /home /mnt/nas/liva', pty=True)
  sudo('rsync -rOtcvz --delete --verbose /etc /mnt/nas/liva', pty=True)
  sudo('rsync -rOtcvz --delete --verbose /usr/local/src /mnt/nas/liva', pty=True)
  run('sleep 10')
  sudo('umount /mnt/nas', pty=True)
