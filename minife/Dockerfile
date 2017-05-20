FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/mantevo/minife/archive/c34d8a2.tar.gz -O - | tar xz && \
    mv miniFE* minife && \
    cd minife/ref/src && \
    make

WORKDIR /root

ENTRYPOINT ["mpirun_docker", "/minife/ref/src/miniFE.x"]
