FROM ivotron/openmpi:3.1.1-arm64v8

ARG DEBIAN_FRONTEND=noninteractive

ADD remove_defaults.patch /tmp/

RUN apt-get update && apt-get install -y patch git && \
    git clone https://github.com/LLNL/LULESH.git lulesh && \
    cd lulesh && \
    patch -i /tmp/remove_defaults.patch && \
    CXX="mpicxx -DUSE_MPI=1" make -j4 && \
    PREFIX=/usr make install && \
    cd / && rm -r /lulesh && \
    apt-get remove --purge -y patch git && \
    apt -y --purge autoremove && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["mpirun_docker", "lulesh2.0"]
