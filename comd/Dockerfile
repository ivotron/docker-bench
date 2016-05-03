FROM debian:jessie

RUN apt-get update && apt-get install -y wget libopenmpi-dev make && \
    wget --no-check-certificate https://github.com/exmatex/CoMD/tarball/master -O - | tar xz && \
    mv exmatex* comd && \
    cd comd/src-mpi/ && \
    cp Makefile.vanilla Makefile && \
    sed -i 's/DO_MPI = ON/DO_MPI = OFF/' Makefile && \
    sed -i 's/ -O5//' Makefile && \
    make && \
    apt-get remove --purge -y libopenmpi-dev wget make $(apt-mark showauto) && \
    apt-get install -y libopenmpi1.6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh /comd/bin/
WORKDIR /comd/bin
ENTRYPOINT ["/comd/bin/entrypoint.sh"]
