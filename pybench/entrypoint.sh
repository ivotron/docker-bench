#!/bin/sh
set -e

if [ -z "$ITERATIONS" ] ; then
  ITERATIONS=3
fi

/root/pybench-2009-08-14/pybench.py -n 3 -C 0 > results

echo "["
cat results | \
  grep ".*:.*ms.*ms.*us.*ms" | \
  awk '{print $1 $3}' | \
  sed 's/\(.*\):\(.*\)ms/{"name": "pybench_\1", "result": \2, "lower_is_better": true, "units": "microseconds"},/' | \
  sed '$ s/.$//'
echo "]"
