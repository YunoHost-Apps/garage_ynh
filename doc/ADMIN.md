# Limitations

  * Garage can be used with only one or two servers (=replica), but requires a cluster with at least 3 nodes to provide its full replication potential (data loss prevention). See [replication modes](https://garagehq.deuxfleurs.fr/documentation/reference-manual/configuration/#replication-mode). It is mainly designed to be used with 3 nodes or more.
  * If you are behind a NAT and use UPnP to configure your port redirection, you may need to
  * add peers via config panel instead of during installation
  * and/or create a permanent port redirection in your router/box

# Informations you should be aware of:

* This application provides a Node that you can connect to a Garage Cluster. The Config Panel provides some Node-related settings. Cluster-related settings like Key or Bucket should be managed via Garage CLI or by another Node
* Garage does not set a hard storage Quota. So disk space usage can become greater than the Node Weight you define. 
* To prevent this, this App will ask you for a Data partition at install, or create a virtual disk with size the Weight of your Node. Virtual disk is only created if YunoHost is not in a VM, and performance may be poor.
* If you install on a VM and do not provide a Data partition, you are responsible for checking sufficient available storage.
* Expect Metadata (database) and its 2-3 snapshots to be approximatly 3% of the Data size (3GB for 100GB of Data for instance), or a bigger percentage if you store many small objects.
* To connect from another Node, you will need the RPC port. Is is defined in `rpc_bind_addr` in your `garage.toml`

## How to use the S3 API from other softwares

* Garage team provides documentation on how to connect from various software to the Cluster over the S3 API: https://garagehq.deuxfleurs.fr/documentation/connect/
* For TLS support, this App sets Nginx reverse proxy for the S3 API
* As a result, **the S3 API can be reached through port 443** on https://garage.domain.tld:path (instead of the port_api seen in `s3_api` in `garage.toml` configuration.)
* From local command line (such as awscli https://garagehq.deuxfleurs.fr/documentation/connect/cli/) you can use `localhost:port_api`.

## How to use the Web Endpoint

* The web endpoint (for HTTP public access, for a static website or social media files) is the port_web defined in `s3_web` in your `garage.toml`
* To use it you should setup a bucket with website access, and a `redirect_ynh` app pointing to `127.0.0.1:port_web`, using the domain `bucketname.DOMAIN`.

## How to run CLI commands for Garage

* Type `yunohost app shell garage` on the server command line to enter Garage environment. You will be located in __INSTALL_DIR__ Garage directory.
* To run a command, you need to specify the config file as a parameter `garage -c garage.toml [the actions you wish to run]`.
* Don't forget to `exit` the environment when you're done.

# Configuration depending on your server setup

We distinguish between 2 major setups:
* Self-hosting-like
  * Power (micro-)outage or cat-unplug likely: Metadata are likely to get corrupt
  * Networking can be slower or have poor level of service
  * Data storage up to some TB
  * Usage for distributed high-capacity storage, e.g. backups. Not necessarily for performance
  * Usage for non-critical services with ephemeral data
  * Recovery from other Nodes within a day (no Data snapshot)
* Data-center-like
  * Unclean shutdown unlikely
  * Fast and high-service networking
  * Data storage greater than some TB
  * Usage for high-performance distributed storage
  * Local Recovery of Node within minutes, e.g. with Data snapshot

**Recommended** (minimal) self-hosting config:
* Data partition: on **SSD** (HDD OK if no high-performance storage), **XFS**, BTRFS & ZFS OK too (EXT4 only for storage in the GB order)
* Metadata partition: on **SSD** (HDD OK if lots of RAM for kernel caching), **BTRFS or ZFS** (EXT4 OK with Garage-Snapshot)
* Database: **LMDB is default, more tested, more performant assuming stable power and reliable storage**. Otherwise use SQLite. Always use SQLite on a 32 bit system.
* Metadata may get corrupt, e.g. after a power outage: **Setup Garage-Snapshot** (SQLite is more resilient to frequent unclean shutdown)
* (Use SQLite if you want to be able to migrate Metadata to a different architecture without resyncing, e.g. from AMD64 to ARM64.)
* `blocksize = "10M"` if you have FTTH and plan to store mostly large files, **leave blocksize to default otherwise**

**Recommended** (minimal) data-center config:
* Data partition: on **SSD** (HDD OK if no high-performance storage), **XFS**, BTRFS & ZFS OK too
* Metadata partition: on **SSD**. **BTRFS or ZFS with Garage-Snapshot** (`ext4` with Garage-Snapshot)
* (You may replace Garage-Snapshot with filesystem snapshots if you stop garage during the snapshot)
* Database: **LMDB** (SQLite if on 32-bit architecture)
* `blocksize = "10M"` if you plan to store mostly large files, **leave blocksize to default otherwise**

## Simple self-hosting Backups use-case

* Yunohost installed on a 60GB SSD (NVME or SATA)
* `/` is mounted on `ext4` partition `/dev/sda1` and so is `/home/yunohost.app/garage/`
* An empty 16TB HDD `/dev/sdb` (USB3 or SATA, USB2 should be avoided)
* Create a 16TB partition `/dev/sdb1` for the Data
* Type `/dev/sdb1` for the Data and `no` for the Metadata at install
* `/dev/sdb1` will be formatted in `xfs` and mounted on `/home/yunohost.app/garage/data`
* Garage will take Snapshots of your LMDB database regularly
* Approximately 3% of the Data stored on your HDD will be used for Metadata. So check that it does not fill your SDD.
* In case of Failure of your Node, try to Restore the App, if it fails, follow [the Garage Doc](https://garagehq.deuxfleurs.fr/documentation/operations/recovering/)

## Simple ephemeral service hosting in data-center use-case
* Yunohost installed on a VPS with 4TB SSD, we are in a virtualized environment
* `/` is mounted on `xfs` (or `btrfs` or `zfs`) partition `/dev/sda1` and so is `/home/yunohost.app/garage/`
* Type `no` for the Data and `no` for the Metadata at install
* All Data and Metadata will remain stored on `/dev/sda1` partition
* You have to check that Garage is not filling up your SSD
* Garage will take Snapshots of your LMDB database regularly
* `ext4` is acceptable for `/dev/sda1` only for storage in the GB order or storage of a small quantity of bigger objects

## Advanced high-performance storage use-case

* Yunohost installed on a 8TB SSD (vdisk, USB3, NVME or SATA)
* `/` is mounted on `ext4` partition `/dev/sda1` and so is `/home/yunohost.app/garage/`
* Shrink `/dev/sda1` to free 4120GB space on SSD
* Create a 120GB partition `/dev/sda2` for the Metadata (3% of Data)
* Create a 4TB partition `/dev/sda3` for the Data
* Type `/dev/sda3` for the Data and `/dev/sda2` for the Metadata at install
* `/dev/sda3` will be formatted in `xfs` and mounted on `/home/yunohost.app/garage/data`
* `/dev/sda2` will be formatted in `btrfs` or `zfs` and mounted on `/home/yunohost.app/garage/metadata`

Note: If you already take snapshots of `/dev/sda2` is `btrfs` or `zfs`, you can deactivate Garage Snapshots in `garage.toml` and configure filesystem snapshots instead

## How to create a partition in CLI

* It is recommended to store Data on a HDD or SSD on a XFS partition different from that of YunoHost system. 
* Create a new partition dedicated to Data and give its path at install, e.g. a partition `/dev/sdb1` of 4 TB (4000000000000 = 7812500000 sectors of 512 bytes) on an empty `/dev/sdb` drive:

```sudo fdisk /dev/sdb
Command (m for help): n
Partition number (1-128, default 1): 
First sector (34-15628053134, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-15628053134, default 15628053134): +7812500000
Created a new partition 1 of type 'Linux filesystem' and of size 3.6 TiB.
```

* Do not format the partition, otherwise install will fail. This is a safety to avoid unwillingly erasing important data
  * You can check formatting of a partition with `wipefs /dev/sdb1`, and then actually erase the partitioning with `wipefs -a /dev/sdb1`

## Failure recovery

* In case of Failure of your Node, try to Restore the App, if it fails, follow [the Garage Doc](https://garagehq.deuxfleurs.fr/documentation/operations/recovering/)
