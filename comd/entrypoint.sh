#!/bin/bash

/comd/bin/CoMD-mpi > output

if [ $? -ne 0 ] ; then
   cat output
   exit 1
fi

result=`sed -n 's/total *1 *\([0-9]*\.[0-9]*\) *.*/\1/p' output`
echo "[{"
echo "\"name\": \"comd\", "
echo "\"class\": \"cpu\", "
echo "\"lower_is_better\": true, "
echo "\"result\": \"$result\" "
echo "}]"
