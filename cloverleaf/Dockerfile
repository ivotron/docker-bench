FROM debian:jessie

RUN apt-get update && apt-get install -y wget make gcc gfortran && \
    wget --no-check-certificate https://github.com/UK-MAC/CloverLeaf_Serial/tarball/master -O - | tar xz && \
    mv UK* cloverleaf && \
    cd cloverleaf/ && \
    sed -i 's/FLAGS_GNU.*/FLAGS_GNU=/' Makefile && \
    COMPILER=GNU MPI_COMPILER=gfortran C_MPI_COMPILER=gcc make && \
    apt-get remove --purge -y gcc wget make gcc gfortran $(apt-mark showauto) && \
    apt-get install -y time libgfortran3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh /usr/bin/
WORKDIR /cloverleaf
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
