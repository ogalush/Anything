# Ubuntu Update 20.04 -> 22.04
2022.4.21 Ubuntu 22.04 Jammy JellyfishがRelaseされた.    
手元のサーバをアップデートしたので記録を残す.  

参考サイト:  
* [Canonical Ubuntu 22.04 LTS is released](https://ubuntu.com/blog/ubuntu-22-04-lts-released)
* [How To Upgrade Ubuntu To 22.04 LTS Jammy Jellyfish](https://linuxconfig.org/how-to-upgrade-ubuntu-to-22-04-lts-jammy-jellyfish)

# 環境
## バージョン確認 (Before)
```
[13:32:00 ogalush@livaserver:~]$ uname -n
livaserver.localdomain
[13:32:02 ogalush@livaserver:~]$ date
Sat 23 Apr 2022 01:32:02 PM JST
[13:32:02 ogalush@livaserver:~]$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.4 LTS
Release:        20.04
Codename:       focal
[13:32:04 ogalush@livaserver:~]$
```
## バージョン確認 (After)
```
[21:01:56 ogalush@livaserver:~]$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04 LTS
Release:        22.04
Codename:       jammy
[21:01:58 ogalush@livaserver:~]$
```

# 手順
## パッケージ最新化
OSアップデート前に全てのパッケージを最新化する.
```
$ sudo apt -y update
$ sudo apt -y upgrade
$ sudo apt -y dist-upgrade
$ sudo apt -y autoremove
```
## OS再起動
Kernel更新もあるため一度OS再起動する.
```
$ sudo reboot
```

## OSバージョンアップ
### update-manager-core準備
OSアップデートをするために必要なパッケージのようなのでインストールする.
```
$ sudo apt -y install update-manager-core
```
### OSアップデート実施
いつも通りdo-release-updateを実施する.
```
$ sudo do-release-upgrade -d
```

※「Prompt=lts」の場合は 20.04 → 22.04へアップデートしようとするとうまくいかない（間に21.10があるため？）、-dオプションを付与して実施した.
```
$ grep Prompt /etc/update-manager/release-upgrades
Prompt=lts
の場合、20.04 → 22.04へ進めるために 「-d」オプションを付けて実行する.

$ man do-release-upgrade
----
-d, --devel-release
 If using the latest supported release, upgrade to the development release
----
```
do-release-update実施中はいくつかプロンプトが出てくるため、適宜Yesを入れて進める.
```
----
Do you want to start the upgrade? 


16 installed packages are no longer supported by Canonical. You can 
still get support from the community. 

29 packages are going to be removed. 109 new packages are going to be 
installed. 945 packages are going to be upgraded. 

You have to download a total of 1,138 M. This download will take 
about 5 minutes with your connection. 

Installing the upgrade can take several hours. Once the download has 
finished, the process cannot be canceled. 

 Continue [yN]  Details [d]y
----


do-release-upgrade中は1022/tcpへsshすることで予備画面を出せる.
----
ogalush@MacBook-Pro1 ~ % ssh -i ~/.ssh/id_rsa -p 1022 -A ogalush@192.168.3.220
Enter passphrase for key '/Users/ogalush/.ssh/id_rsa': 
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-109-generic x86_64)

 System information disabled due to load higher than 2.0
----

不要パッケージを消す
----
Adding boot menu entry for UEFI Firmware Settings ...
done
Reading package lists... Done    
Building dependency tree          
Reading state information... Done

Searching for obsolete software
Reading state information... Done

Remove obsolete packages? 


137 packages are going to be removed. 

Removing the packages can take several hours. 

 Continue [yN]  Details [d]y
----


----
Processing triggers for libglib2.0-0:amd64 (2.72.1-1) ...
No schema files found: removed existing output file.

System upgrade is complete.

Restart required 

To finish the upgrade, a restart is required. 
If you select 'y' the system will be restarted. 

Continue [yN] y
----
```
### OS再起動後のバージョン確認
```
[21:01:56 ogalush@livaserver:~]$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04 LTS
Release:        22.04
Codename:       jammy
[21:01:58 ogalush@livaserver:~]$
```
→ 22.04になっていればOK.
