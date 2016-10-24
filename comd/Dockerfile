FROM ivotron/openmpi

RUN wget --no-check-certificate https://github.com/exmatex/CoMD/tarball/master -O - | tar xz && \
    mv exmatex* comd && \
    cd comd/src-mpi/ && \
    cp Makefile.vanilla Makefile && \
    sed -i 's/ -O5//' Makefile && \
    make && \
    sed -i 's/DO_MPI = ON/DO_MPI = OFF/' Makefile && \
    make
ENTRYPOINT ["mpirun_docker", "/comd/bin/CoMD-mpi"]
