#!/bin/ksh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : ebsAdmin.sh
#  Application     : Oracle EBS DBA
#  Fonction        : Start and stop EBS Database and Application
#  History
#  --------
#  Date                Author          		 Update
#  11/1/2019           Jig                   Creation
# -------------------------------------------------------------------------------

typeset pid_arc=$$
PGM="ebsAdmin"
MY_HOST=`hostname -a`
LOGFILE=/u01/app/grid/diag/crs/${MY_HOST}/crs/log/${PGM}_${pid_arc}.log

#
# include your function filef
#
. ./ebsFunction.sh


#
# validate user
#

echo "You are logged in as ‘whoami‘";

if [ ‘whoami‘ != "oracle" ]; then
  echo "Must be logged on as oracle to run this script."
  exit
fi

echo "Running script at ‘date‘"


# usage
#
#Logic if you didn't receive parameters
#

if [ $# -lt 2 ]
then
   echo "Argument 1 : Database name"
   echo "		CCA01INT|TFPS3INT"
   echo "Argument 3 : Action"
   echo "		STOPDB|STARTDB|STATUSDB"
   echo "		STOPAP|STARTAP|STATUSAP"
   echo "E.g. ebsAdmin.sh TFPS3INT STATUSDB"
   exit
fi

## Assing your variable
export DBNAME=$1
export ACTION=$2


## call function
case $ACTION in
  STOPDB) stopDB $DBNAME ;;
  STARTDB) startDB $DBNAME ;;
  STATUSDB) statusDB $DBNAME ;;
  STOPAP) stopAP $DBNAME ;;
  STARTAP) startAP $DBNAME ;;
  STATUSAP) statusAP $DBNAME ;;
  *)    echo "!! Invalid choice"
esac


# /opt/oracle/jm1/ebsAdmin.sh isieie3 STATUSDB