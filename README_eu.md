<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# Garage YunoHost-erako

[![Integrazio maila](https://apps.yunohost.org/badge/integration/garage)](https://ci-apps.yunohost.org/ci/apps/garage/)
![Funtzionamendu egoera](https://apps.yunohost.org/badge/state/garage)
![Mantentze egoera](https://apps.yunohost.org/badge/maintained/garage)

[![Instalatu Garage YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek Garage YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

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


**Paketatutako bertsioa:** 0.9.4~ynh1
## Dokumentazioa eta baliabideak

- Aplikazioaren webgune ofiziala: <https://garagehq.deuxfleurs.fr/>
- Erabiltzaileen dokumentazio ofiziala: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Administratzaileen dokumentazio ofiziala: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Jatorrizko aplikazioaren kode-gordailua: <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- YunoHost Denda: <https://apps.yunohost.org/app/garage>
- Eman errore baten berri: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Garatzaileentzako informazioa

Bidali `pull request`a [`testing` abarrera](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

`testing` abarra probatzeko, ondorengoa egin:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
edo
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Informazio gehiago aplikazioaren paketatzeari buruz:** <https://yunohost.org/packaging_apps>
