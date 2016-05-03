#!/bin/bash
cd /silt/test/fawnds
./benchCuckoo > output
insertrate=`sed -n 's/cuckoo: \(.*\) inserts\/sec/\1/p' output`
hitrate=`sed -n 's/cuckoo: \(.*\) lookups\/sec (hit)/\1/p' output`
missrate=`sed -n 's/cuckoo: \(.*\) lookups\/sec (miss)/\1/p' output`

echo "["
echo "{\"name\": \"silt-cuckoo-insert-rate\", \"result\": $insertrate},"
echo "{\"name\": \"silt-cuckoo-hit-rate\", \"result\": $hitrate},"
echo "{\"name\": \"silt-cuckoo-miss-rate\", \"result\": $missrate}"
echo "]"
