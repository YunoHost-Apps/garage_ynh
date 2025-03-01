Your Garage node have been installed. You can now connect to other nodes with the following identifiers :

	rpc_secret: __RPC_SECRET__
	bootstrap_peers: __SELF_BOOTSTRAP_PEERS__
	
Current garage layout: __GARAGE_LAYOUT__

The RPC port is __PORT__
The S3 API port is __PORT_API__ but you should use port 443 (HTTPS reverse proxy with Nginx) in your client settings
The web endpoint (for HTTP public access, for a static website or social media files) is __PORT_WEB__, and if you want to use you should setup website access for the bucket, and a `redirect_ynh` app pointing to `127.0.0.1:__PORT_WEB__`, using the domain `bucketname.__DOMAIN__`.
