# CoMD

Docker image for the [CoMD](https://github.com/exmatex/CoMD) proxy app 
compiled using OpenMPI.

```bash
docker run --rm \
  -e SINGLE_NODE=1 \
  -e MPIRUN_FLAGS="-np 8" \
  ivotron/comd:v1.1 \
    --xproc 2 \
    --yproc 2 \
    --zproc 2 \
    --nx 64 \
    --ny 64 \
    --nz 64
```

For more options, pass the `-h` flag. To run in more than one machine, 
this has to be executed following the guidelines specified 
[here](https://github.com/ivotron/docker-openmpi#running).
