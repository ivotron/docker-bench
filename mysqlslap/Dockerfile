FROM mariadb:10.3

RUN apt-get update && \
    apt-get install -y time && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD entrypoint.sh /root/

ENTRYPOINT ["/root/entrypoint.sh"]
