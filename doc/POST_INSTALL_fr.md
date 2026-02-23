Votre Nœud Garage a été installé. Vous pouvez maintenant vous connecter à d'autres Nœuds (et d'autres se connecter au vôtre) avec les identifiants suivants :

	rpc_secret : __RPC_SECRET__
	bootstrap_peers : __SELF_BOOTSTRAP_PEERS__
	
Layout actuel du Garage : __GARAGE_LAYOUT__

Le Port RPC est __PORT__
Le Port de l'API S3 est __PORT_API__ (accès local HTTP) mais vous devez utiliser le Port 443 (reverse proxy HTTPS avec NGINX) dans les paramètres de votre client.
Le Endpoint Web (pour un accès public HTTP, pour un site Web statique ou des fichiers de médias sociaux) est __PORT_WEB__, et si vous voulez l'utiliser, vous devez autoriser le site web pour le Bucket, et installer une Application `redirect_ynh` pointant vers `127.0.0.1:__PORT_WEB__`, depuis le Domaine `bucketname.__DOMAIN__`.
