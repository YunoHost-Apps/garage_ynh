Votre nœud Garage a été installé. Vous pouvez maintenant vous connecter à d'autres nœuds avec les identifiants suivants :

	rpc_secret : __RPC_SECRET__
	bootstrap_peers : __SELF_BOOTSTRAP_PEERS__
	
Disposition actuelle du garage : __GARAGE_LAYOUT__

Le port RPC est __PORT__
Le port de l'API S3 est __PORT_API__ mais vous devez utiliser le port 443 (HTTPS reverse proxy avec NGINX) dans les paramètres de votre client.
Le point de terminaison Web (pour un accès public HTTP, pour un site Web statique ou des fichiers de médias sociaux) est __PORT_WEB__, et si vous voulez l'utiliser, vous devez configurer l'accès au site web pour le bucket, et une application `redirect_ynh` pointant vers `127.0.0.1:__PORT_WEB__`, en utilisant le domaine `bucketname.__DOMAIN__`.
