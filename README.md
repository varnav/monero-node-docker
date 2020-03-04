# Monero (XRM) Docker Node

![Validate code](https://github.com/varnav/monero-node-docker/workflows/Validate%20code/badge.svg)![Docker Image Build](https://github.com/varnav/monero-node-docker/workflows/Docker%20Image%20Build/badge.svg)[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/monero-node.svg)](https://hub.docker.com/r/varnav/monero-node)

#### Open firewall

`ufw allow 18080/tcp`

#### Run interactively

```bash
docker run --rm -it -v monero-data:/home/monero/ -p 18080:18080 -p 18081:18081 varnav/monero-node
```

#### Run as daemon

```bash
docker run -d --restart=unless-stopped -v monero-data:/home/monero/ -p 18080:18080 -p 18081:18081 --name=monero varnav/monero-node
```

#### Run with kubernetes

```
kubectl apply -f .\kubernetes-deployment.yml
kubectl expose deployment monero-node --type LoadBalancer
```

#### Build

It's recommended to build this on same machine where you plan to run it.

```bash
git clone https://github.com/varnav/monero-node-docker.git
cd monero-node-docker
docker build -t varnav/monero-node .
```

#### License

MIT

#### Thanks to

kannix