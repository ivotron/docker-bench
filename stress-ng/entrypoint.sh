#!/bin/bash
if [ -z "$BENCHMARKS" ] ; then
  BENCHMARKS="cpu-methods cpu-class cpu-cache memory matrix-methods string-methods"
fi

if [ -z $NUM_WORKERS ] ; then
  NUM_WORKERS=1
fi

if [ -z $TIMEOUT ] ; then
  TIMEOUT=10
fi

COMMON="$NUM_WORKERS -t $TIMEOUT --metrics-brief --times -Y /out.yml"

function include_comma {
  if [ "$need_comma" = true ] ; then
    echo ","
  else
    need_comma=true
  fi
}

function get_category {
  if [ $1 == "stream" ] ; then
    category="memory"
  elif [ $1 == *"matrix"* ] ; then
    category="memory"
  elif [ $1 == *"memory"* ] ; then
    category="memory"
  else
    category="cpu"
  fi
}

need_comma=false
category="foo"

echo "["

for bench in $BENCHMARKS ; do
  if [[ $bench == "cpu-methods" ]] ; then
    include_comma
    for method in ackermann bitops callfunc cdouble cfloat clongdouble correlate crc16 decimal32 decimal64 decimal128 dither djb2a double euler explog fft fibonacci float fnv1a gamma gcd gray hamming hanoi hyperbolic idct int128 int64 int32 int16 int8 int128float int128double int128longdouble int128decimal32 int128decimal64 int128decimal128 int64float int64double int64longdouble int32float int32double int32longdouble jenkin jmp ln2 longdouble loop matrixprod nsqrt omega parity phi pi pjw prime psi queens rand rand48 rgb sdbm sieve sqrt trig union zeta ; do
       stress-ng --cpu-method $method --cpu $COMMON &> /dev/null
       /postprocess.py cpu $method
       if [ "$method" != "zeta" ] ; then
         # print comma for all but the last (zeta)
         echo ","
       fi
    done
  elif [[ $bench == "matrix-methods" ]] ; then
    include_comma
    for method in add div frobenius mult prod sub hadamard trans ; do
       stress-ng --matrix-method $method --matrix $COMMON &> /dev/null
       /postprocess.py matrix $method
       if [ "$method" != "trans" ] ; then
         echo ","
       fi
    done
  elif [[ $bench == "string-methods" ]] ; then
    include_comma
    for method in index rindex strcasecmp strcat strchr strcoll strcmp strcpy strlen strncasecmp strncat strncmp strrchr strxfrm ; do
       stress-ng --str-method $method --str $COMMON &> /dev/null
       /postprocess.py string $method
       if [ "$method" != "strxfrm" ] ; then
         echo ","
       fi
    done
  elif [[ $bench == "cpu-class" ]] ; then
    include_comma
    stress-ng --class cpu --exclude matrix,context --sequential $COMMON &> /dev/null
    /postprocess.py cpu
  elif [[ $bench == "memory" ]] ; then
    include_comma
    stress-ng --class memory --exclude bsearch,hsearch,lsearch,qsort,wcs,tsearch,stream,numa --sequential $COMMON &> /dev/null
    /postprocess.py memory
  elif [[ $bench == "cpu-cache" ]] ; then
    include_comma
    stress-ng --class cpu-cache --exclude bsearch,hsearch,lockbus,lsearch,vecmath,matrix,qsort,malloc,str,stream,memcpy,wcs,tsearch --sequential $COMMON &> /dev/null
    /postprocess.py cpu-cache
  else
    # if we didn't get "special" id, then we assume it's a regular stressor
    include_comma
    stress-ng "--$bench" $COMMON &> /dev/null
    get_category $bench
    /postprocess.py $category
  fi
done

echo "]"
