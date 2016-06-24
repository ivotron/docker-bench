FROM debian:jessie

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git build-essential bison flex && \
    git clone git://git.code.sf.net/p/filebench/code filebench-src && \
    cd filebench-src && \
    git checkout filebench-1.5 && \
    cd /filebench-src && ./configure && \
    make -j4 && \
    apt-get remove --purge -y git build-essential bison flex wget $(apt-mark showauto) && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mv /filebench-src/filebench /usr/bin && \
    mv /filebench-src/workloads /workloads && \
    rm -r /filebench-src/ && \
    sed -i -s 's/\/tmp/\/mnt/' /workloads/*.f
ADD entrypoint.sh /root/
ENTRYPOINT ["/root/entrypoint.sh"]
