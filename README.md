# docker-php5-fpm-nginx

## Overview
This docker image include MySQL 5.5 based-on Ubuntu Server 14.04 LTS.

[Docker Cloud](https://hub.docker.com/r/samejack/mysql/)

## Getting and Start
```
docker pull samejack/mysql:latest
sudo docker run -e 'MYSQL_ROOT_PASSWORD=1234' -v `pwd`/data:/var/lig/mysql -p 3306 -it samejack/mysql
```

### Start and insert custom Username and Password
```
sudo docker run -e 'MYSQL_USER_NAME=sj' -e 'MYSQL_USER_PASSWORD=1234' -p 3306 -d samejack/mysql
```

### Start deamon and import sql
User MySQL root user to import SQL from files.
```
sudo docker run --name mysql -e 'MYSQL_ROOT_PASSWORD=1234' -v `pwd`/schema:/schema -p 3306 -d samejack/mysql
sudo docker exec -e 'MYSQL_ROOT_PASSWORD=1234' -e 'INIT_SCHEMA=/schema/a.sql,/schema/b.sql' -it mysql /init.sh
```

## Environment
| Name                | Default | Description                     |
| :-------------      | :------ | :-------------                  |
| MYSQL_ROOT_PASSWORD | Random  | MySQL root Password             |
| MYSQL_USER_NAME     | default | General Remote Username         |
| MYSQL_USER_PASSWORD | Random  | Password of Remote User         |
| MYSQL_PORT          | 3306    | MySQL Bind Port                 |
| MYSQL_SERVER_ID     | 1       | MySQL Server ID of Cluster      |
| MYSQL_READ_ONLY     | 0       | MySQL Read Only Setting         |
| MYSQL_BP_SIZE       | 256M    | MySQL Buffer Poll Size (innodb) |
| INIT_SCHEMA         |         | Init Schema, ex: a.sql,b.sql    |


## Building from Source Code (Dockerfile)
```
git clone https://github.com/samejack/docker-mysql
cd docker-mysql
sudo docker build -t samejack/mysql ./
```
