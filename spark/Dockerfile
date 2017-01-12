FROM ivotron/openssh

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y scala wget python && \
    wget --no-check-certificate http://apache.mirrors.tds.net/spark/spark-1.6.3/spark-1.6.3-bin-hadoop2.6.tgz -O - | tar -xz && \
    mv spark* spark && \
    rm /spark/conf/* && \
    wget --no-check-certificate https://github.com/databricks/spark-perf/archive/6e4f26d.tar.gz -O - | tar -xz && \
    mv spark-perf* spark-perf && \
    cd /spark-perf/mllib-tests && \
    sbt/sbt -Dspark.version=1.6.0 clean assembly && \
    apt-get remove --purge -y wget && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    echo 'Host *' > /root/.ssh/config && \
    echo 'StrictHostKeyChecking no' >> /root/.ssh/config && \
    echo 'LogLevel quiet' >> /root/.ssh/config && \
    chmod 600 /root/.ssh/config

ENV SPARK_HOME=/spark
ENV PATH=$PATH:$SPARK_HOME/bin

ADD entrypoint.sh /root
ADD config.py /spark-perf/config/

ENTRYPOINT ["/root/entrypoint.sh"]
