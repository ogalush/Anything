# 性能テストに利用できそうなツール群
特に断りがない限りはCentOS7〜8, Ubuntu20界隈の想定.

## CPU
* [姫野ベンチマーク](http://i.riken.jp/supercom/documents/himenobmt/)  
使い方は[姫野ベンチの使用方法・測定結果一覧 （Linux編）](https://hesonogoma.com/linux/usageofhimenobench.html)参照
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
ogalush@ubuntu20:~$ sudo apt -y install smartmontools

```
## Network
### iperf
iperfは
