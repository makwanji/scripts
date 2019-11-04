#!/bin/ksh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : ebsFunction.sh
#  Application     : Oracle EBS DBA
#  Fonction        : Start and stop EBS Database and Application
#  History
#  --------
#  Date                Author          		 Update
#  11/1/2019           Jig                   Creation
# -------------------------------------------------------------------------------


# entry of sensitive information such as a database password

# stty -echo    
        # echo -n "Enter the database system password:  "
        # read pw
# stty echo


message () {
	echo `date +"%Y%m%d %H%M : "` $1
}

setOracleEnv () {
	ORACLE_SID=$1
	message "Database name $1"
	ORAENV_ASK=NO
	. oraenv
	unset ORAENV_ASK
}

statusDB () {
	DBNAME=$1
	DB_EXIST_IN_ORATAB=`cat /etc/oratab | grep ${DBNAME}`
	
	
	if [ -z "$DB_EXIST_IN_ORATAB" ] 
	then
		message "Database entry not found in oratab file"
		exit 0;
	else
		
		setOracleEnv ${DBNAME} 
	fi
	
	message "Database information" 

	output='sqlplus -s "/ as sysdba" <<EOF
       set heading off feedback off verify off
       select name,open_mode,log_mode from v\$database;
       exit
EOF
'


}


#!/bin/bash


echo $output

stopDB () {
	message "operation - stopDB"
	
	doContinue=n
	echo -n "Do you really want to continue? (y/n) " 
	read doContinue

	if [ "$doContinue" != "y" ]; then
		  echo "Quitting..."
		  exit
	fi	
	
}

startDB () {
	message "operation - startDB"
}

stopAP () {
	message "operation - stopAP"
	ps -ef 
}

startAP () {
	message "operation - startAP"
}

statusAP () {
	message "operation - statusAP"
}

