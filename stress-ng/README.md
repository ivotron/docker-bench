# `stress-ng` docker image

Wraps stress-ng in a docker image. Arguments:

  * `BENCHMARKS` takes one or more `cpu-methods cpu-class cpu-cache 
    memory string-methods matrix-methods`. Default is all.
  * `TIMEOUT`. How long to run each stressor for (10 seconds is the 
    default.)
  * `NUM_WORKERS`. Number of workers to launch for each stressor.

Results are in JSON. Every stressor is run sequentially.

<!--

**TODO**: fix this

cpu cpu-cache device io interrupt filesystem memory network os pipe scheduler security vm

cpu
--exclude matrix,context
1 af-alg, 1 bsearch, 1 cpu, 1 crypt, 1 hsearch, 1 longjmp, 1 lsearch, 1 numa, 1 qsort, 1 rdrand, 1 str, 1 stream, 1 tsc, 1 tsearch, 1 vecmath, 1 wcs

cpu-cache
--exclude bsearch,hsearch,lockbus,lsearch,vecmath,matrix,qsort,malloc,str,stream,memcpy,wcs,tsearch
1 cache, 1 icache

memory
--exclude bsearch,hsearch,lsearch,qsort,wcs,tsearch,stream,numa
1 context, 1 lockbus, 1 malloc, 1 matrix, 1 memcpy, 1 memfd, 1 mincore, 1 null, 1 pipe, 1 stack, 1 vm, 1 vm-rw, 1 zero

device
1 null, 1 urandom, 1 zero
io
1 aio, 1 aio-linux, 1 hdd, 1 readahead, 1 seek
interrupt
1 aio, 1 aio-linux, 1 clock, 1 fault, 1 itimer, 1 kill, 1 sigfd, 1 sigfpe, 1 sigpending, 1 sigq, 1 sigsegv, 1 sigsuspend, 1 timer, 1 timerfd
filesystem
1 chdir, 1 chmod, 1 dentry, 1 dir, 1 dup, 1 eventfd, 1 fallocate, 1 fcntl, 1 fiemap, 1 filename, 1 flock, 1 fstat, 1 handle, 1 iosync, 1 inotify, 1 lease, 1 link, 1 lockf, 1 mknod, 1 open, 1 procfs, 1 rename, 1 symlink, 1 utime
network
1 epoll, 1 socket, 1 socket-pair, 1 udp, 1 udp-flood
os
1 af-alg, 1 aio, 1 aio-linux, 1 bigheap, 1 brk, 1 chdir, 1 chmod, 1 clock, 1 clone, 1 daemon, 1 dentry, 1 dir, 1 dup, 1 epoll, 1 eventfd, 1 exec, 1 fallocate, 1 fault, 1 fcntl, 1 fiemap, 1 fifo, 1 filename, 1 flock, 1 fork, 1 fstat, 1 futex, 1 get, 1 handle, 1 hdd, 1 iosync, 1 inotify, 1 itimer, 1 kcmp, 1 kill, 1 lease, 1 link, 1 lockf, 1 malloc, 1 memfd, 1 mincore, 1 mknod, 1 mlock, 1 mmap, 1 mmapfork, 1 mmapmany, 1 mremap, 1 msg, 1 mq, 1 nice, 1 null, 1 numa, 1 open, 1 personality, 1 pipe, 1 poll, 1 procfs, 1 pthread, 1 ptrace, 1 quota, 1 readahead, 1 rename, 1 rlimit, 1 seccomp, 1 seek, 1 sem-posix, 1 sem-sysv, 1 shm-posix, 1 shm-sysv, 1 sendfile, 1 sigfd, 1 sigfpe, 1 sigpending, 1 sigq, 1 sigsegv, 1 sigsuspend, 1 socket, 1 socket-pair, 1 spawn, 1 splice, 1 switch, 1 symlink, 1 sysinfo, 1 sysfs, 1 tee, 1 timer, 1 timerfd, 1 udp, 1 udp-flood, 1 unshare, 1 urandom, 1 utime, 1 vfork, 1 vm, 1 vm-rw, 1 vm-splice, 1 wait, 1 yield, 1 zero, 1 zombie
pipe
1 fifo, 1 pipe, 1 sendfile, 1 splice, 1 tee, 1 vm-splice
scheduler
1 affinity, 1 clone, 1 daemon, 1 eventfd, 1 exec, 1 fault, 1 fifo, 1 fork, 1 futex, 1 inotify, 1 kill, 1 mmapfork, 1 msg, 1 mq, 1 nice, 1 poll, 1 pthread, 1 sem-posix, 1 sem-sysv, 1 spawn, 1 switch, 1 tee, 1 vfork, 1 wait, 1 yield, 1 zombie
vm
1 bigheap, 1 brk, 1 malloc, 1 mlock, 1 mmap, 1 mmapfork, 1 mmapmany, 1 mremap, 1 shm-posix, 1 shm-sysv, 1 stack, 1 vm, 1 vm-rw, 1 vm-splice

-->
