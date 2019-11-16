#!/bin/sh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : app_backup.sh
#  Application     : backup application folder
#  Fonction        : This script take bacup of MySQL Database
#  History
#  --------
#  Date                Author          		 Update
#  11/16/2019          Jig                   Creation
# -------------------------------------------------------------------------------

# soruce file
# Please deploy script in $HOME/script folder
. $HOME/scripts/myserver_env.sh

#Backup Application
cd ${APP_LOCATION_BASE}
tar -czvf /tmp/${APP_BKP_FILE_NAME1}.tz ${APP_NAME1}
tar -czvf /tmp/${APP_BKP_FILE_NAME2}.tz ${APP_NAME2}

myecho "copy backup to aws s3"
aws s3 cp /tmp/${APP_BKP_FILE_NAME1}.tz s3://${BKP_S3_NAME}/
aws s3 cp /tmp/${APP_BKP_FILE_NAME2}.tz s3://${BKP_S3_NAME}/

myecho "Remove backup from local disk"
rm -f /tmp/${APP_BKP_FILE_NAME1}.tz
rm -f /tmp/${APP_BKP_FILE_NAME2}.tz
