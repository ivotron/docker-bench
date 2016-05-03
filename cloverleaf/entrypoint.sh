#!/bin/bash

TIME=%e time -o output ./clover_leaf &> /dev/null

if [ $? -ne 0 ] ; then
   cat output
   exit 1
fi

result=`cat output`
echo "[{"
echo "\"name\": \"cloverleaf-serial\", "
echo "\"class\": \"cpu\", "
echo "\"lower_is_better\": true, "
echo "\"result\": \"$result\" "
echo "}]"
