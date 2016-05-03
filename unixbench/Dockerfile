FROM tutum/unixbench

RUN sed -i 's/OPTON = -O2 -fomit-frame-pointer -fforce-addr -ffast-math -Wall/OPTON = -O0/' /app/UnixBench/Makefile
ADD entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
