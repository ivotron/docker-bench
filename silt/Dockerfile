FROM debian:jessie

RUN apt-get update && apt-get install -y \
        wget libtbb-dev libgtest-dev libboost-thread-dev libssl-dev \
        libxerces-c-dev libgsl0-dev libdb-dev autoconf \
        automake g++ libtool cmake && \
    cd /usr/src/gtest && cmake . && make && mv libg* /usr/lib/ && cd / && \
    wget --no-check-certificate https://github.com/silt/silt/tarball/master -O - | tar xz && \
    mv silt* silt && cd silt && autoreconf -is && ./configure && make -j4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
