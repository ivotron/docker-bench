FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/mantevo/minimd/archive/ff4543d.tar.gz -O - | tar xz && \
    mv miniMD* minimd && \
    cd minimd/ref && \
# make openmpi AVX=false -j4 && \
    make -f Makefile.default -j4 && \
    mv miniMD /usr/bin/minimd && \
    mv in.lj.miniMD /root/ && \
    rm -r /minimd/

WORKDIR /root

ENTRYPOINT ["mpirun_docker", "minimd"]
