# CentOS Linux 8からStream 8への移行方法
CentOS8の開発方針が変更となり、CentOS8を2021/12/31に終了させて、CentOS Streamへ集中することとなった.  
参考: [CentOS Project shifts focus to CentOS Stream](https://blog.centos.org/2020/12/future-is-centos-stream/)  
  
今回は、既にインストール済みのCentOS Linux 8から CentOS Stream 8へのマイグレーションをする.  

# 環境
OpenStack Ussuri (Controller+ComputeNode) + CentOS8.  
[Install OpenStack Ussuri on CentOS8](https://github.com/ogalush/Documents/blob/master/InstallUssuriForCentOS8.md)
で作成した機材.

# 手順
参考: [Q7: How do I migrate my CentOS Linux 8 installation to CentOS Stream?](https://centos.org/distro-faq/#q7-how-do-i-migrate-my-centos-linux-8-installation-to-centos-stream)
の方法を試す.

### バージョン確認
```
[ogalush@ryunosuke ~]$ cat /etc/redhat-release
CentOS Linux release 8.3.2011
```
### CentOS Streamインストール.
```
[ogalush@ryunosuke ~]$ sudo dnf install centos-release-stream
...
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                              1/1
  Installing       : centos-release-stream-8.1-1.1911.0.7.el8.x86_64                                              1/1
  Verifying        : centos-release-stream-8.1-1.1911.0.7.el8.x86_64                                              1/1

Installed:
  centos-release-stream-8.1-1.1911.0.7.el8.x86_64
→ 入ればOK.
```

### リポジトリ入れ替え
centos-linux-reposを削除して、centos-stream-reposを入れる.
```
[ogalush@ryunosuke ~]$ sudo dnf swap centos-{linux,stream}-repos
CentOS-Stream - AppStream                                                             2.4 MB/s | 6.4 MB     00:02
CentOS-Stream - Base                                                                  2.2 MB/s | 2.4 MB     00:01
CentOS-Stream - Extras                                                                9.2 kB/s | 7.0 kB     00:00
Dependencies resolved.
======================================================================================================================
 Package                             Architecture         Version                   Repository                   Size
======================================================================================================================
Installing:
 centos-stream-release               noarch               8.4-1.el8                 Stream-BaseOS                21 k
     replacing  centos-linux-release.noarch 8.3-1.2011.el8
     replacing  centos-release-stream.x86_64 8.1-1.1911.0.7.el8
 centos-stream-repos                 noarch               8-2.el8                   Stream-BaseOS                19 k
Removing:
 centos-linux-repos                  noarch               8-2.el8                   @BaseOS                      26 k

Transaction Summary
======================================================================================================================
Install  2 Packages
Remove   1 Package

Total download size: 40 k
Is this ok [y/N]: y
...
Installed:
  centos-stream-release-8.4-1.el8.noarch                      centos-stream-repos-8-2.el8.noarch

Removed:
  centos-linux-repos-8-2.el8.noarch

Complete!
[ogalush@ryunosuke ~]$
```

### アップデートをかける.
```
[ogalush@ryunosuke ~]$ sudo dnf distro-sync
CentOS Stream 8 - AppStream                                                           4.7 MB/s | 6.4 MB     00:01
CentOS Stream 8 - BaseOS                                                              3.1 MB/s | 2.4 MB     00:00
CentOS Stream 8 - Extras                                                              9.3 kB/s | 7.0 kB     00:00
Error:
 Problem 1: package gdal-libs-3.0.4-5.el8.x86_64 requires libpoppler.so.78()(64bit), but none of the providers can be installed
  - cannot install the best update candidate for package gdal-libs-3.0.4-5.el8.x86_64
  - poppler-0.66.0-27.el8.x86_64 does not belong to a distupgrade repository
 Problem 2: package python3-gdal-3.0.4-5.el8.x86_64 requires libgdal.so.26()(64bit), but none of the providers can be installed
  - package python3-gdal-3.0.4-5.el8.x86_64 requires gdal-libs(x86-64) = 3.0.4-5.el8, but none of the providers can be installed
  - package gdal-libs-3.0.4-5.el8.x86_64 requires libpoppler.so.78()(64bit), but none of the providers can be installed 
  - cannot install both poppler-20.11.0-2.el8.x86_64 and poppler-0.66.0-27.el8.x86_64
  - cannot install the best update candidate for package python3-gdal-3.0.4-5.el8.x86_64
  - cannot install the best update candidate for package poppler-0.66.0-27.el8.x86_64
(try to add '--allowerasing' to command line to replace conflicting packages or '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)
→ いくつか依存関係でエラーしているようなので「--allowerasing」を付与してConfrictしているパッケージを入れ替える形で進める.

[ogalush@ryunosuke ~]$ sudo dnf distro-sync --allowerasing
Last metadata expiration check: 0:00:42 ago on Sun 03 Jan 2021 08:44:39 PM JST.
Dependencies resolved.
======================================================================================================================
 Package                                 Arch    Version                                             Repository  Size
======================================================================================================================
Installing:
 kernel                                  x86_64  4.18.0-259.el8                                      baseos     5.0 M
 kernel-core                             x86_64  4.18.0-259.el8                                      baseos      31 M
 kernel-modules                          x86_64  4.18.0-259.el8                                      baseos      27 M
Upgrading:
 NetworkManager                          x86_64  1:1.30.0-0.4.el8                                    baseos     2.5 M
...
 python3-sqlalchemy                      x86_64  1.3.2-2.module_el8.3.0+389+6a62c88d                 appstream  1.9 M
 python36                                x86_64  3.6.8-2.module_el8.3.0+389+6a62c88d                 appstream   19 k

Transaction Summary
======================================================================================================================
Install     12 Packages
Upgrade    282 Packages
Remove       5 Packages
Downgrade    9 Packages

Total download size: 490 M
Is this ok [y/N]: y
→ インストールが進む.
...
Downgraded:
  centos-release-openstack-ussuri-1-3.el8.noarch
  httpd-2.4.37-30.module_el8.3.0+462+ba287492.0.1.x86_64
  httpd-filesystem-2.4.37-30.module_el8.3.0+462+ba287492.0.1.noarch
  httpd-tools-2.4.37-30.module_el8.3.0+462+ba287492.0.1.x86_64
  python3-bson-3.6.1-11.module_el8.3.0+389+6a62c88d.x86_64
  python3-pymongo-3.6.1-11.module_el8.3.0+389+6a62c88d.x86_64
  python3-scipy-1.0.0-20.module_el8.3.0+389+6a62c88d.x86_64
  python3-sqlalchemy-1.3.2-2.module_el8.3.0+389+6a62c88d.x86_64
  python36-3.6.8-2.module_el8.3.0+389+6a62c88d.x86_64

Installed:
  dnf-plugin-subscription-manager-1.28.5-1.el8.x86_64                kernel-4.18.0-259.el8.x86_64
  kernel-core-4.18.0-259.el8.x86_64                                  kernel-modules-4.18.0-259.el8.x86_64
  lmdb-libs-0.9.24-1.el8.x86_64                                      python3-ethtool-0.14-3.el8.x86_64
  python3-iniparse-0.4-31.el8.noarch                                 python3-librepo-1.12.0-3.el8.x86_64
  python3-subscription-manager-rhsm-1.28.5-1.el8.x86_64              subscription-manager-1.28.5-1.el8.x86_64
  subscription-manager-rhsm-certificates-1.28.5-1.el8.x86_64         usermode-1.113-1.el8.x86_64

Removed:
  gdal-libs-3.0.4-5.el8.x86_64                             kernel-4.18.0-193.19.1.el8_2.x86_64
  kernel-core-4.18.0-193.19.1.el8_2.x86_64                 kernel-modules-4.18.0-193.19.1.el8_2.x86_64
  python3-gdal-3.0.4-5.el8.x86_64

Complete!
[ogalush@ryunosuke ~]$
→ 完了.
```

### インストール後のバージョン確認
```
[ogalush@ryunosuke ~]$ cat /etc/redhat-release
CentOS Stream release 8
[ogalush@ryunosuke ~]$ cat /etc/centos-release
CentOS Stream release 8
[ogalush@ryunosuke ~]$
[ogalush@ryunosuke ~]$ date
Sun Jan  3 20:53:10 JST 2021
[ogalush@ryunosuke ~]$
→ CentOS Stream 8となったためOK.
```

### OS再起動
Kernelを変更しているように見えるため、OS再起動して問題なく立ち上がるか確認する.
```
[ogalush@ryunosuke ~]$ sudo reboot
[sudo] password for ogalush:
Connection to 192.168.3.200 closed by remote host.
Connection to 192.168.3.200 closed.
[20:53:18 ogalush@livaserver:~]$
...(数分後)...
[21:09:09 ogalush@livaserver:~]$ ssh -i ~/.ssh/id_rsa -A ogalush@192.168.3.200
Last login: Sun Jan  3 20:59:06 2021 from 192.168.3.220
[ogalush@ryunosuke ~]$ uptime -s
2021-01-03 20:54:40
[ogalush@ryunosuke ~]$ date
Sun Jan  3 21:09:16 JST 2021
[ogalush@ryunosuke ~]$
→ SSHログインできているためOK.
```
