-- one SQL


-- 100: Database


-- 900: RMAN

-- 901# RMAN Catalog database and query for proper Controlfile backup 
rman connect catalog rman/rman123@CAT
list backup of controlfile completed between "to_date('11.06.2014','dd.mm.yyyy hh24')" and "to_date('12.06.2014','dd.mm.yyyy hh24')";


-- 902# Connect RMAN Catalog database and query for proper Controlfile backup like following.
SELECT session_recid,TO_CHAR (start_time, 'DD-MM-YYYY  HH24:MI:SS') start_time, input_type, status, ROUND (elapsed_seconds / 3600, 1) time_hr,INPUT_BYTES/1024/1024/1024 IN_GB,OUTPUT_BYTES/1024/1024/1024  OUT_GB ,OUTPUT_DEVICE_TYPE 
FROM   v$rman_backup_job_details   
WHERE  START_TIME > SYSDATE - 5 ORDER BY start_time desc;

 

select * from v$rman_output where session_recid=729;   


Reference note:
https://shivanandarao-oracle.com/2012/12/05/rman-20207-until-time-or-recovery-window-is-before-resetlogs-time/
