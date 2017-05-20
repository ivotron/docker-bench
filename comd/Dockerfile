FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/exmatex/CoMD/tarball/master -O - | tar xz && \
    mv exmatex* comd && \
    cd comd/src-mpi/ && \
    cp Makefile.vanilla Makefile && \
    sed -i 's/ -O5/ -O2/' Makefile && \
    make

WORKDIR /root

ENTRYPOINT ["mpirun_docker", "/comd/bin/CoMD-mpi"]
