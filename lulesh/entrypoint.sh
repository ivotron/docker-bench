#!/bin/bash
set -e

export SKIP_MPISTOP=1

mpirun_docker lulesh2.0 $@ &> lulesh_output

if [ -n "$RANK0" ] ; then
  result=`cat lulesh_output | grep 'Elapsed time' | awk '{print $4}'`
  echo "[{"
  echo "\"name\": \"lulesh\", "
  echo "\"class\": \"cpu\", "
  echo "\"lower_is_better\": true, "
  echo "\"result\": \"$result\" "
  echo "}]"
fi

mpistop
