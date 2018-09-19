FROM ivotron/openmpi:3.1.1-arm64v8

RUN wget --no-check-certificate https://github.com/gtcasl/hpc-benchmarks/archive/9b90582.tar.gz -O - | tar xz && \
    mv hpc* hpcb && \
    cd /hpcb/HPCCG-1.0 && \
    make && \
    mv HPCCG.x.mpi /usr/bin/ && \
    cd / && rm -r /hpcb

WORKDIR /root

ENTRYPOINT ["mpirun_docker", "HPCCG.x.mpi"]
