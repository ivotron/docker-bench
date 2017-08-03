FROM debian:jessie

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/noahdesu/zlog.git /src && \
    cd /src && \
    ./install-deps.sh && \
    git submodule update --init --recursive && \
    cmake . && \
    make -j4 && \
    make install && \
    mkdir /db && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /src/db

WORKDIR /src/

ENTRYPOINT [ "src/kvstore/bench" ]
