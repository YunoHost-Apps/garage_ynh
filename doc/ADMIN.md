# Limitations
 * Garage can be used with only one or two servers (=replica), but requires a cluster with at least 3 nodes to provide its full replication potential (loss prevention). See [replication modes](https://garagehq.deuxfleurs.fr/documentation/reference-manual/configuration/#replication-mode). It is mainly designed to be used with 3 nodes.
 * If you are behind a nat and use upnp to configure your port redirection, you may need to add peers via config panel instead of during installation and/or create a permanent redirection in your router/box

# Informations you should be aware of:
 * This application provide a node that you can connect to a garage cluster. Few option are manageable by the config panel for the current node but IT DOESN'T offer simpler way to manage bucket and keys. You have to do it by command line or let an other node managing it.
  * This application consider that the weight of the node is the size reserved to garage in G (Gigabytes)
 * This application will try to create a virtual disk to ensure garage doesn't use more than allowed. If virtualisation is not available your responsible to check space used by garage.

## How to use the S3 API from other softwares

Garage team provides documentation on how to connect with various software to the S3 cluster : https://garagehq.deuxfleurs.fr/documentation/connect/
This will connect via the S3 API. In Yunohost setup, this is proxied through Nginx reverse proxy. As a result, *to use the S3 API, you need to use port 443* instead of the API port (seen in `garage.toml` configuration).

NB: From local command line (such as awscli https://garagehq.deuxfleurs.fr/documentation/connect/cli/) you can use `localhost:S3API_PORT`.


## How to run commands for Garage
1. Use `yunohost app shell garage` to use the command line in Garage own environnement (don't forget to `exit` at the end). You will be located in `/opt/yunohost/garage/` own directory.
2. Then for each use of the `garage` command, you need to specify the config file as a parameter `garage -c garage.toml [the actions you wish to run]`.
