<!--
NB: Deze README is automatisch gegenereerd door <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Hij mag NIET handmatig aangepast worden.
-->

# Garage voor Yunohost

[![Integratieniveau](https://apps.yunohost.org/badge/integration/garage)](https://ci-apps.yunohost.org/ci/apps/garage/)
![Mate van functioneren](https://apps.yunohost.org/badge/state/garage)
![Onderhoudsstatus](https://apps.yunohost.org/badge/maintained/garage)

[![Garage met Yunohost installeren](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Deze README in een andere taal lezen.](./ALL_README.md)*

> *Met dit pakket kun je Garage snel en eenvoudig op een YunoHost-server installeren.*  
> *Als je nog geen YunoHost hebt, lees dan [de installatiehandleiding](https://yunohost.org/install), om te zien hoe je 'm installeert.*

## Overzicht

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


**Geleverde versie:** 0.9.4~ynh1
## Documentatie en bronnen

- Officiele website van de app: <https://garagehq.deuxfleurs.fr/>
- Officiele gebruikersdocumentatie: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Officiele beheerdersdocumentatie: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Upstream app codedepot: <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- YunoHost-store: <https://apps.yunohost.org/app/garage>
- Meld een bug: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Ontwikkelaarsinformatie

Stuur je pull request alsjeblieft naar de [`testing`-branch](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Om de `testing`-branch uit te proberen, ga als volgt te werk:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
of
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Verdere informatie over app-packaging:** <https://yunohost.org/packaging_apps>
