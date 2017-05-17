FROM ivotron/openmpi:v2.0.2

RUN wget --no-check-certificate https://github.com/mantevo/minimd/archive/ff4543d.tar.gz -O - | tar xz && \
    mv miniMD* minimd && \
    cd minimd/ref && \
    make openmpi -j4 && \
    mv miniMD_openmpi /usr/bin/minimd && \
    mv in.lj.miniMD /root/ && \
    rm -r /minimd/

WORKDIR /root

ADD mpipostrun /usr/bin

ENTRYPOINT ["mpirun_docker", "minimd"]
