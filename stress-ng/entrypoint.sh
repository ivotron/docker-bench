#!/bin/bash
set -e

if [ -z "$METHODS" ]; then
  stress-ng $@
  exit 0
fi

# cpu
for m in ackermann bitops callfunc cdouble cfloat clongdouble correlate crc16 decimal32 decimal64 decimal128 dither djb2a double euler explog fft fibonacci float fnv1a gamma gcd gray hamming hanoi hyperbolic idct int128 int64 int32 int16 int8 int128float int128double int128longdouble int128decimal32 int128decimal64 int128decimal128 int64float int64double int64longdouble int32float int32double int32longdouble jenkin jmp ln2 longdouble loop matrixprod nsqrt omega parity phi pi pjw prime psi queens rand rand48 rgb sdbm sieve sqrt trig union zeta ; do
  echo "Running CPU method $m"

  if [ -n "$RESULTS_PATH" ]; then
    stress-ng --cpu 1 --cpu-method $m $@ --yaml $RESULTS_PATH/cpu_$m.yaml &> $RESULTS_PATH/cpu_$m.out
  else
    stress-ng --cpu 1 --cpu-method $m $@
  fi
done

# matrix
for m in add copy div frobenius hadamard mean mult prod sub trans ; do
  echo "Running matrix method $m"

  if [ -n "$RESULTS_PATH" ]; then
    stress-ng --matrix 1 --matrix-method $m $@ --yaml $RESULTS_PATH/matrix_$m.yaml &> $RESULTS_PATH/matrix_$m.out
  else
    stress-ng --matrix 1 --matrix-method $m $@
  fi
done

# vm
for m in flip galpat-0 galpat-1 gray rowhammer incdec inc-nybble rand-set rand-sum read64 ror swap move-inv modulo-x prime-0 prime-1 prime-gray-0 prime-gray-1 prime-incdec walk-0d walk-1d walk-0a walk-1a write64 zero-one ; do
  echo "Running vm method $m"

  if [ -n "$RESULTS_PATH" ]; then
    stress-ng --vm 1 --vm-method $m $@ --yaml $RESULTS_PATH/vm_$m.yaml &> $RESULTS_PATH/vm_$m.out
  else
    stress-ng --vm 1 --vm-method $m $@
  fi
done
