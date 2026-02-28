Your Garage Node is installed. You can now connect to other Nodes (and others connect to yours) with the following identifiers:

	rpc_secret: __RPC_SECRET__
	bootstrap_peers: __SELF_BOOTSTRAP_PEERS__
	
Current Garage Layout: __GARAGE_LAYOUT__

The RPC Port is __PORT__
The S3 API Port is __PORT_API__ (local HTTP access) but you should use Port 443 (HTTPS reverse proxy with Nginx) in your client settings
The Web Endpoint (for HTTP public access, for a static website or social media files) is __PORT_WEB__, and if you want to use it you should setup website access for the Bucket, and install a `redirect_ynh` App pointing to `127.0.0.1:__PORT_WEB__`, using the Domain `bucketname.__DOMAIN__`.
