<!--
N.B.: README ini dibuat secara otomatis oleh <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Ini TIDAK boleh diedit dengan tangan.
-->

# Garage untuk YunoHost

[![Tingkat integrasi](https://apps.yunohost.org/badge/integration/garage)](https://ci-apps.yunohost.org/ci/apps/garage/)
![Status kerja](https://apps.yunohost.org/badge/state/garage)
![Status pemeliharaan](https://apps.yunohost.org/badge/maintained/garage)

[![Pasang Garage dengan YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Baca README ini dengan bahasa yang lain.](./ALL_README.md)*

> *Paket ini memperbolehkan Anda untuk memasang Garage secara cepat dan mudah pada server YunoHost.*  
> *Bila Anda tidak mempunyai YunoHost, silakan berkonsultasi dengan [panduan](https://yunohost.org/install) untuk mempelajari bagaimana untuk memasangnya.*

## Ringkasan

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


**Versi terkirim:** 0.9.4~ynh1
## Dokumentasi dan sumber daya

- Website aplikasi resmi: <https://garagehq.deuxfleurs.fr/>
- Dokumentasi pengguna resmi: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Dokumentasi admin resmi: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Depot kode aplikasi hulu: <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- Gudang YunoHost: <https://apps.yunohost.org/app/garage>
- Laporkan bug: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Info developer

Silakan kirim pull request ke [`testing` branch](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Untuk mencoba branch `testing`, silakan dilanjutkan seperti:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
atau
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Info lebih lanjut mengenai pemaketan aplikasi:** <https://yunohost.org/packaging_apps>
