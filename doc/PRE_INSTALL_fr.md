Avant d'installer votre noeud Garage :
* On supposera qu'il n'y a pas de point de montage personnalisé pour le système YunoHost, et en particulier pour `/home/yunohost.app/`, sinon optez pour un montage manuel des partitions data et metadata 
* Si vous prévoyez de stocker les données sur un HDD ou SSD différent de celui du système YunoHost
* Y créer une partition dédiée aux Data et renseigner son chemin lors de l'installation, ex. pour une partition `/dev/sdb1` de 4 TB (4000000000000 = 7812500000 secteurs de 512 bytes) sur un disque `/dev/sdb` vierge :

```sudo fdisk /dev/sdb
Command (m for help): n
Partition number (1-128, default 1): 
First sector (34-15628053134, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-15628053134, default 15628053134): +7812500000
Created a new partition 1 of type 'Linux filesystem' and of size 3.6 TiB.```
* Si la partition où est monté `/home/yunohost.app/` n'est pas sur un SSD
  * Migrer YunoHost vers un SSD
* Si la partition où est monté `/home/yunohost.app/` n'est pas partitionnée en `btrfs` ou `zfs`, par exemple `/dev/sda1`
  * Choisir de migrer `/dev/sda1` vers `btrfs`
* Ou créer une nouvelle partition dédiée aux métadonnées sur un SSD et renseigner son chemin lors de l'installation, ex. `/dev/sda2`