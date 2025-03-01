<!--
NOTA: Este README foi creado automáticamente por <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
NON debe editarse manualmente.
-->

# Garage para YunoHost

[![Nivel de integración](https://apps.yunohost.org/badge/integration/garage)](https://ci-apps.yunohost.org/ci/apps/garage/)
![Estado de funcionamento](https://apps.yunohost.org/badge/state/garage)
![Estado de mantemento](https://apps.yunohost.org/badge/maintained/garage)

[![Instalar Garage con YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Le este README en outros idiomas.](./ALL_README.md)*

> *Este paquete permíteche instalar Garage de xeito rápido e doado nun servidor YunoHost.*  
> *Se non usas YunoHost, le a [documentación](https://yunohost.org/install) para saber como instalalo.*

## Vista xeral

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


**Versión proporcionada:** 1.0.1~ynh1
## Documentación e recursos

- Web oficial da app: <https://garagehq.deuxfleurs.fr/>
- Documentación oficial para usuarias: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Documentación oficial para admin: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Repositorio de orixe do código: <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- Tenda YunoHost: <https://apps.yunohost.org/app/garage>
- Informar dun problema: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Info de desenvolvemento

Envía a túa colaboración á [rama `testing`](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Para probar a rama `testing`, procede deste xeito:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
ou
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Máis info sobre o empaquetado da app:** <https://yunohost.org/packaging_apps>
