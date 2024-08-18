<!--
Важно: этот README был автоматически сгенерирован <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Он НЕ ДОЛЖЕН редактироваться вручную.
-->

# Garage для YunoHost

[![Уровень интеграции](https://dash.yunohost.org/integration/garage.svg)](https://ci-apps.yunohost.org/ci/apps/garage/) ![Состояние работы](https://ci-apps.yunohost.org/ci/badges/garage.status.svg) ![Состояние сопровождения](https://ci-apps.yunohost.org/ci/badges/garage.maintain.svg)

[![Установите Garage с YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[Прочтите этот README на других языках.](./ALL_README.md)*

> *Этот пакет позволяет Вам установить Garage быстро и просто на YunoHost-сервер.*  
> *Если у Вас нет YunoHost, пожалуйста, посмотрите [инструкцию](https://yunohost.org/install), чтобы узнать, как установить его.*

## Обзор

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


**Поставляемая версия:** 1.0.0~ynh1
## Документация и ресурсы

- Официальный веб-сайт приложения: <https://garagehq.deuxfleurs.fr/>
- Официальная документация пользователя: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Официальная документация администратора: <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- Репозиторий кода главной ветки приложения: <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- Магазин YunoHost: <https://apps.yunohost.org/app/garage>
- Сообщите об ошибке: <https://github.com/YunoHost-Apps/garage_ynh/issues>

## Информация для разработчиков

Пришлите Ваш запрос на слияние в [ветку `testing`](https://github.com/YunoHost-Apps/garage_ynh/tree/testing).

Чтобы попробовать ветку `testing`, пожалуйста, сделайте что-то вроде этого:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
или
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**Больше информации о пакетировании приложений:** <https://yunohost.org/packaging_apps>
