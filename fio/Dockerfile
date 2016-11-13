FROM debian:stretch

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends fio && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD genfio-test /usr/bin
ADD entrypoint.sh /root

WORKDIR /root
ENTRYPOINT ["/root/entrypoint.sh"]
