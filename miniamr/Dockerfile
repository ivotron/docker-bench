FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/mantevo/miniamr/archive/7ae7865.tar.gz -O - | tar xz && \
    mv miniA* miniamr && \
    cd miniamr/ref && \
    sed -i 's/cc/mpicc/' Makefile && \
    make -j4 && \
    mv ma.x /usr/bin/ && \
    cd / && \
    rm -r /miniamr/

WORKDIR /root

ENTRYPOINT ["mpirun_docker", "ma.x"]
