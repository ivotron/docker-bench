#!/bin/bash

cd /usr/local/share/conceptual/examples/

for f in * ; do
  f_without_ext=`basename $f .ncptl`
  ncptl --backend=c_mpi --output=$f_without_ext $f
  mv $f_without_ext /usr/bin/
done
