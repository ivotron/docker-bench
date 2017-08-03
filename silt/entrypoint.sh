#!/bin/bash
cd /silt/test/fawnds
./benchCuckoo > output
insertrate=`sed -n 's/cuckoo: \(.*\) inserts\/sec/\1/p' output`
hitrate=`sed -n 's/cuckoo: \(.*\) lookups\/sec (hit)/\1/p' output`
missrate=`sed -n 's/cuckoo: \(.*\) lookups\/sec (miss)/\1/p' output`

cat > results.json << EOL
[
  {"name": "cuckoo-insert-rate", "result": $insertrate},
  {"name": "cuckoo-hit-rate", "result": $hitrate},
  {"name": "cuckoo-miss-rate", "result": $missrate}
]
EOL

if [ -d /results ]; then
  mv results.json /results/
fi
