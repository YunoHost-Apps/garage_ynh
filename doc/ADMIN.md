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
