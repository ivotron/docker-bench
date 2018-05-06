#!/bin/bash
set -ex
cd /silt/test/fawnds
./benchCuckoo > output.txt
if [ -d /results ]; then
  mv output.txt /results/
else
  cat output.txt
fi
