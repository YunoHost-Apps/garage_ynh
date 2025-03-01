# Limitations

 * Cette application n'est pas utilisable si vous ne faites pas partie d'un cluster avec un minimum de 3 autres noeuds.
 * Si vous êtes derrière un nat et que vous utilisez upnp pour configurer votre redirection de port, vous devrez peut-être ajouter des pairs via le panneau de configuration au lieu de le faire pendant l'installation et/ou créer une redirection permanente dans votre routeur/boîtier.

# Informations à connaître :

 * Cette application fournit un noeud que vous pouvez connecter à un cluster de garage. Quelques options sont gérables par le panneau de configuration pour le noeud actuel mais il n'offre pas de moyen plus simple pour gérer les seaux et les clés. Vous devez le faire en ligne de commande ou laisser un autre noeud le gérer.
 * Cette application considère que le poids du noeud est la taille réservée au garage en G (Gigaoctets).
 * Cette application va essayer de créer un disque virtuel pour s'assurer que le garage n'utilise pas plus que ce qui est autorisé. Si la virtualisation n'est pas disponible, il est de votre responsabilité de vérifier l'espace utilisé par le garage.
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
