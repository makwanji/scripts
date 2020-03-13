-- -----------------------------------------------------------------------------------
-- File Name    : db_start_time.sql
-- Author       : Jignesh Makwana
-- Description  : Find the database startup time
-- Call Syntax  : @dbidb_start_timenfo 
-- Requirements : 
-- Version      : 1.0
-- Last Modified: 12/03/2020
-- -----------------------------------------------------------------------------------


COL INSTANCE_NAME FOR A10
SELECT INSTANCE_NAME INS_NAME,TO_CHAR(STARTUP_TIME, 'HH24:MI DD-MON-RRRR') STARTUP_TIME 
FROM DBA_HIST_DATABASE_INSTANCE ORDER BY STARTUP_TIME DESC;


SET LINE 60
COLUMN HOSTNAME FOR A60
COLUMN INSTANCE_NAME FOR A60
COLUMN STIME FOR A60
COLUMN UPTIME FOR A60
SELECT
'HOSTNAME : ' || HOST_NAME
,'INSTANCE NAME : ' || INSTANCE_NAME
,'STARTED AT : ' || TO_CHAR(STARTUP_TIME,'DD-MON-YYYY HH24:MI:SS') STIME
,'UPTIME : ' || FLOOR(SYSDATE - STARTUP_TIME) || ' DAYS(S) ' ||
TRUNC( 24*((SYSDATE-STARTUP_TIME) -
TRUNC(SYSDATE-STARTUP_TIME))) || ' HOUR(S) ' ||
MOD(TRUNC(1440*((SYSDATE-STARTUP_TIME) -
TRUNC(SYSDATE-STARTUP_TIME))), 60) ||' MINUTE(S) ' ||
MOD(TRUNC(86400*((SYSDATE-STARTUP_TIME) -
TRUNC(SYSDATE-STARTUP_TIME))), 60) ||' SECONDS' UPTIME
FROM
SYS.V_$INSTANCE;

