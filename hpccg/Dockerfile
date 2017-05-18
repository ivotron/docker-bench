FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/gtcasl/hpc-benchmarks/archive/9b90582.tar.gz -O - | tar xz && \
    mv hpc* hpcb && \
    cd /hpcb/HPCCG-1.0 && \
    make && \
    mv HPCCG.x.mpi /usr/bin/ && \
    cd / && rm -r /hpcb

WORKDIR /root

ADD mpipostrun /usr/bin

ENTRYPOINT ["mpirun_docker", "HPCCG.x.mpi"]
