FROM debian:jessie

RUN apt-get update && \
    apt-get install -y make gcc g++ wget python python-yaml && \
    wget --no-check-certificate https://github.com/ColinIanKing/stress-ng/archive/V0.05.09.tar.gz && \
    tar xfz V0.05.09.tar.gz && \
    mv stress-ng* /stress-ng && \
    sed -i 's/O2/O0/' /stress-ng/Makefile && \
    make -C /stress-ng && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mv /stress-ng/stress-ng /usr/bin
ADD postprocess.py /
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
