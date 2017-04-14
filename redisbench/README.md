# redisbench

No need to create a container:

```bash
docker run -d --name=redis redis:3.2
docker exec redis redis-benchmark \
  -d 8 -r 1000000 -n 2000000 -t get,set,lpush,lpop -P 4 --csv
```
