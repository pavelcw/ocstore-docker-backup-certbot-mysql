#!/bin/sh

CUR_DATA=$(date +%d-%m-%Y-%H-%M-%S)
find /backup/app/ -mtime +0 -type f -exec rm -f '{}' \;
find /backup/db/ -mtime +0 -type f -exec rm -f '{}' \;

mysqldump -h ${MYSQL_HOST} -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DB_NAME} > ${MYSQL_BACKUP_PATH}/${MYSQL_DB_NAME}.${CUR_DATA}.sql
gzip ${MYSQL_BACKUP_PATH}/${MYSQL_DB_NAME}.${CUR_DATA}.sql

tar -zcf ${APP_BACKUP_PATH}/docker.${CUR_DATA}.tar.gz ${APP_STORAGE_PATH}/docker
tar -zcf ${APP_BACKUP_PATH}/storage.${CUR_DATA}.tar.gz ${APP_MAIN_PATH}/storage

