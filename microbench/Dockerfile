FROM ivotron/phoronix

ADD user-config.xml /root/.phoronix-test-suite/
RUN apt-get update && \
    apt-get install time && \
    phoronix-test-suite download-test-files \
       pts/c-ray pts/crafty pts/stream && \
    sed -i -e 's/\(cc.*\)/\1 \$CFLAGS/' ~/.phoronix-test-suite/test-profiles/pts/stream-1.2.0/install.sh && \
    sed -i -e 's/RT_THREADS=.*/RT_THREADS=16/' ~/.phoronix-test-suite/test-profiles/pts/c-ray-1.1.0/install.sh && \
    sed -i -e 's/1600x1200/400x300/' ~/.phoronix-test-suite/test-profiles/pts/c-ray-1.1.0/install.sh && \
    sed -i -e 's/\.\/crafty.*/{ TIME=%e time \.\/crafty perft=6 perft=6 quit ; } 2> \\$LOG_FILE/' ~/.phoronix-test-suite/test-profiles/pts/crafty-1.3.0/install.sh && \
    sed -i -e 's/<Arguments.*/<Arguments><\/Arguments>/' ~/.phoronix-test-suite/test-profiles/pts/crafty-1.3.0/test-definition.xml && \
    sed -i -e 's/<TimesToRun.*3.*/<TimesToRun>1<\/TimesToRun>/' ~/.phoronix-test-suite/test-profiles/pts/crafty-1.3.0/test-definition.xml && \
    sed -i -e 's/<TimesToRun.*10.*/<TimesToRun>4<\/TimesToRun>/' ~/.phoronix-test-suite/test-profiles/pts/stream-1.2.0/test-definition.xml && \
    sed -i -e 's/<TimesToRun.*3.*/<TimesToRun>1<\/TimesToRun>/' ~/.phoronix-test-suite/test-profiles/pts/c-ray-1.1.0/test-definition.xml && \
    sed -i -e 's/<OutputTemplate.*/<OutputTemplate>#_RESULT_#<\/OutputTemplate>/' ~/.phoronix-test-suite/test-profiles/pts/crafty-1.3.0/results-definition.xml && \
    sed -i -e 's/Raw nodes.*//' ~/.phoronix-test-suite/test-profiles/pts/crafty-1.3.0/results-definition.xml && \
    sed -i -e 's/Total elapsed.*//' ~/.phoronix-test-suite/test-profiles/pts/crafty-1.3.0/results-definition.xml && \
    CFLAGS="-O0 -mtune=generic" phoronix-test-suite install \
       pts/c-ray pts/crafty pts/stream && \
    apt-get remove --auto-remove -y \
       build-essential autoconf libnuma-dev mesa-utils unzip && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh /root/
ENTRYPOINT ["/root/entrypoint.sh"]
