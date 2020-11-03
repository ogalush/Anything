# 性能テストに利用できそうなツール群
特に断りがない限りはCentOS7〜8, Ubuntu20界隈の想定.

## CPU
* [姫野ベンチマーク](http://i.riken.jp/supercom/documents/himenobmt/)  
使い方は[姫野ベンチの使用方法・測定結果一覧 （Linux編）](https://hesonogoma.com/linux/usageofhimenobench.html)参照
```
・ダウンロード
ogalush@ubuntu20:/tmp$ wget -q -O /tmp/himenobmt_c_mpi.zip http://i.riken.jp/en/wp-content/uploads/sites/2/2015/07/himenobmt_c_mpi.zip
ogalush@ubuntu20:/tmp$ ls -l /tmp/himenobmt_c_mpi.zip 
-rw-rw-r-- 1 ogalush ogalush 3011 Jul  9  2015 /tmp/himenobmt_c_mpi.zip

・解凍
ogalush@ubuntu20:/tmp$ sudo apt -y install unzip lhasa
ogalush@ubuntu20:/tmp$ unzip /tmp/himenobmt_c_mpi.zip 
Archive:  /tmp/himenobmt_c_mpi.zip
 extracting: himenobmt_c_mpi.lzh     
ogalush@ubuntu20:/tmp$
ogalush@ubuntu20:/tmp$ lha /tmp/himenobmt_c_mpi.lzh
 PERMSSN    UID  GID      SIZE  RATIO     STAMP           NAME
---------- ----------- ------- ------ ------------ --------------------
-rw-rw-rw-  1001/1000      286  58.7% Jul 12  1999 Makefile
-rw-rw-rw-  1001/1000     7778  32.9% Jul 12  1999 himenoBMT_m.c
---------- ----------- ------- ------ ------------ --------------------
 Total         2 files    8064  33.8% Jun 10  2015
ogalush@ubuntu20:/tmp$ 
ogalush@ubuntu20:/tmp$ lhasa -x /tmp/himenobmt_c_mpi.lzh 
Makefile        - Melted   :  o
himenoBMT_m.c   - Melted   :  o
ogalush@ubuntu20:/tmp$ 

・ファイル移動
/usr/local/src下で利用したかったため.
$ sudo mkdir -pv /usr/local/src/himenobmt_c_mpi
$ sudo chown -v ${USER} /usr/local/src/himenobmt_c_mpi
changed ownership of '/usr/local/src/himenobmt_c_mpi' from root to ogalush
$ sudo mv -v /tmp/Makefile /usr/local/src/himenobmt_c_mpi/
renamed '/tmp/Makefile' -> '/usr/local/src/himenobmt_c_mpi/Makefile'
$ sudo mv -v /tmp/himenoBMT_m.c /usr/local/src/himenobmt_c_mpi/
renamed '/tmp/himenoBMT_m.c' -> '/usr/local/src/himenobmt_c_mpi/himenoBMT_m.c'

・コンパイル
$ sudo apt -y install mpi-default-dev
$ cd /usr/local/src/himenobmt_c_mpi
$ make
mpicc -c -O3 -DSMALL himenoBMT_m.c
mpicc -o bmt himenoBMT_m.o -O3 -DSMALL
$ ls -l
total 52
-rw-rw-rw- 1 ogalush ogalush   286 Jul 12  1999 Makefile
-rwxrwxr-x 1 ogalush ogalush 21824 Nov  3 20:47 bmt
-rw-rw-rw- 1 ogalush ogalush  7778 Jul 12  1999 himenoBMT_m.c
-rw-rw-r-- 1 ogalush ogalush 12456 Nov  3 20:47 himenoBMT_m.o
→ bmtコマンドが出来上がればOK.

・計測
-----
ogalush@ubuntu20:/usr/local/src/himenobmt_c_mpi$ ./bmt 
1 node used. 
mimax = 65 mjmax = 65 mkmax = 129
imax = 64 jmax = 64 kmax =128
cpu : 1.028590 sec.
Loop executed for 200 times
Gosa : 1.688606e-03 
MFLOPS measured : 3201.993813
Score based on MMX Pentium 200MHz : 99.225095
ogalush@ubuntu20:/usr/local/src/himenobmt_c_mpi$
→ MMX Pentium比でのスコア値が出る.
-----
```

## Memory
* [memtester]
簡易確認向け.  
特定のメモリ容量を使ってテストする.  
`sudo memtester <確保するメモリ容量> <確認回数>`
```
ogalush@ubuntu20:~$ sudo apt -y install memtester
[sudo] password for ogalush:
Reading package lists... Done
Building dependency tree
Reading state information... Done  
The following NEW packages will be installed:
  memtester
...
ogalush@ubuntu20:~$ sudo memtester 32M 1
memtester version 4.3.0 (64-bit)
Copyright (C) 2001-2012 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 32MB (33554432 bytes)
got  32MB (33554432 bytes), trying mlock ...locked.
Loop 1/1:
  Stuck Address       : ok         
  Random Value        : ok
  Compare XOR         : ok
  Compare SUB         : ok
  Compare MUL         : ok
  Compare DIV         : ok
  Compare OR          : ok
  Compare AND         : ok
  Sequential Increment: ok
  Solid Bits          : ok         
  Block Sequential    : ok         
  Checkerboard        : ok         
  Bit Spread          : ok         
  Bit Flip            : ok         
  Walking Ones        : ok         
  Walking Zeroes      : ok         
  8-bit Writes        : ok
  16-bit Writes       : ok

Done.
ogalush@ubuntu20:~$
```
* [MemTest86](https://www.memtest86.com/)
元祖メモリテスト. メモリ全体のテストを行う.
* [MemTest86+](https://qiita.com/7of9/items/630a56e313344e4015b9)  
メモリ全体のテストを行う.  
MemTest86の拡張版らしい.  
yum install後にgrubで選択してテストする.  
使い方は[memtest86+でメモリをテストする。](https://www.dogrow.net/linux/blog48/)参照
```
・インストール
ogalush@ubuntu20:~$ sudo apt -y install memtest86+
→ /bootのKernelimageまではいるのでOK.

・設定
VM起動時にgrub2画面が見えないためタイムアウト設定
----
$ sudo cp -pv /etc/default/grub.d/50-cloudimg-settings.cfg ~
$ diff --unified=0 ~/50-cloudimg-settings.cfg /etc/default/grub.d/50-cloudimg-settings.cfg
--- /home/ogalush/50-cloudimg-settings.cfg      2020-04-29 06:42:42.100884944 +0900
+++ /etc/default/grub.d/50-cloudimg-settings.cfg        2020-11-03 21:20:38.391119711 +0900
@@ -8 +8,2 @@
-GRUB_TIMEOUT=0
+GRUB_TIMEOUT_STYLE=menu
+GRUB_TIMEOUT=5
----
→ grub非表示(hidden)→表示(menu)
タイムアウト秒数 0 → 5秒

・反映
$ sudo update-grub2
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/40-force-partuuid.cfg'
Sourcing file `/etc/default/grub.d/50-cloudimg-settings.cfg'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-5.4.0-52-generic
Found initrd image: /boot/initrd.img-5.4.0-52-generic
Found linux image: /boot/vmlinuz-5.4.0-47-generic
Found initrd image: /boot/initrd.img-5.4.0-47-generic
Found memtest86+ image: /boot/memtest86+.elf
Found memtest86+ image: /boot/memtest86+.bin
done
ogalush@ubuntu20:~$

・再起動
$ sudo reboot

・grubメニュー
- 「Memory teset (memtest86+」を選択
- F2するとSMPでマルチコアを使ってテストしてくれる（早い）
- 途中終了はESCで抜けられる.
```


## Disk
* [hdparm](http://naoberry.com/tech/hdparm/)  
`hdparm -tT`で大まかな性能確認が可能.  
```
ogalush@ubuntu20:~$ df -h /dev/vda1
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        20G  5.5G   14G  29% /
ogalush@ubuntu20:~$ sudo hdparm -tT /dev/vda1

/dev/vda1:
 Timing cached reads:   14718 MB in  1.99 seconds = 7389.30 MB/sec
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 Timing buffered disk reads: 768 MB in  3.00 seconds = 255.76 MB/sec
ogalush@ubuntu20:~$
```
* [smartmontools](https://www.space-i.com/post-blog/smartmontools-dell-poweredge/)  
RAIDカードのあるサーバなどはこの辺で実施すると便利っぽい.
```
[ogalush@ryunosuke ~]$ sudo dnf -q -y install smartmontools
[ogalush@ryunosuke ~]$ rpm -q smartmontools
smartmontools-6.6-3.el8.x86_64
[ogalush@ryunosuke ~]$

SMART情報表示とselftest
----
[ogalush@ryunosuke ~]$ sudo smartctl -a /dev/sda |head -n 21
smartctl 6.6 2017-11-05 r4594 [x86_64-linux-4.18.0-193.28.1.el8_2.x86_64] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Samsung based SSDs
Device Model:     Samsung SSD 840 Series
Serial Number:    S14GNEBCC12783N
LU WWN Device Id: 5 002538 55011c5cb
Firmware Version: DXT06B0Q
User Capacity:    250,059,350,016 bytes [250 GB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4c
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Tue Nov  3 18:19:33 2020 JST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED
[ogalush@ryunosuke ~]$
----

SMART情報表示(USBカード)
-----
[ogalush@ryunosuke ~]$ sudo smartctl -d scsi -a /dev/sdc
smartctl 6.6 2017-11-05 r4594 [x86_64-linux-4.18.0-193.28.1.el8_2.x86_64] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Vendor:               SanDisk
Product:              Cruzer Fit
Revision:             1.27
Compliance:           SPC-4
User Capacity:        64,016,220,160 bytes [64.0 GB]
Logical block size:   512 bytes
Serial number:        4C530012020304111520
Device type:          disk
Local Time is:        Tue Nov  3 18:42:51 2020 JST
SMART support is:     Available - device has SMART capability.
SMART support is:     Enabled
Temperature Warning:  Disabled or Not Supported

=== START OF READ SMART DATA SECTION ===
SMART Health Status: OK
Current Drive Temperature:     0 C
Drive Trip Temperature:        0 C

Error Counter logging not supported

Device does not support Self Test logging
[ogalush@ryunosuke ~]$ 
----

SHORTテスト
----
[ogalush@ryunosuke ~]$ sudo smartctl -d ata -t short /dev/sda2 
smartctl 6.6 2017-11-05 r4594 [x86_64-linux-4.18.0-193.28.1.el8_2.x86_64] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Sending command: "Execute SMART Short self-test routine immediately in off-line mode".
Drive command "Execute SMART Short self-test routine immediately in off-line mode" successful.
Testing has begun.
Please wait 2 minutes for test to complete.
Test will complete after Tue Nov  3 18:52:08 2020

Use smartctl -X to abort test.
[ogalush@ryunosuke ~]$
----
→ Diskの読み書きテストがバックグラウンドで開始される.
中止はsmartctl .. -X

テスト結果
----
[ogalush@ryunosuke ~]$ sudo smartctl -d ata -l selftest /dev/sda2 
smartctl 6.6 2017-11-05 r4594 [x86_64-linux-4.18.0-193.28.1.el8_2.x86_64] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%         2         -
# 2  Short offline       Completed without error       00%         2         -
# 3  Short offline       Completed without error       00%         2         -
# 4  Short offline       Completed without error       00%         2         -
# 5  Offline             Completed without error       00%         2         -
[ogalush@ryunosuke ~]$ 
→ エラー無し結果.
エラーがあると別な表示になる.
----
```
## Network
* iperf/iperf3
iperfはサーバ/クライアントでiperfコマンドを起動させてtcp/udpの通信速度を計測するツール.  
iperfとiperf3でバージョンが異なるので送受信するコマンドは同じにする.
Windowsのttcpと同じ.
```
・Install
----
$ sudo dnf -q -y install iperf3
$ rpm -q iperf3
iperf3-3.5-3.el8.x86_64


$ sudo apt -y install iperf iperf3
$ dpkg -l |grep iperf
ii  iperf                                  2.0.10+dfsg1-1ubuntu0.18.04.2                   amd64        Internet Protocol bandwidth measuring tool
ii  iperf3                                 3.1.3-1                                         amd64        Internet Protocol bandwidth measuring tool
ii  libiperf0:amd64                        3.1.3-1                                         amd64        Internet Protocol bandwidth measuring tool (runtime files)

Mac
$ brew install iperf
----

・Client
----
Mac$ iperf -c 192.168.3.220
------------------------------------------------------------
Client connecting to 192.168.3.220, TCP port 5001
TCP window size:  129 KByte (default)
------------------------------------------------------------
[  4] local 192.168.3.13 port 51387 connected with 192.168.3.220 port 5001
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec   206 MBytes   172 Mbits/sec

Ubuntu
ogalush@ubuntu20:~$ iperf -c 192.168.3.220
------------------------------------------------------------
Client connecting to 192.168.3.220, TCP port 5001
TCP window size:  374 KByte (default)
------------------------------------------------------------
[  3] local 10.0.0.226 port 41012 connected with 192.168.3.220 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  1.01 GBytes   868 Mbits/sec
----

・Server
----
Ubuntu$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  4] local 192.168.3.220 port 5001 connected with 192.168.3.13 port 51389
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec   201 MBytes   168 Mbits/sec
[  4] local 192.168.3.220 port 5001 connected with 192.168.3.141 port 24417
[  4]  0.0-10.0 sec  1.01 GBytes   866 Mbits/sec
----

・Client(iperf3)
----
$ iperf3 -c 192.168.3.220
Connecting to host 192.168.3.220, port 5201
[  5] local 192.168.3.200 port 32988 connected to 192.168.3.220 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   952 Mbits/sec    0    346 KBytes
[  5]   1.00-2.00   sec   113 MBytes   946 Mbits/sec    0    382 KBytes
[  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec    0    382 KBytes
[  5]   3.00-4.00   sec   108 MBytes   904 Mbits/sec    0    576 KBytes
[  5]   4.00-5.00   sec   103 MBytes   867 Mbits/sec    7    413 KBytes
[  5]   5.00-6.00   sec   103 MBytes   866 Mbits/sec    9    413 KBytes
[  5]   6.00-7.00   sec   102 MBytes   859 Mbits/sec    0    448 KBytes
[  5]   7.00-8.00   sec   103 MBytes   865 Mbits/sec   10    411 KBytes
[  5]   8.00-9.00   sec   103 MBytes   865 Mbits/sec   14    390 KBytes
[  5]   9.00-10.00  sec   103 MBytes   864 Mbits/sec    8    437 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.04 GBytes   893 Mbits/sec   48             sender
[  5]   0.00-10.00  sec  1.04 GBytes   889 Mbits/sec                  receiver

iperf Done.
[ogalush@ryunosuke ~]$
----

・Server(iperf3)
----
$ iperf3 -s
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.3.200, port 32986
[  5] local 192.168.3.220 port 5201 connected to 192.168.3.200 port 32988
[ ID] Interval           Transfer     Bandwidth
[  5]   0.00-1.00   sec   109 MBytes   911 Mbits/sec
[  5]   1.00-2.00   sec   112 MBytes   940 Mbits/sec
[  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec
[  5]   3.00-4.00   sec   107 MBytes   892 Mbits/sec
[  5]   4.00-5.00   sec   104 MBytes   870 Mbits/sec
[  5]   5.00-6.00   sec   103 MBytes   865 Mbits/sec
[  5]   6.00-7.00   sec   100 MBytes   840 Mbits/sec
[  5]   7.00-8.00   sec   106 MBytes   886 Mbits/sec
[  5]   8.00-9.00   sec   103 MBytes   862 Mbits/sec
[  5]   9.00-10.00  sec   103 MBytes   861 Mbits/sec
[  5]  10.00-10.03  sec  2.38 MBytes   706 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth
[  5]   0.00-10.03  sec  0.00 Bytes  0.00 bits/sec                  sender
[  5]   0.00-10.03  sec  1.04 GBytes   886 Mbits/sec                  receiver
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
iperf3: interrupt - the server has terminated
[19:58:02 ogalush@livaserver:~]$
----
```
