# 使用 Docker 运行项目指引

## 概述

根据项目需要，我们构建了一个基于 Ubuntu16.04 的 Docker 镜像，完成了项目运行所需环境的自动配置，在安装有 Docker 的机器上，只需要 clone 本项目并下载 PA-Datalog Engine，就可以傻瓜式地完成项目所需运行环境的搭建。

## PA-Datalog 下载

由于协议限制，PA-Datalog的安装只能通过手动下载 `.deb` 安装包来进行。下载地址为：[http://snf-705535.vm.okeanos.grnet.gr/agreement.html](http://snf-705535.vm.okeanos.grnet.gr/agreement.html)，在同意对应的协议后选择 Ubuntu16.04LTS 对应的版本执行下载。下载完成后，将安装包 `./datalog/pa-datalog_0.5-1xenial.deb` 放在项目目录下的 `\datalog` 文件夹即可。

## Docker 镜像构建

在下载好 PA-Datalog Engine 后，执行以下命令即可构建项目对应的 Docker 镜像：

```bash
docker build -t zipper:0.1.5 .
```

构建完成后，可以通过以下命令查看镜像：

```bash
docker images
```

其中，`zipper:0.1.5` 为构建的镜像名，可以根据需要自行修改。

## Docker 容器运行

在构建好镜像后，可以通过以下命令运行容器：

```bash
docker run -it --name zipper -v path/zipper:/home/project zipper:0.1.5
```

其中，`path/` 为本机上项目所在的地址，`zipper` 为容器名，可以根据需要自行修改。镜像中的 `/home/project` 为项目所在的目录，可以进行对应的运行。

如果使用 [VSCode](https://code.visualstudio.com/) 连接容器进行开发，可以通过以下命令运行容器以此来同步 VS Code 对应的设置项：

```bash
docker run --rm --name zipper -it -d -v ~/vscode-extension/.vscode-server:/root/.vscode-server -v path/zipper:/home/project zipper:0.1.5
```

其中，`~/vscode-extension/.vscode-server` 为 VS Code 的配置文件所在的目录，`path/zipper` 为项目所在的目录，可以根据需要自行修改。这里为了便于连接操作，我们将容器设置为后台运行，可以通过以下命令查看容器：

```bash
docker ps
```

## 项目运行

