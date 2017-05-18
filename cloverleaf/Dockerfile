FROM ivotron/openmpi:v2.0.2

RUN apt-get update && \
    apt-get install -y git gfortran && \
    git clone --recursive https://github.com/UK-MAC/CloverLeaf && \
    cd CloverLeaf/ && \
    make COMPILER=GNU mpi && \
    mv CloverLeaf_MPI/clover.in /root/ && \
    mv CloverLeaf_MPI/clover_leaf /usr/bin/ && \
    cd / && \
    rm -fr CloverLeaf_MPI && \
    apt-get purge -y gfortran git && \
    apt-get autoremove --purge -y && \
    apt-get install libgfortran-6-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root

ADD mpipostrun /usr/bin

ENTRYPOINT ["mpirun_docker", "clover_leaf"]
