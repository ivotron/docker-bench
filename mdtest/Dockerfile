FROM debian:jessie

MAINTAINER Michael Sevilla <mikesevilla3@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
      libopenmpi-dev \
      openmpi-bin \
      wget \
      make \
      openssh-client && \
    mkdir /mdtest && cd /mdtest && \
    wget http://sourceforge.net/projects/mdtest/files/latest/download && tar xzvf download && \
    sed -i s/"CC = \$(CC.\$(OS))"/"CC = mpicc"/g Makefile && \
    make && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/mdtest/mdtest"]
CMD ["--help"]
