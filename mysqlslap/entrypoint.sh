#!/bin/bash
set -ex

sleep 20

NUM_ROWS_PER_CLIENT="10000"
NUM_UNIQUE_ROWS="100000"
NUM_VARCHAR_COLUMNS="10"
NUM_INT_COLUMNS="10"
NUM_CLIENTS="10"
NUM_QUERIES_PER_CLIENT="100"
NUM_UNIQUE_QUERIES="100"

if [ -z "$ENGINES" ]; then
  ENGINES="memory"
fi

# increase in-memory table size limit
mysql \
  -h$MYSQL_PORT_3306_TCP_ADDR \
  -P$MYSQL_PORT_3306_TCP_PORT \
  -uroot \
  -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD \
  -e "SET GLOBAL tmp_table_size = 1024 * 1024 * 1024 * 6; SET GLOBAL max_heap_table_size = 1024 * 1024 * 1024 * 2;"

for ENGINE in $ENGINES; do

common="-h$MYSQL_PORT_3306_TCP_ADDR"
common+=" -P$MYSQL_PORT_3306_TCP_PORT"
common+=" -uroot"
common+=" -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD"
common+=" --engine=$ENGINE"
common+=" --number-char-cols=$NUM_VARCHAR_COLUMNS"
common+=" --number-int-cols=$NUM_INT_COLUMNS"
common+=" --no-drop"

query_gen="--only-print"
query_gen+=" --auto-generate-sql"
query_gen+=" --auto-generate-sql-guid-primary"
query_gen+=" --auto-generate-sql-write-number=0"
query_gen+=" --auto-generate-sql-unique-query-number=0"
query_gen+=" --auto-generate-sql-execute-number=$NUM_QUERIES_PER_CLIENT"
query_gen+=" --auto-generate-sql-load-type="

TIMEIT="/usr/bin/time --format='%e'"

$TIMEIT -o /tmp/time_${ENGINE}_load \
  mysqlslap $common \
  --concurrency=$NUM_CLIENTS \
  --auto-generate-sql \
  --auto-generate-sql-write-number=$NUM_ROWS_PER_CLIENT \
  --auto-generate-sql-unique-write-number=$NUM_UNIQUE_ROWS \
  --auto-generate-sql-load-type=write \
  --auto-generate-sql-add-autoincrement

exec_queries="mysqlslap $common --delimiter=\";\" --concurrency=$NUM_CLIENTS --query=/tmp/queries_"

mysqlslap $common ${query_gen}read > /tmp/queries_read.sql
sed -i 's/CREATE.*//' /tmp/queries_read.sql
$TIMEIT -o /tmp/time_${ENGINE}_scan ${exec_queries}read.sql

mysqlslap $common ${query_gen}key > /tmp/queries_key.sql
sed -i 's/CREATE.*//' /tmp/queries_key.sql
$TIMEIT -o /tmp/time_${ENGINE}_key ${exec_queries}key.sql

mysqlslap $common ${query_gen}update > /tmp/queries_update.sql
sed -i 's/CREATE.*//' /tmp/queries_update.sql
$TIMEIT -o /tmp/time_${ENGINE}_update ${exec_queries}update.sql

mysqlslap $common ${query_gen}mixed > /tmp/queries_mixed.sql
sed -i 's/CREATE.*//' /tmp/queries_mixed.sql
$TIMEIT -o /tmp/time_mixed ${exec_queries}mixed.sql

mysql \
  -h$MYSQL_PORT_3306_TCP_ADDR \
  -P$MYSQL_PORT_3306_TCP_PORT \
  -uroot \
  -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD \
  -e "drop database mysqlslap;"

done

if [ ! -d /results ]; then
  exit 0
fi

echo "{" > /results/results.json

for f in /tmp/time_*; do
  tname=`echo $f | sed 's/\/tmp\/time_\(.*\)/\1/'`
  result=`cat $f | sed "s/'//g"`
  echo " \"$tname\": $result," >> /results/results.json
done

# remove last comma
sed -i '$ s/.$//' /results/results.json

echo "}" >> /results/results.json

mv /tmp/queries*.sql /results/

