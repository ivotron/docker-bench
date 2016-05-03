FROM debian:jessie
RUN apt-get update && apt-get install -y make gcc wget tar && \
    wget --no-check-certificate https://asc.llnl.gov/sequoia/benchmarks/IRSmk_v1.0.tar.gz -O - | tar xz && \
    cd IRSmk_v1.0/ && \
    gcc *.c -o irsmk && \
    cp irsmk_input_25 irsmk_input && \
    cd / && \
    wget --no-check-certificate https://asc.llnl.gov/sequoia/benchmarks/CrystalMk_v1.0.tar.gz -O - | tar xz && \
    cd CrystalMk_v1.0/ && \
    gcc -lm *.c -o crystalmk && \
    cd / && \
    wget --no-check-certificate https://asc.llnl.gov/sequoia/benchmarks/AMGmk_v1.0.tar.gz -O - | tar xz && \
    cd AMGmk_v1.0/ && \
    gcc -fopenmp *.c -o amgmk && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
