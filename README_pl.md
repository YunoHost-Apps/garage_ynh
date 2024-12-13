<!--
To README zostało automatycznie wygenerowane przez <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Nie powinno być ono edytowane ręcznie.
-->

# Garage dla YunoHost

[![Poziom integracji](https://apps.yunohost.org/badge/integration/garage)](https://ci-apps.yunohost.org/ci/apps/garage/)
![Status działania](https://apps.yunohost.org/badge/state/garage)
![Status utrzymania](https://apps.yunohost.org/badge/maintained/garage)

[![Zainstaluj Garage z YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Przeczytaj plik README w innym języku.](./ALL_README.md)*

> *Ta aplikacja pozwala na szybką i prostą instalację Garage na serwerze YunoHost.*  
> *Jeżeli nie masz YunoHost zapoznaj się z [poradnikiem](https://yunohost.org/install) instalacji.*

## Przegląd

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


**Dostarczona wersja:** 1.0.1~ynh1
## Dokumentacja i zasoby

- Oficjalna strona aplikacji: <https://garagehq.deuxfleurs.fr/>
- Oficjalna dokumentacja: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Oficjalna dokumentacja dla administratora: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Repozytorium z kodem źródłowym: <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- Sklep YunoHost: <https://apps.yunohost.org/app/garage>
- Zgłaszanie błędów: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Informacje od twórców

Wyślij swój pull request do [gałęzi `testing`](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Aby wypróbować gałąź `testing` postępuj zgodnie z instrukcjami:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
lub
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Więcej informacji o tworzeniu paczek aplikacji:** <https://yunohost.org/packaging_apps>
