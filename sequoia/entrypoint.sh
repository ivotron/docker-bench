#!/bin/bash
echo "["

cd /IRSmk_v1.0/
./irsmk > output
result=`sed -n 's/Wall time = \(.*\) seconds./\1/p' output`
echo "{"
echo "\"name\": \"irsmk\","
echo "\"class\": \"cpu\","
echo "\"lower_is_better\": true, "
echo "\"result\": $result"
echo "},"

cd /CrystalMk_v1.0/
./crystalmk > output
result=`sed -n 's/Total Wall time = \(.*\) seconds./\1/p' output`
echo "{"
echo "\"name\": \"crystalmk\","
echo "\"class\": \"cpu\","
echo "\"lower_is_better\": true, "
echo "\"result\": $result"
echo "},"

cd /AMGmk_v1.0/
./amgmk > output
result=`sed '41q;d' output | sed -n 's/Total Wall time = \(.*\) seconds.*/\1/p'`
echo "{"
echo "\"name\": \"amgmk\","
echo "\"class\": \"cpu\","
echo "\"lower_is_better\": true, "
echo "\"result\": $result"
echo "}"

echo "]"
