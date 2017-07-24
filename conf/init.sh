#!/bin/bash

# import sql file of user defined (environment INIT_SCHEMA)
if [ "${INIT_SCHEMA}" != "" ]; then
    IFS=',' read -r -a array <<< "${INIT_SCHEMA}"
    for SQL_FILE in "${array[@]}"
    do
        if [ -f "${SQL_FILE}" ]; then
            echo "Prepare import SQL file: ${SQL_FILE}"
            cat ${SQL_FILE} >> /custom_init.sql
        else
            echo "SQL file not found: ${SQL_FILE}"
        fi
    done

    if [ "${MYSQL_PORT}" == "" ]; then
        MYSQL_PORT="3306"
    fi
    echo "MySql Root Password: ${MYSQL_ROOT_PASSWORD}"
    echo "MySql Port: ${MYSQL_PORT}"

    COMMAND="mysql --port=${MYSQL_PORT} -uroot -p'${MYSQL_ROOT_PASSWORD}' < /custom_init.sql"
    echo ${COMMAND}
    bash -c "$COMMAND"
fi
