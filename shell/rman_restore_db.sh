# -----------------------------------------------------------------------------------
# File Name    : https://github.com/makwanji/scripts/sql/rman_restore_db.sh
# Author       : Jignesh Makwana
# Description  : Shell script to trigger oracle database restore
# Call Syntax  : nohup sh rman_restore_db.sh > rman_restore_db.log & 
# Requirements : Linux, Unix
# Version      : 1.0
# Last Modified: 23/07/2012
# -----------------------------------------------------------------------------------

DB_LOG_HOME=$HOME/rman/logs

# soruce oracle database file
. /u01/app/oracle/tech_st/12.1.0/E122V_rac1.env

## start restore operation - individual files
# rman target / @rman_restore_db_f1.rman	

## start restore duplicate database

# shutdown database
sqlplus "/as sysdba" << EOF
shut immediate;
EOF

#startup nomount
sqlplus "/as sysdba" << EOF
startup nomount;
EOF

# start duplicate database
rman auxiliary / log="$DB_LOG_HOME/restore.txt" @rman_restore_db_f2.rman
