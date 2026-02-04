# Limitations

 * This application is not usable if you're not part of a cluster with minimun 3 other nodes
 * If you are behind a nat and use upnp to configure your port redirection, you may need to add peers via config panel instead of during installation and/or create a permanent redirection in your router/box

# Informations you should be aware of:

 * This application provide a node that you can connect to a garage cluster. Few option are manageable by the config panel for the current node but IT DOESN'T offer simpler way to manage bucket and keys. You have to do it by command line or let an other node managing it.
 * This application consider that the weight of the node is the size reserved to garage in G (Gigabytes)
 * This application will try to create a virtual disk to ensure garage doesn't use more than allowed. If virtualisation is not available your responsible to check space used by garage.
 * To connect from another node, you might need the RPC port. Is is defined in `rpc_bind_addr` in your `garage.toml`
 * Storage consumption : appart from your data storage, you can expect the metadata (database) to consume approximatly 1% of the data size (1GB for 100GB of data for instance), or a bigger value if you store many small objects.

## How to use the S3 API from other softwares

Garage team provides documentation on how to connect with various software to the S3 cluster: https://garagehq.deuxfleurs.fr/documentation/connect/
This will connect via the S3 API. In Yunohost setup, this is proxied through Nginx reverse proxy. As a result, *to use the S3 API, you need to use port 443* instead of the API port (seen in `garage.toml` configuration).

NB: From local command line (such as awscli https://garagehq.deuxfleurs.fr/documentation/connect/cli/) you can use `localhost:S3API_PORT`.

## How to use

The web endpoint (for HTTP public access, for a static website or social media files) is the one defined in `s3_web` in your `garage.toml`, and if you want to use you should setup website access for the bucket, and a `redirect_ynh` app pointing to `127.0.0.1:WEB_PORT`, using the domain `bucketname.DOMAIN`.

## How to run commands for Garage
1. Use `yunohost app shell garage` to use the command line in Garage own environnement (don't forget to `exit` at the end). You will be located in `__INSTALL_DIR__` own directory.
2. Then for each use of the `garage` command, you need to specify the config file as a parameter `garage -c garage.toml [the actions you wish to run]`.

## Configuration depending on your server setup

We distinguish between 2 major setups:
* Self-hosting-like
  * Power outage or cat-unplug likely
  * Networking can be slower or have poor level of service
  * Data storage in the GB or TB order
  * Usage for distributed high-capacity storage, e.g. backups. Not necessarily for performance
  * Recovery from other nodes within a day
* Data-center-like
  * Unclean shutdown unlikely
  * Fast and high-service networking
  * Data storage >10TB
  * Usage for high-performance distributed storage
  * Local Recovery of node within minutes

Recommended / minimal self-hosting config:
* Data partition: on HDD (SSD better), XFS/EXT4
* Metadata partition: on SSD (HDD OK if lots of RAM for kernel caching), BTRFS or ZFS with filesystem snapshot / EXT4 with Garage-snapshot
* Database: LMDB default, more tested, more performant, recommended if Metadata on HDD. SQLite required if possible node architecture can vary or cluster with 32-bit arch. Prefer SQLite which is more robust if Metadata have poor failure recovery, e.g. not on BTRFS/ZFS, poor or no snapshotting 
* `blocksize = "10M"` if you have FTTH and plan to store mostly large files, leave to default otherwise

Recommended data-center config:
* Data partition: on SSD (HDD OK if no high-performance storage), XFS
* Metadata partition: on SSD. BTRFS or ZFS with filesystem snapshot
* Database: LMDB
* `blocksize = "10M"` if you plan to store mostly large files, leave to default otherwise
