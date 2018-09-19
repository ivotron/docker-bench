FROM debian:9.3-slim

ARG LIKWID_VERSION=master

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
      git ca-certificates build-essential python-minimal python-yaml && \
    git clone https://github.com/RRZE-HPC/likwid && \
    cd likwid && \
    git checkout $LIKWID_VERSION && \
    sed -i 's/INSTRUMENT_BENCH.*/INSTRUMENT_BENCH = false#NO SPACE/' config.mk && \
    sed -i 's/COMPILER = .*/COMPILER = GCCARMv8/' config.mk && \
    make && \
    make install && \
    cd && \
    rm -rf likwid && \
    apt purge -y git build-essential ca-certificates && \
    apt autoremove -y && \
    apt clean

WORKDIR root

COPY scripts/* /usr/bin/
COPY entrypoint.sh /root/
COPY sets /root/sets

ENTRYPOINT ["/root/entrypoint.sh"]
