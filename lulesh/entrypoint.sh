#!/bin/bash
set -e

if [ -n "$RANK0" ] ; then
  mpirun_docker lulesh2.0 $@ &> lulesh_output

  result=`cat lulesh_output | grep 'Elapsed time' | awk '{print $4}'`
  echo "[{"
  echo "\"name\": \"lulesh\", "
  echo "\"class\": \"cpu\", "
  echo "\"lower_is_better\": true, "
  echo "\"result\": \"$result\" "
  echo "}]"

  mpistop

else
  /root/entrypoint.sh
fi
