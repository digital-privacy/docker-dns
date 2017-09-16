FROM debian:jessie-slim
MAINTAINER alessio@linux.com

ENV BIND_USER=bind \
    BIND_VERSION=1:9.9.5 \
    DATA_DIR=/data

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget bind9=${BIND_VERSION}* bind9-host=${BIND_VERSION}* dnsutils \
 && rm -rf /var/lib/apt/lists/*

COPY srvzone /srvzone 
RUN chown bind.bind /srvzone \
 && chmod 700 /srvzone

COPY named.conf /etc/bind/named.conf
COPY srvzone.conf /srvzone.conf
COPY caching.conf /etc/bind/caching.conf
COPY root.hints /etc/bind/root.hints
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp 10000/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/sbin/named"]
