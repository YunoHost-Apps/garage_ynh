<!--
N.B.: Questo README è stato automaticamente generato da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
NON DEVE essere modificato manualmente.
-->

# Garage per YunoHost

[![Livello di integrazione](https://dash.yunohost.org/integration/garage.svg)](https://dash.yunohost.org/appci/app/garage) ![Stato di funzionamento](https://ci-apps.yunohost.org/ci/badges/garage.status.svg) ![Stato di manutenzione](https://ci-apps.yunohost.org/ci/badges/garage.maintain.svg)

[![Installa Garage con YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Leggi questo README in altre lingue.](./ALL_README.md)*

> *Questo pacchetto ti permette di installare Garage su un server YunoHost in modo semplice e veloce.*  
> *Se non hai YunoHost, consulta [la guida](https://yunohost.org/install) per imparare a installarlo.*

## Panoramica

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


**Versione pubblicata:** 0.9.2~ynh1
## Documentazione e risorse

- Sito web ufficiale dell’app: <https://garagehq.deuxfleurs.fr/>
- Documentazione ufficiale per gli utenti: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Documentazione ufficiale per gli amministratori: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Repository upstream del codice dell’app: <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- Store di YunoHost: <https://apps.yunohost.org/app/garage>
- Segnala un problema: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Informazioni per sviluppatori

Si prega di inviare la tua pull request alla [branch di `testing`](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Per provare la branch di `testing`, si prega di procedere in questo modo:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
o
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Maggiori informazioni riguardo il pacchetto di quest’app:** <https://yunohost.org/packaging_apps>
