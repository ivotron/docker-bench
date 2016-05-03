FROM ivotron/phoronix

# a subset of pts/linux-system (removed all tests involving disk) and added some from pts/cpu

ADD user-config.xml /root/.phoronix-test-suite/
ADD pts_result_file_output /usr/share/phoronix-test-suite/pts-core/objects/pts_result_file_output.php
RUN apt-get update && apt-get install -y build-essential jq && \
    sed -i -e "s/'NUM_CPU_CORES'.*/'NUM_CPU_CORES' => 1,/" /usr/share/phoronix-test-suite/pts-core/objects/client/pts_client.php && \
    CFLAGS="-O0 -mtune=generic" CXXFLAGS="-O0 -mtune=generic" phoronix-test-suite batch-install \
       pts/bullet \
       pts/byte \
       pts/cachebench \
       pts/compress-lzma \
       pts/compress-gzip \
       pts/compress-pbzip2 \
       pts/compress-7zip \
       pts/dcraw \
       pts/encode-mp3 \
       pts/encode-flac \
       pts/encode-ape \
       pts/ffmpeg \
       pts/fhourstones \
       pts/gcrypt \
       pts/gnupg \
       pts/gmpbench \
       pts/graphics-magick \
       pts/himeno \
       pts/hmmer \
       pts/john-the-ripper \
       pts/jxrendermark \
       pts/lightsmark \
       pts/mafft \
       pts/mencoder \
       pts/minion \
       pts/mrbayes \
       pts/n-queens \
       pts/npb \
       pts/openssl \
       pts/padman \
       pts/pybench \
       pts/scimark2 \
       pts/smallpt \
       pts/sunflow \
       pts/sudokut \
       pts/tachyon \
       pts/tscp \
       pts/ttsiod-renderer \
       pts/vdrift \
       pts/x264 && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh /root/
ENTRYPOINT ["/root/entrypoint.sh"]
