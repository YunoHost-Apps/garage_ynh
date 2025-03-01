<!--
Este archivo README esta generado automaticamente<https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
No se debe editar a mano.
-->

# Garage para Yunohost

[![Nivel de integración](https://apps.yunohost.org/badge/integration/garage)](https://ci-apps.yunohost.org/ci/apps/garage/)
![Estado funcional](https://apps.yunohost.org/badge/state/garage)
![Estado En Mantención](https://apps.yunohost.org/badge/maintained/garage)

[![Instalar Garage con Yunhost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Leer este README en otros idiomas.](./ALL_README.md)*

> *Este paquete le permite instalarGarage rapidamente y simplement en un servidor YunoHost.*  
> *Si no tiene YunoHost, visita [the guide](https://yunohost.org/install) para aprender como instalarla.*

## Descripción general

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


**Versión actual:** 1.0.1~ynh1
## Documentaciones y recursos

- Sitio web oficial: <https://garagehq.deuxfleurs.fr/>
- Documentación usuario oficial: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Documentación administrador oficial: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Repositorio del código fuente oficial de la aplicación : <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- Catálogo YunoHost: <https://apps.yunohost.org/app/garage>
- Reportar un error: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Información para desarrolladores

Por favor enviar sus correcciones a la [rama `testing`](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Para probar la rama `testing`, sigue asÍ:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
o
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Mas informaciones sobre el empaquetado de aplicaciones:** <https://yunohost.org/packaging_apps>
