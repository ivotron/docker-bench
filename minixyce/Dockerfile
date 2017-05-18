FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/mantevo/minixyce/archive/f41f84e.tar.gz -O - | tar xz && \
    mv miniXyce* minixyce && \
    cd /minixyce/ref/src && \
    make || true && \
    make && \
    mv ../../tests/default_params.txt /root && \
    mv miniXyce.x /usr/bin/ && \
    cd / && \
    rm -r /minixyce

WORKDIR /root

ADD mpipostrun /usr/bin

ENTRYPOINT ["mpirun_docker", "miniXyce.x"]
