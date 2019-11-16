#!/bin/sh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : myserver_env.sh
#  Application     : please set all env details here.
#  Fonction        : please set all env details here.
#  History
#  --------
#  Date                Author          		 Update
#  11/16/2019          Jig                   Creation
# -------------------------------------------------------------------------------

myecho () {
	echo `date +"%Y%m%d %H%M : "` $1
}

#common env
DDATE=`date +"%Y%m%d_%H%M"`
BKP_S3_NAME=ixexp-backup

#Database Backup server details
BKP_SERVER_NAME=isexdb.c0c7awbddcio.ap-southeast-1.rds.amazonaws.com
BKP_SERVER_DB_PORT=3306
BKP_USER_NAME=isxprod
BKP_USER_PWD=xx
BKP_DB_NAME=isxprod
BKP_FILE_NAME=${BKP_DB_NAME}_`date +"%Y%m%d_%H%M"`

#Application env
APP_LOCATION_BASE=/var/www
APP_NAME1=api
APP_NAME2=livesite
APP_BKP_FILE_NAME1=${APP_NAME1}_`date +"%Y%m%d_%H%M"`
APP_BKP_FILE_NAME2=${APP_NAME2}_`date +"%Y%m%d_%H%M"`
