#!/bin/sh

# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : mysql_backup_db.sh
#  Application     : backup MySQL Database
#  Fonction        : This script take bacup of MySQL Database
#  History
#  --------
#  Date                Author          		 Update
#  11/16/2019          Jig                   Creation
# -------------------------------------------------------------------------------

# soruce file
# Please deploy script in $HOME/script folder
. $HOME/scripts/myserver_env.sh

myecho "List variable"
myecho "Server Name -> ${BKP_SERVER_NAME}"
myecho "DB Port -> ${BKP_SERVER_DB_PORT}"

myecho "Username -> ${BKP_USER_NAME}"
#myecho "Password -> ${BKP_USER_PWD}"
myecho "S3 Bucket Name -> ${BKP_S3_NAME}"
myecho "BKP Filename -> ${BKP_FILE_NAME}"
myecho "Database name -> ${BKP_DB_NAME}"

#Backup database
# Test Database connection
# mysql -h ${BKP_SERVER_NAME} -P ${BKP_SERVER_DB_PORT} -u ${BKP_USER_NAME} -p${BKP_USER_PWD}

myecho "Database backup to \tmp location"
mysqldump -h ${BKP_SERVER_NAME} -u ${BKP_USER_NAME} -p${BKP_USER_PWD} ${BKP_DB_NAME} > /tmp/${BKP_FILE_NAME}.sql

myecho "copy backup to aws s3"
aws s3 cp /tmp/${BKP_FILE_NAME}.sql s3://${BKP_S3_NAME}/

myecho "Remove backup from local disk"
rm -f /tmp/${BKP_FILE_NAME}.sql
