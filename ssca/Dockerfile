FROM debian:jessie

RUN apt-get update && \
    apt-get install -y gcc wget make && \
    wget --no-check-certificate https://github.com/gtcasl/hpc-benchmarks/archive/9b90582.tar.gz -O - | tar xz && \
    mv hpc* hpcb && \
    cd /hpcb/SSCA2v2.2/ && \
    mkdir sprng2.0/lib && \
    make && \
    mv SSCA2 /usr/bin && \
    cd && \
    rm -r /hpcb && \
    apt-get purge -y gcc wget make && \
    apt-get autoremove --purge -y && \
    apt-get install -y libgomp1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root

ENTRYPOINT ["SSCA2"]
