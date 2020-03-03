# docker run -d --restart=unless-stopped -v monero-data:/home/monero/ -p 18080:18080 -p 18081:18081 --name=monero varnav/monero-node
FROM ubuntu:18.04 AS build

LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>"
LABEL Description="Docker image for TON (Telegram open network) node"
LABEL License="MIT License"

ENV DEBIAN_FRONTEND=noninteractive

ENV MONERO_VERSION=0.14.1.0 MONERO_SHA256=2b95118f53d98d542a85f8732b84ba13b3cd20517ccb40332b0edd0ddf4f8c62

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root

RUN curl -o monero.tar.bz2 https://downloads.getmonero.org/cli/linux64 && \
  tar -xf monero.tar.bz2 && \
  cp ./monero-x86_64-linux-gnu/monerod .
  
FROM ubuntu:18.04

RUN useradd -ms /bin/bash monero && mkdir -p /home/monero/.bitmonero && chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod
COPY entrypoint.sh /entrypoint.sh

VOLUME /home/monero/

EXPOSE 18080 18081

ENTRYPOINT ["/entrypoint.sh"]