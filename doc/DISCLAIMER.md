* Limitations : 
    * This application is not usable if you're not part of a cluster with minimun 3 other nodes
    * If you are behind a nat and use upnp to configure your port redirection, you may need to add peers via config panel instead of during installation and/or create a permanent redirection in your router/box

* infos you should be aware of:
    * This application provide a node that you can connect to a garage cluster. Few option are manageable by the config panel for the current node but IT DOESN'T offer simpler way to manage bucket and keys. You have to do it by command line or let an other node managing it.
    * This application consider that the weight of the node is the size reserved to garage in G 
    * This application will try to create a virtual disk to ensure garage doesn't use more than allowed. If virtualisation is not available your responsible to check space used by garage.
