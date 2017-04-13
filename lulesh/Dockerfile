FROM ivotron/openmpi:v2.0.2

ARG DEBIAN_FRONTEND=noninteractive

ADD remove_defaults.patch /lulesh/

RUN apt-get update && apt-get install -y patch wget && \
    cd /lulesh && \
    wget --no-check-certificate https://codesign.llnl.gov/lulesh/lulesh2.0.3.tgz -O - | tar xz && \
    patch -i remove_defaults.patch && \
    CXX="mpicxx -DUSE_MPI=1" make -j4 && \
    PREFIX=/usr make install && \
    cd / && rm -r /lulesh && \
    apt-get remove --purge -y patch wget && \
    apt -y --purge autoremove && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["mpirun_docker", "lulesh2.0"]
