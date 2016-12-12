FROM debian:jessie

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y make g++ wget && \
    wget --no-check-certificate https://github.com/ColinIanKing/stress-ng/archive/V0.07.09.tar.gz && \
    tar xfz V0.07.09.tar.gz && \
    mv stress-ng* /stress-ng && \
    make -C /stress-ng && \
    mv /stress-ng/stress-ng /usr/bin && \
    rm -r /stress-ng && \
    apt-get remove -y make g++ wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["stress-ng"]
