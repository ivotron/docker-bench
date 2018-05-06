#!/bin/sh
set -ex

if [ -z "$ITERATIONS" ] ; then
  ITERATIONS=3
fi

/root/pybench-2009-08-14/pybench.py -n 3 -C 0 > output.txt

if [ -d /results ]; then
  mv output.txt /results/
else
  cat output.txt
fi
