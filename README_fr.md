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

Garage est un service de stockage d'objets distribués conforme à S3, conçu pour l'auto-hébergement à petite et moyenne échelle.

Garage est conçu pour les clusters de stockage composés de nœuds fonctionnant sur différents sites physiques afin de fournir facilement un service de stockage qui réplique les données sur ces différents sites et reste disponible même lorsque certains serveurs sont indisponibles. Garage est également conçu pour être léger, facile à utiliser et très résistant aux défaillances des machines.

### Caractéristiques

- API S3
- Autonome
- Topologie flexible
- Pas de RAFT pour vous ralentir
- Modes de réplication multiples
- Serveur web pour les sites web statiques
- Noms de dépôts en tant qu'alias
- API de gestion de cluster
- Mesures et traces
- Prise en charge des changements d'adresses IP
- API K2V (expérimentale)


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
