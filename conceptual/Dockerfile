FROM ivotron/openmpi

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python libpapi-dev libpci-dev libpopt-dev uuid-dev && \
    apt-get autoremove --purge -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget http://downloads.sourceforge.net/project/conceptual/conceptual/1.5.1/conceptual_1.5.1-1_amd64.deb && \
    dpkg -i conceptual_1.5.1-1_amd64.deb && \
    rm conceptual_1.5.1-1_amd64.deb

ADD build_examples.sh /root/
ADD entrypoint.sh /root/
RUN cd /root && ./build_examples.sh && \
    rm /root/build_examples.sh
ENTRYPOINT ["/root/entrypoint.sh"]
