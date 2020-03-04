# docker run -d --restart=unless-stopped -v monero-data:/home/monero/ -p 18080:18080 -p 18081:18081 --name=monero varnav/monero-node
FROM alpine:3 AS build

LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>"
LABEL Description="Docker image for Monero (XRM) node"
LABEL License="MIT License"

# Chech out https://github.com/monero-project/monero/releases
ENV MONERO_VERSION=0.15.0.1

WORKDIR /root

ADD https://downloads.getmonero.org/cli/monero-linux-x64-v${MONERO_VERSION}.tar.bz2 /root/monero.tar.bz2

RUN tar xf monero.tar.bz2 && \
mv ./monero-x86_64-linux-gnu*/monerod .

FROM ubuntu:20.04

RUN useradd --shell /bin/bash monero && \
mkdir -p /home/monero/.bitmonero && \
chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/
COPY entrypoint.sh /entrypoint.sh

VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["/entrypoint.sh"]