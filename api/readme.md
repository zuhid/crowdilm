`docker compose up --detach` - start docker
open in `http://localhost:8080`
docker exec -it apache_local /bin/bash
docker exec -it mysql_local /bin/bash

docker exec -it mysql_local mysql -u root -p

`docker compose down` - take down docker

```
docker compose down
docker compose up --detach --force-recreate
http://localhost:8080
```

mysql -u root -p'P@ssw0rd' < init.sql
