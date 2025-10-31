# Configuration recommandée
Supposons que vous avez un SSD `/dev/sda` et une partition `/dev/sda1` formatée en `ext4` ou `btrfs` sur laquelle est installé YunoHost. Vous avez en plus un HDD ou SSD vierge `/dev/sdb` pour le stockage Garage.

## Pour les données

* Créer une partition `/dev/sdb1` dédiée aux Data sur un HDD ou SSD, ex. pour une partition de 4 TB (7812500000 secteurs de 512 bytes) sur `/dev/sdb` :

```sudo fdisk /dev/sdb
Command (m for help): n
Partition number (1-128, default 1): 
First sector (34-15628053134, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-15628053134, default 15628053134): +7812500000
Created a new partition 1 of type 'Linux filesystem' and of size 3.6 TiB.```

* Formatter en XFS `sudo mkfs.xfs -L data_xfs -m crc=1 /dev/sdb1`
* Récupérer l'UUID de la partition
* Editer `/etc/fstab` en ajoutant la ligne :

`UUID=xxxxxxxxxxxxx /mnt/data_xfs xfs defaults 0 0`

* Monter les Data Garage `/home/yunohost.app/garage/data` sur `/mnt/data_xfs/data_garage` ou `/mnt/data_xfs`

## Pour les métadonnées

Si la partition `/dev/sda1` où est monté `/home/yunohost.app/` est partitionnée en `btrfs` ou `zfs`, les métadonnées seront stockées directement dans `/home/yunohost.app/garage/data`. Sinon :

* Créer une partition `/dev/sda2` dédiée aux métadonnées sur un SSD
* Formatter en BTRFS (ou ZFS) `sudo mkfs.btrfs -L metadata_btrfs -m crc=1 /dev/sda1`
* Récupérer l'UUID de la partition
* Editer `/etc/fstab` en ajoutant la ligne:

`UUID=xxxxxxxxxxxxx /mnt/metadata_btrfs btrfs defaults 0 0`

* Monter les métadonnées Garage `/home/yunohost.app/garage/metadata` sur `/mnt/metadata_btrfs/metadata_garage` ou `/mnt/metadata_btrfs`


# Autre configuration possible (déconseillé)

* Possible seulement si la virtualisation qemu est disponible
* L'app garage_ynh va essayer de créer un disque virtuel pour les data et metadata
* Les performances sont certainement très amoindries
* Le disque virtuel permet d'éviter que Garage dépasse l'espace disque prévu 

# Limitations

 * Cette application n'est pas utilisable si vous ne faites pas partie d'un cluster avec un minimum de 3 autres noeuds.
 * Si vous êtes derrière un nat et que vous utilisez upnp pour configurer votre redirection de port, vous devrez peut-être ajouter des pairs via le panneau de configuration au lieu de le faire pendant l'installation et/ou créer une redirection permanente dans votre routeur/boîtier.
 
# Informations à connaître :

 * Cette application fournit un noeud que vous pouvez connecter à un cluster de garage. Quelques options sont gérables par le panneau de configuration pour le noeud actuel mais il n'offre pas de moyen plus simple pour gérer les seaux et les clés. Vous devez le faire en ligne de commande ou laisser un autre noeud le gérer.
 * Il est de votre responsabilité de vérifier l'espace utilisé par garage. Normalement il ne devrait pas dépasser le "nombre de Go à allouer pour le stockage" demandé à l'installation (Poids du noeud Garage).
 * Pour se connecter depuis un autre noeud, vous pouvez avoir besoin du port RPC. Il est défini dans `rpc_bind_addr` dans votre `garage.toml`.
 * Consommation de stockage : en dehors du stockage des données, vous pouvez vous attendre à ce que les métadonnées (base de données) consomment approximativement 1% de la taille des données (1GB pour 100GB de données par exemple), ou une valeur plus importante si vous stockez beaucoup de petits objets.

## Comment utiliser l'API S3 à partir d'autres logiciels

L'équipe de Garage fournit de la documentation sur la façon de se connecter avec divers logiciels au cluster S3 : https://garagehq.deuxfleurs.fr/documentation/connect/
Cela permet de se connecter via l'API S3. Dans la configuration de Yunohost, cette connexion est proxiée par le reverse proxy de Nginx. En conséquence, *pour utiliser l'API S3, vous devez utiliser le port 443* au lieu du port API (vu dans la configuration `garage.toml`).

NB : Depuis la ligne de commande locale (comme awscli https://garagehq.deuxfleurs.fr/documentation/connect/cli/) vous pouvez utiliser `localhost:S3API_PORT`.

## Comment utiliser

Le point de terminaison web (pour l'accès public HTTP, pour un site web statique ou des fichiers de médias sociaux) est celui défini dans `s3_web` dans votre `garage.toml`, et si vous voulez l'utiliser, vous devez configurer l'accès au site web pour le bucket, et une application `redirect_ynh` pointant vers `127.0.0.1:WEB_PORT`, en utilisant le domaine `bucketname.DOMAIN`.

## Comment exécuter les commandes pour Garage
1. Utilisez `yunohost app shell garage` pour utiliser la ligne de commande dans l'environnement de Garage (n'oubliez pas de `exit` à la fin). Vous serez situé dans le répertoire `__INSTALL_DIR__`.
2. Ensuite, pour chaque utilisation de la commande `garage`, vous devez spécifier le fichier de configuration en tant que paramètre `garage -c garage.toml [les actions que vous souhaitez exécuter]`.
