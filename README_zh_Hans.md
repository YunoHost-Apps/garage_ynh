<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 上的 Garage

[![集成程度](https://dash.yunohost.org/integration/garage.svg)](https://ci-apps.yunohost.org/ci/apps/garage/) ![工作状态](https://ci-apps.yunohost.org/ci/badges/garage.status.svg) ![维护状态](https://ci-apps.yunohost.org/ci/badges/garage.maintain.svg)

[![使用 YunoHost 安装 Garage](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=garage)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 Garage。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

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


**分发版本：** 0.9.2~ynh1
## 文档与资源

- 官方应用网站： <https://garagehq.deuxfleurs.fr/>
- 官方用户文档： <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- 官方管理文档： <https://garagehq.deuxfleurs.fr/documentation/quick-start/>
- 上游应用代码库： <https://git.deuxfleurs.fr/Deuxfleurs/garage>
- YunoHost 商店： <https://apps.yunohost.org/app/garage>
- 报告 bug： <https://github.com/YunoHost-Apps/garage_ynh/issues>

## 开发者信息

请向 [`testing` 分支](https://github.com/YunoHost-Apps/garage_ynh/tree/testing) 发送拉取请求。

如要尝试 `testing` 分支，请这样操作：

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
或
sudo yunohost app upgrade garage -u https://github.com/YunoHost-Apps/garage_ynh/tree/testing --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>
