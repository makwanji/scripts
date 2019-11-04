#!/bin/ksh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : runDbScript.sh
#  Application     : Oracle Database
#  Fonction        : This script will run other SQL Scripts
#  History
#  --------
#  Date                Author          		 Update
#  11/1/2019           Jig                   Creation
# -------------------------------------------------------------------------------

## collect database information
ORACLE_SID=XXX
ORAENV_ASK=NO
. oraenv
sqlplus -s / as sysdba <<EOF
@/tmp/dbinfo.sql
@/tmp/archtab.sql
EOF
