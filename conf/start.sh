#!/bin/bash


# config defined
if [ "${MYSQL_ROOT_PASSWORD}" == "" ]; then
    MYSQL_ROOT_PASSWORD="$(pwmake 128)"
fi
if [ "${MYSQL_USER_NAME}" == "" ]; then
    MYSQL_USER_NAME="default"
fi
if [ "${MYSQL_USER_PASSWORD}" == "" ]; then
    MYSQL_USER_PASSWORD="$(pwmake 128)"
fi
if [ "${MYSQL_PORT}" == "" ]; then
    MYSQL_PORT="3306"
fi
if [ "${MYSQL_SERVER_ID}" == "" ]; then
    MYSQL_SERVER_ID="1"
fi
if [ "${MYSQL_READ_ONLY}" == "" ]; then
    MYSQL_READ_ONLY="0"
fi
if [ "${MYSQL_BP_SIZE}" == "" ]; then
    MYSQL_BP_SIZE="256M"
fi

# init mysql
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mkdir -p "/var/lib/mysql"
    chown -R mysql:mysql "/var/lib/mysql"
    echo 'Run mysql_install_db...'
    mysql_install_db --user=mysql --rpm --datadir="/var/lib/mysql"
fi

# setup mysql
cp /my.cnf /etc/mysql/my.cnf
sed -i "s/<MYSQL_PORT>/${MYSQL_PORT}/g"           /etc/mysql/my.cnf
sed -i "s/<MYSQL_SERVER_ID>/${MYSQL_SERVER_ID}/g" /etc/mysql/my.cnf
sed -i "s/<MYSQL_READ_ONLY>/${MYSQL_READ_ONLY}/g" /etc/mysql/my.cnf
sed -i "s/<MYSQL_BP_SIZE>/${MYSQL_BP_SIZE}/g"     /etc/mysql/my.cnf
if [ "${ENVIRONMENT}" == "development" ]; then
    echo 'log_slow_queries    = /var/log/mysql/mysql-slow.log' >> /etc/mysql/my.cnf
    echo 'long_query_time     = 2'                             >> /etc/mysql/my.cnf
    echo 'log-queries-not-using-indexes'                       >> /etc/mysql/my.cnf
fi


# init database
echo "MySql Root Password: ${MYSQL_ROOT_PASSWORD}"
echo "MySql Username: ${MYSQL_USER_NAME}"
echo "MySql User Password: ${MYSQL_USER_PASSWORD}"
echo "MySql Port: ${MYSQL_PORT}"
echo "MySql Server ID: ${MYSQL_SERVER_ID}"
echo "MySql READ_ONLY: ${MYSQL_READ_ONLY}"
echo "MySql Buffer Pool Size: ${MYSQL_BP_SIZE}"
sed -i "s/<MYSQL_ROOT_PASSWORD>/${MYSQL_ROOT_PASSWORD}/g" /mysql_init.sql
sed -i "s/<MYSQL_USER_NAME>/${MYSQL_USER_NAME}/g"         /mysql_init.sql
sed -i "s/<MYSQL_USER_PASSWORD>/${MYSQL_USER_PASSWORD}/g" /mysql_init.sql

# run service
/usr/sbin/mysqld --init-file=/mysql_init.sql
