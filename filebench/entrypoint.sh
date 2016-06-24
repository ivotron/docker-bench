#!/bin/bash

if [ -z "$BENCHMARKS" ] ; then
  BENCHMARKS=`ls -1 /workloads/ | grep '.*\.f' | sed -e 's/\..*$//'`
fi

if [ -z $TIMEOUT ] ; then
  TIMEOUT=''
fi

function include_comma {
  if [ "$need_comma" = true ] ; then
    echo ","
  else
    need_comma=true
  fi
}

need_comma=false

echo "["

for bench in $BENCHMARKS ; do
  echo "run $TIMEOUT" >> /workloads/${bench}.f
  filebench -f /workloads/${bench}.f &> output
  awk '/Per-Operation Breakdown/ {p=1}; p; /IO Summary/ {p=0}' output | sed '1d;$d' | while read line ;
  do
    include_comma
    echo "{"
    name=`echo $line | awk '{ print $1 }'`
    opss=`echo $line | awk '{ print $3 }' | sed -e 's/ops\/s//'`
    echo "\"name\": \"${bench}.${name}\","
    echo "\"result\": $opss",
    echo "\"units\": \"ops-per-second\"",
    echo "\"lower_is_better\": \"false\""
    echo "}"
  done
done

echo "]"
