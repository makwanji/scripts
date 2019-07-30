# -----------------------------------------------------------------------------------
# File Name    : https://github.com/makwanji/dba_scripts/sql/rman_backup_db.sh
# Author       : Jignesh Makwana
# Description  : Shell script to trigger oracle database backup
# Call Syntax  : nohup sh rman_backup_db.sh > rman_backup_db.log & 
# Requirements : Linux, Unix
# Version      : 1.0
# Last Modified: 23/07/2012
# -----------------------------------------------------------------------------------


# create folder structuer
# mkdir -p $HOME/dba/scripts
# mkdir -p /u01/bkp/logs


#set environment
. /u01/E122V/12.1.0/E122V_ebsdemo.env
export BK_ROOT=/u01/bkp



#set the date of backup
TDIR=`date +"%Y%m%d"`
BK_DIR=$BK_ROOT/current

#backup scripts
WORK=$HOME/dba/scripts
SCRIPT=$WORK/rman_backup_db_l0.rman
LOC=$BK_ROOT/logs


# unique logfile
DATE=`date +"%Y%m%d-%H%M%S"`
LOGFILE=''${LOC}'/rman_'${ORACLE_SID}'_full_backup_'${DATE}'.log'
echo "log: "${LOGFILE} > $LOGFILE
echo "Started " >> $LOGFILE
date >> $LOGFILE
echo instance $ORACLE_SID >> $LOGFILE

# Run script
${ORACLE_HOME}/bin/rman @$SCRIPT USING $TDIR >> $LOGFILE
returncode=$?
echo $returncode return code >> $LOGFILE
df >> $LOGFILE
echo "Ended " >> $LOGFILE
date >> $LOGFILE

exit