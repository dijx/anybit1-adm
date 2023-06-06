#!/bin/bash

CONTAINER=nextCloud-sql
TIME_STAMP=$(date +%Y%m%d_%H%M)
FILE_PATH="/adm/BACKUP/mysql"
FILE_NAME="nextcloud_backup_${TIME_STAMP}.mysqldump"

echo "starting mysqldump in container $CONTAINER into $FILE_NAME"
docker exec $CONTAINER mysqldump -uroot -pmysqlRoot123 --all-databases | bzip2 -c9 > ${FILE_PATH}/${FILE_NAME}.bz2 && \
find $FILE_PATH -type f -iname '*.mysqldump.bz2' -mtime +2 -delete
echo "mysqldump finished"

