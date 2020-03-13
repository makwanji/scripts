#!/usr/bin/bash
# -------------------------------------------------------------------------------
#  SCRIPT          : WLSHealthCheck.sh
#  Application     : Oracle EBS DBA
#  Fonction        : Check health of Weblogic
#  History
#  --------
#  Date                Author          		 Update
#  11/1/2019           Jig                   Creation
# -------------------------------------------------------------------------------

wls_username=weblogic
wls_password=Weblogic1

. /u01/DEV/apps/EBSapps.env run

HOST=`hostname`

#grep -i port $CONTEXT_FILE|grep "WLS Admin Server Port"|awk -F '>' '{print $2}'|awk -F '<' '{print $1}' > /tmp/AdminPorts.log
grep -i port $CONTEXT_FILE|grep server1|grep -v forms-c4ws| awk -F '>' '{print $2}'|awk -F '<' '{print $1}' >> /tmp/AdminPorts.log

awk 'BEGIN { FS = "[:,}]" } { print $2,$4,$6,$8,$10 }' /tmp/AdminPorts.log| tr " " "\n"|awk '/./' > /tmp/AdminPorts_final.log
grep -i port $CONTEXT_FILE|grep "WLS Admin Server Port"|awk -F '>' '{print $2}'|awk -F '<' '{print $1}' >> /tmp/AdminPorts_final.log
rowcnt=`awk 'END {print NR}' /tmp/AdminPorts_final.log`
while [ $rowcnt -gt 0 ]
do
        portnum=`awk 'NR=='$rowcnt' {print $1}' /tmp/AdminPorts_final.log`
        java -cp $FMW_HOME/wlserver_10.3/server/lib/weblogic.jar weblogic.Admin -url t3://$HOST:$portnum -username $wls_username -password $wls_password GETSTATE >> /tmp/WLSStatus.lst
        rowcnt=$(($rowcnt -1))
done

grep -v "^$" /tmp/WLSStatus.lst > /tmp/WLSStatus_final.lst

cat /tmp/WLSStatus_final.lst

rm /tmp/WLSStatus.lst
rm /tmp/WLSStatus_final.lst
rm /tmp/AdminPorts.log
rm /tmp/AdminPorts_final.log
