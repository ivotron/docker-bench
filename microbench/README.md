# docker-microbench

Small group of micro-benchmarking tools.

# Usage

```bash
docker run --rm -ti ivotron/microbench
```

# Variables

The `BENCHMARKS` environment variable controls which benchmarks get 
executed. Possible values:

  - `stream-copy`
  - `stream-add`
  - `stream-scale`
  - `stream-triad`
  - `crafty`
  - `c-ray`

By default, if `BENCHMARKS` is not specified, all benchmarks are 
executed.

# Output

The format of the output is:

```javascript
[
  {
    "name": "bench-name",
    "class": "one of memory|processor",
    "result": "number"
  },
  { ... }
]
```
