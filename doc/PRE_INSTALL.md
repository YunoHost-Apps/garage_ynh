Before installing your Garage node:
* We suppose that there are no personalized mounting points on your YunoHost system, specifically for `/home/yunohost.app/`
* Otherwise, prefer manually mounting Garage Data and Metadata partitions and type `manual` in the data and metadata fields
* It is recommended to store Data on a HDD or SSD on a XFS partition different from that of YunoHost system. EXT4 may be OK if you plan to store less than 10TB and mainly bigger files on your cluster
* Create a new partition dedicated to Data and give its path at install, e.g. a partition `/dev/sdb1` of 4 TB (4000000000000 = 7812500000 sectors of 512 bytes) on an empty `/dev/sdb` drive:

```sudo fdisk /dev/sdb
Command (m for help): n
Partition number (1-128, default 1): 
First sector (34-15628053134, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-15628053134, default 15628053134): +7812500000
Created a new partition 1 of type 'Linux filesystem' and of size 3.6 TiB.
```

* If the partition where `/home/yunohost.app/` is mounted is not on a SSD
  * Migrate YunoHost to a SSD
* If the partition where `/home/yunohost.app/` is mounted is not partitioned with `btrfs` or `zfs`, e.g. `/dev/sda1`
  * Metadata may get corrupt, e.g. after a power outage, so this is less an issue if your server has power redundancy
  * Migrate `/dev/sda1` vers `btrfs`
  * EXT4 is OK if you do regular Metadata snapshots and have enough space to store them. You may e.g. set `metadata_auto_snapshot_interval = "1hour"` 
* Or create a new partition dedicated to metadata on a SSD and give its path at install, e.g. `/dev/sda2`