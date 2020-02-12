[![Docker Repository on Quay.io](https://quay.io/repository/digitalprivacy/kubernetes-bind/status "Docker Repository on Quay.io")](https://quay.io/repository/digitalprivacy/kubernetes-bind)

# digitalprivacy/bind:0.2

- [Introduction](#introduction)
  - [Contributing](#contributing)
  - [Issues](#issues)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Quickstart](#quickstart)
  - [Command-line arguments](#command-line-arguments)
  - [Persistence](#persistence)
- [Maintenance](#maintenance)
  - [Upgrading](#upgrading)
  - [Shell Access](#shell-access)

# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for [BIND](https://www.isc.org/downloads/bind/) DNS server.

BIND is open source software that implements the Domain Name System (DNS) protocols for the Internet. It is a reference implementation of those protocols, but it is also production-grade software, suitable for use in high-volume and high-reliability applications.

## Contributing

If you find this image useful here's how you can help:

- Send a pull request with your awesome features and bug fixes
- Help users resolve their [issues](../../issues?q=is%3Aopen+is%3Aissue).
- Support the development of this image with a [donation](BTC: 1NXrjqfJ753X8pxsSw1NWL6GZYAxUvSuzB)

## Issues

- Scaleway (Online.net) is known to drop SOA requests randomly.

# Getting started

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/digitalprivacy/docker-bind) and is the recommended method of installation.

> **Note**: Builds are also available on [Quay.io](https://quay.io/repository/digitalprivacy/kubernetes-bind)

```bash
docker pull digitalprivacy/bind:0.2
```

Alternatively you can build the image yourself.

```bash
docker build -t digitalprivacy/bind .
```

## Quickstart

Start BIND using:

```bash
docker run --name bind -d --restart=always \
  --publish 53:53/tcp --publish 53:53/udp --publish 10000:10000/tcp \
  --volume /srv/docker/bind:/data \
  digitalprivacy/bind:0.2
```

## Command-line arguments

You can customize the launch command of BIND server by specifying arguments to `named` on the `docker run` command. For example the following command prints the help menu of `named` command:

```bash
docker run --name bind -it --rm \
  --publish 53:53/tcp --publish 53:53/udp --publish 10000:10000/tcp \
  --volume /srv/docker/bind:/data \
  digitalprivacy/bind:0.1 -h
```

## Persistence

For the BIND to preserve its state across container shutdown and startup you should mount a volume at `/data`.

> *The [Quickstart](#quickstart) command already mounts a volume for persistence.*

SELinux users should update the security context of the host mountpoint so that it plays nicely with Docker:

```bash
mkdir -p /srv/docker/bind
chcon -Rt svirt_sandbox_file_t /srv/docker/bind
```
