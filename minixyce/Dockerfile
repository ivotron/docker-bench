FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/mantevo/minixyce/archive/f41f84e.tar.gz -O - | tar xz && \
    mv miniXyce* minixyce && \
    cd /minixyce/ref/src && \
    make || true && \
    make && \
    cp ../../tests/params.txt /root && \
    mv miniXyce.x /usr/bin/

WORKDIR /root

ENTRYPOINT ["mpirun_docker", "miniXyce.x"]
