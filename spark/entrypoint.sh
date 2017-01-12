#!/bin/bash

if [ -z "$WORKER_MEMORY" ]; then
  echo "expecting WORKER_MEMORY variable"
  exit 1
fi
if [ -z "$WORKER_CORES" ]; then
  echo "expecting WORKER_CORES variable"
  exit 1
fi
if [ -z "$WORKER_INSTANCES" ]; then
  echo "expecting WORKER_INSTANCES variable"
  exit 1
fi
if [ -z "$ML_SCALE_FACTOR" ]; then
  echo "expecting ML_SCALE_FACTOR variable"
  exit 1
fi
if [ -z "$ML_IGNORED_TRIALS" ]; then
  echo "expecting ML_IGNORED_TRIALS variable"
  exit 1
fi
if [ -z "$ML_NUM_TRIALS" ]; then
  echo "expecting ML_NUM_TRIALS variable"
  exit 1
fi
if [ ! -f /spark/conf/slaves ]; then
  echo "expecting /spark/conf/slaves file"
  exit 1
fi

echo "Port $SSHD_PORT" >> /root/.ssh/config
echo 'log4j.rootCategory=WARN, console' > /spark/conf/log4j.properties

if [ -z "$MASTER" ] ; then
  # if we are not MASTER, we just launch sshd
  /root/.ssh/entrypoint.sh
  exit 0
fi

function stopall {
  # stop slaves
  stopsshd "`cat /spark/conf/slaves`"

  # stop our sshd
  service ssh stop

  exit $1
}

function zero_or_die {
  if [ $1 -ne 0 ]; then
    stopall $1
  fi
}

# send sshd to background
/root/.ssh/entrypoint.sh &> /dev/null &

# wait for other's sshd to startup
if [ -z "$WAIT_SSHD_SECS" ] ; then
  WAIT_SSHD_SECS=60
fi
sleep $WAIT_SSHD_SECS

# check if MASTER hostname was given and use hostname if not
if [ -z "$MASTER_HOSTNAME" ] ; then
  MASTER_HOSTNAME=`hostname`
fi
export MASTER_URL="spark://$MASTER_HOSTNAME:7077"
echo "spark.master=$MASTER_URL" > /spark/conf/spark-defaults.conf
echo 'spark.eventLog.enabled=false' >> /spark/conf/spark-defaults.conf

echo "SPARK_WORKER_INSTANCES=$WORKER_INSTANCES" > /spark/conf/spark-env.sh
echo "SPARK_WORKER_CORES=$WORKER_CORES" >> /spark/conf/spark-env.sh
echo "SPARK_WORKER_MEMORY=$WORKER_MEMORY" >> /spark/conf/spark-env.sh

sed -i -s "s/JavaOptionSet(\"spark.executor.memory\".*/JavaOptionSet(\"spark.executor.memory\", [\"$WORKER_MEMORY\"]),/" /spark-perf/config/config.py
sed -i -s "s/SPARK_DRIVER_MEMORY = .*/SPARK_DRIVER_MEMORY = \"${WORKER_MEMORY}\"/" /spark-perf/config/config.py
sed -i -s "s/SCALE_FACTOR = .*/SCALE_FACTOR = ${ML_SCALE_FACTOR}/" /spark-perf/config/config.py
sed -i -s "s/IGNORED_TRIALS = .*/IGNORED_TRIALS = ${ML_IGNORED_TRIALS}/" /spark-perf/config/config.py
sed -i -s "s/OptionSet(\"num-trials\",.*/OptionSet(\"num-trials\", [${ML_NUM_TRIALS}]),/" /spark-perf/config/config.py

service ssh start

cd /spark-perf
bin/run

zero_or_die $?

# run given command
"$@" &> /tmp/spark-output

stopall $?
