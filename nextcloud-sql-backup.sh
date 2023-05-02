#!/bin/bash

CONTAINER=nextCloud-sql
TIME_STAMP=$(date +%Y%m%d_%H%M)
FILE_NAME=backup_${TIME_STAMP}.mysqldump


docker exec $CONTAINER mysqldump -uroot -pmysqlRoot123 --all-databases --result-file=/BACKUP/${FILE_NAME} && find /adm/BACKUP/mysql/ -type f -mtime +7 -exec rm -f {} \;

