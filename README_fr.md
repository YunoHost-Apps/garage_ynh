<!--
Nota bene : ce README est automatiquement généré par <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Il NE doit PAS être modifié à la main.
-->

# Garage pour YunoHost

[![Niveau d’intégration](https://apps.yunohost.org/badge/integration/garage)](https://ci-apps.yunohost.org/ci/apps/garage/)
![Statut du fonctionnement](https://apps.yunohost.org/badge/state/garage)
![Statut de maintenance](https://apps.yunohost.org/badge/maintained/garage)

[![Installer Garage avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Lire le README dans d'autres langues.](./ALL_README.md)*

> *Ce package vous permet d’installer Garage rapidement et simplement sur un serveur YunoHost.*  
> *Si vous n’avez pas YunoHost, consultez [ce guide](https://yunohost.org/install) pour savoir comment l’installer et en profiter.*

## Vue d’ensemble

Garage is an S3-compatible distributed object storage service designed for self-hosting at a small-to-medium scale.

Garage is designed for storage clusters composed of nodes running at different physical locations, in order to easily provide a storage service that replicates data at these different locations and stays available even when some servers are unreachable. Garage also focuses on being lightweight, easy to operate, and highly resilient to machine failures.

### Features

- S3 API
- Standalone/self-contained
- Flexible topology
- No RAFT slowing you down
- Several replication modes
- Web server for static websites
- Bucket names as aliases
- Cluster administration API
- Metrics and traces
- Support for changing IP addresses
- K2V API (experimental)


**Version incluse :** 0.9.4~ynh1
## Documentations et ressources

- Site officiel de l’app : <https://garagehq.deuxfleurs.fr/>
- Documentation officielle utilisateur : <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Documentation officielle de l’admin : <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Dépôt de code officiel de l’app : <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- YunoHost Store : <https://apps.yunohost.org/app/garage>
- Signaler un bug : <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche `testing`](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Pour essayer la branche `testing`, procédez comme suit :

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
ou
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Plus d’infos sur le packaging d’applications :** <https://yunohost.org/packaging_apps>
