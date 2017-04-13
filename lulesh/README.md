# lulesh

Docker image for the [LULESH](https://codesign.llnl.gov/lulesh.php) 
proxy app compiled using OpenMPI.

```bash
docker run --rm \
  -e SINGLE_NODE=1 \
  -e MPIRUN_FLAGS="-np 8" \
  ivotron/lulesh -i 1 -s 100
```

For more options, pass the `-h` flag. To run in more than one machine, 
this has to be executed following the guidelines specified 
[here](https://github.com/ivotron/docker-openmpi#running).
