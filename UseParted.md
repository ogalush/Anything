# HDDをフォーマットさせる (2TB Over, GPT)
今までfdiskを使用していたが、MBRの制約で2TBまでしか対応していないとのことなのでGPTを使用する.  
参考: [大容量HDDをparted (GNU Parted)でフォーマットして使えるようにする手順](http://www.lesstep.jp/step_on_board/linux/214/)
## 環境
Ubuntu 16.04

# 手順
## DISKを接続する
対象DISKをUSBなりで繋ぐ.  
deviceファイルを確認する.
```
$ dmesg -T |less
----
[Sat Nov  3 16:16:50 2018] scsi 0:0:0:0: Direct-Access     UD3000SA                  0427 PQ: 0 ANSI: 6
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: Attached scsi generic sg0 type 0
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] 4096-byte physical blocks
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] Write Protect is off
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] Mode Sense: 33 00 00 08
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] No Caching mode page found
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] Assuming drive cache: write through
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[Sat Nov  3 16:16:50 2018]  sda:
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[Sat Nov  3 16:16:50 2018] sd 0:0:0:0: [sda] Attached SCSI disk
----

$ ls -l /dev/sda*
brw-rw---- 1 root disk 8, 0 Nov  3 16:16 /dev/sda
ogalush@livaserver:~$
```

## parted起動
```
$ sudo parted /dev/sda
(parted) print all
Model: UD3000SA  (scsi)
Disk /dev/sda: 3001GB
Sector size (logical/physical): 512B/4096B
Partition Table: msdos
Disk Flags:
Number  Start  End  Size  Type  File system  Flags
→ 今までCIFSで使ってたのでPartition tableがDOSとなっている.
```

## パーティションテーブル更新
msdos→gpt(Linux用)へ変更する.
```
(parted) mklabel gpt
Warning: The existing disk label on /dev/sda will be destroyed and all data on this disk will be lost.
Do you  want to continue?
Yes/No? yes

(parted) print 
Model: UD3000SA  (scsi)
Disk /dev/sda: 3001GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags:
Number  Start  End  Size  File system  Name  Flags
→ Partition Table = gptへ変わったのでOK.
```

## パーティション作成
用途未定なのでひとまず1パーティションにまとめておく.
```
(parted) mkpart
Partition name?  []? primary
File system type?  [ext2]? ext4
Start? 0%
End? 100% 

(parted) print
Model: UD3000SA  (scsi)
Disk /dev/sda: 3001GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags:
Number  Start   End     Size    File system  Name     Flags
1      1049kB  3001GB  3001GB  ext4         primary
→ パーティションが1つでDisk容量全て(3TB)割り当たったのでOK.
```
## parted終了
パーティション割り当てを完了したので、partedを終了させる.
```
(parted) quit
→ パーティション割り当て終了
```

## フォーマット
```
$ ls -al /dev/sda*
brw-rw---- 1 root disk 8, 0 Nov  3 16:22 /dev/sda
brw-rw---- 1 root disk 8, 1 Nov  3 16:22 /dev/sda1

$ sudo mkfs -t ext4 /dev/sda1
mke2fs 1.42.13 (17-May-2015)
Creating filesystem with 732566272 4k blocks and 183148544 inodes
Filesystem UUID: ca06123a-7506-445c-b0db-87dfb48b2b45
Superblock backups stored on blocks:
  32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
  4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
  102400000, 214990848, 512000000, 550731776, 644972544                                                                                                                                                                 Allocating group tables: done                                                                                  Writing inode tables: done                                                                                     Creating journal (32768 blocks): done                                                                          Writing superblocks and filesystem accounting information: done                                                                                                                                                               ogalush@livaserver:~$
```

## マウント確認
```
$ sudo mount /dev/sda1 /mnt/usbdisk1
ogalush@livaserver:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            918M     0  918M   0% /dev
tmpfs           188M  3.1M  185M   2% /run
/dev/mmcblk0p2   27G  8.2G   17G  33% /
...
/dev/sda1       2.7T   73M  2.6T   1% /mnt/usbdisk1
→ 約3TBでマウントされてるのでOK.

$ sudo umount /mnt/usbdisk1
→ 使用が終わったらumountで外しておく.
```
