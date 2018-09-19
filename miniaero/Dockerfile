FROM ivotron/openmpi:3.1.1-arm64v8

RUN wget --no-check-certificate https://github.com/mantevo/miniaero/archive/f46d135.tar.gz -O - | tar xz && \
    wget --no-check-certificate https://github.com/kokkos/kokkos/archive/36b92f4.tar.gz -O - | tar xz && \
    mv kokkos* /root/kokkos && \
    mv miniA* miniaero && \
    cd /miniaero/kokkos && \
    make -j4 -f Makefile.mpi && \
    mv miniAero.mpi /usr/bin/ && \
    cd / && \
    mv /miniaero/kokkos/tests / && \
    rm -r /root/kokkos && \
    rm -r /miniaero/* && \
    mv /tests /miniaero/ && \
    cp /miniaero/tests/3D_Sod_Parallel/miniaero.inp /root


WORKDIR /root

ENTRYPOINT ["mpirun_docker", "miniAero.mpi"]
