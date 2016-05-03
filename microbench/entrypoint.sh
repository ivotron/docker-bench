#!/bin/bash
set -e

if [ -z "$BENCHMARKS" ] ; then
  BENCHMARKS="crafty stream-copy stream-add stream-scale stream-triad c-ray"
fi

PTS=""

if [[ $BENCHMARKS == *"crafty"* ]] ; then
  PTS+="pts/crafty"
fi

if [[ $BENCHMARKS == *"c-ray"* ]] ; then
  PTS+=" pts/c-ray"
fi

if [[ $BENCHMARKS == *"stream"* ]] ; then
  PTS+=" pts/stream"
fi

phoronix-test-suite batch-benchmark $PTS &> /tmp/out
if [ $? -ne 0 ] ; then
  echo "ERROR while executing benchmark"
  cat /tmp/out
  exit 1
fi

result=`basename /root/.phoronix-test-suite/test-results/*-*-*-*`

phoronix-test-suite result-file-to-csv $result > /tmp/out
if [ $? -ne 0 ] ; then
  echo "ERROR while getting benchmark results"
  cat /tmp/out
  exit 1
fi

json="["

for bench in $BENCHMARKS ; do
  json+="\n{\n\"name\": \"$bench\","
  case $bench in
  crafty)
    result=`grep Crafty /tmp/out | awk -F',' '{print $2}'`
    json+="\n\"class\": \"cpu\","
    json+="\n\"lower_is_better\": true,"
    json+="\n\"unit\": \"sec\","
    ;;
  c-ray)
    result=`grep C-Ray /tmp/out | awk -F',' '{print $2}'`
    json+="\n\"class\": \"cpu\","
    json+="\n\"lower_is_better\": true,"
    json+="\n\"unit\": \"sec\","
    ;;
  stream-*)
    json+="\n\"class\": \"memory\","
    json+="\n\"unit\": \"mb/s\","
    json+="\n\"lower_is_better\": false,"
    case $bench in
    stream-add) result=`grep "Stream.*Add" /tmp/out | awk -F',' '{print $2}'` ;;
    stream-copy) result=`grep "Stream.*Copy" /tmp/out | awk -F',' '{print $2}'` ;;
    stream-scale) result=`grep "Stream.*Scale" /tmp/out | awk -F',' '{print $2}'` ;;
    stream-triad) result=`grep "Stream.*Triad" /tmp/out | awk -F',' '{print $2}'` ;;
    *) ;;
    esac
    ;;
  *)
    echo "ERROR: don't know how to process benchmark $bench"
    exit 1
    ;;
  esac
  json+="\n\"result\": \"$result\""
  json+="\n},"
done

# remove last comma
json=`echo $json | sed 's/.$//'`

json+="\n]"

echo -e "$json"
