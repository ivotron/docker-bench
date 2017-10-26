FROM ubuntu:zesty

ARG DEBIAN_FRONTEND=noninteractive
ARG GITREF=master

RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/noahdesu/zlog.git /zlog && \
    cd /zlog && \
    git checkout $GITREF && \
    ./install-deps.sh && \
    git submodule update --init --recursive && \
    cmake . && \
    make -j4 && \
    make install && \
    mkdir /zlog/db && \
    mkdir /tmp/db && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY bench.cc /zlog

RUN cd /zlog && \
    g++ -Wall \
      -Isrc -Isrc/include \
      -Lsrc/libzlog -Lsrc/libseq -Lsrc/kvstore \
      -pthread -o kvstore-bench bench.cc \
      -llibkvstore -lboost_system -lzlog_seqr -lzlog

ENV LD_LIBRARY_PATH=/zlog/src/libzlog:/zlog/src/kvstore:/zlog/src/libseq
WORKDIR /zlog/

ENTRYPOINT [ "/zlog/kvstore-bench" ]
