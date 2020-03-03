# docker run -d --restart=unless-stopped -v monero-data:/home/monero/ -p 18080:18080 -p 18081:18081 --name=monero varnav/monero-node
FROM ubuntu:20.04 AS build

LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>"
LABEL Description="Docker image for Monero (XRM) node"
LABEL License="MIT License"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root

RUN curl --retry 5 --retry-delay 2 -Lo monero.tar.bz2 https://downloads.getmonero.org/cli/linux64 && \
  tar xf monero.tar.bz2 && \
  mv ./monero-x86_64-linux-gnu*/monerod .
  
FROM ubuntu:20.04

RUN useradd --shell /bin/bash monero && \
  mkdir -p /home/monero/.bitmonero && \
  chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod
COPY entrypoint.sh /entrypoint.sh

VOLUME /home/monero/

EXPOSE 18080 18081

ENTRYPOINT ["/entrypoint.sh"]