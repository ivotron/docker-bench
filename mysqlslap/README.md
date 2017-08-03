Run an instance of mysql:

```bash
docker run --name mariadb -e MYSQL_ROOT_PASSWORD=pwd -d mariadb:10.3
```


Then run this container:

```bash
docker run --rm --link mariadb:mysql -v `pwd`/results:/results/ ivotron/mysqlslap:10.3
```
