FROM ivotron/openmpi:v2.0.2

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get --no-install-recommends -y install \
      python libpapi-dev libpci-dev libpopt-dev uuid-dev python-dev perl texinfo && \
    apt-get autoremove --purge -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget --no-check-certificate https://github.com/lanl/conceptual/tarball/v1.5.1 -O - | tar xz && \
    mv lanl* /conceptual && \
    cd /conceptual && \
    CC=mpicc ./configure && \
    (make || true) && \
    make && \
    make install && \
    cd / && \
    rm -r /conceptual

ENV LD_LIBRARY_PATH=/usr/local/lib

ADD build_examples.sh /root/
RUN cd /root && ./build_examples.sh && \
    rm /root/build_examples.sh && ldconfig

ADD mpipostrun /usr/bin/
