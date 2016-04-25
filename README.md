# docker-workloads
==================

This repository has containers for running our workloads. Our supported workloads:

1. [filebench](http://filebench.sourceforge.net/wiki/index.php/Main_Page): POSIX file system macrobenchmarks organized using profiles

2. [mdtest](https://sourceforge.net/projects/mdtest/): POSIX file system metadata microbenchmarks

Usage
-----

```bash
docker run michaelsevilla/mdtest -F -C -n 1000 -d /tmp/testdir
```

