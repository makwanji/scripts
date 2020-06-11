-- one SQL


-- 100: Database


-- 500: Perfomace tunning

-- 501: find locking session (if any) 

```shell
cat > dbplock.sql<< EOF
SET PAGESIZE 60
SET LINESIZE 300

COLUMN owner FORMAT A20
COLUMN username FORMAT A20
COLUMN object_owner FORMAT A20
COLUMN object_name FORMAT A30
COLUMN locked_mode FORMAT A35

SELECT b.inst_id, b.session_id AS sid, NVL(b.oracle_username, '(oracle)') AS username, a.owner AS object_owner, a.object_name, Decode(b.locked_mode, 0, 'None', 1, 'Null (NULL)', 2, 'Row-S (SS)', 3, 'Row-X (SX)', 4, 'Share (S)', 5, 'S/Row-X (SSX)', 6, 'Exclusive (X)', b.locked_mode) locked_mode, b.os_user_name FROM   dba_objects a, gv$locked_object b WHERE  a.object_id = b.object_id ORDER BY 1, 2, 3, 4; 
EOF
```

-- 502: long running sessoin

```
set lines 400 pages 400
select s.username,s.status,s.machine,s.sql_id,s.sid,s.serial#,s.last_call_et/60 mins_running,q.sql_text from v$session s 
join v$sqltext_with_newlines q
on s.sql_address = q.address
 where status='ACTIVE' and type <>'BACKGROUND'
and last_call_et> 1800 
order by sid,serial#,q.piece; 
```

-- 503: list all running sessions

set lines 200 pages 1000
col MACHINE for a35
col PROGRAM for a35
col TERMINAL for a15
col USERNAME for a20
col sql_sid for a20
col STATUS for a10
col OSUSER for a10
col LOGIN_TIME for a25
COL EVENT FOR A30
select name,open_mode from v$database;
select sid,serial#,status,program,machine,process,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time from v$session where username is not null order by status,LOGIN_TIME;
select sid,serial#,status,program,machine,process,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time from v$session where username is not null and status='ACTIVE' order by status,LOGIN_TIME; 
 
 
-- 504: find details about SID

## specific session  
select sid,serial#,status,program,machine,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time from v$session where sid=&sid; 
  
-- 505: List SQL Plan for SID

col begin_time for a25
col end_time for a11
col inst for 99999
col snapid for 999999
set lines 200 
set pages 20000 
select snap_id snapid,
(select substr(BEGIN_INTERVAL_TIME,1,18)||' '||substr(BEGIN_INTERVAL_TIME,24,2) from dba_hist_snapshot b where b.snap_id=a.snap_id and a.INSTANCE_NUMBER=b.INSTANCE_NUMBER) begin_time,(select substr(end_INTERVAL_TIME,11,8)||' '||substr(end_INTERVAL_TIME,24,2) from dba_hist_snapshot b where b.snap_id=a.snap_id and
a.INSTANCE_NUMBER=b.INSTANCE_NUMBER) end_time
,INSTANCE_NUMBER inst , PLAN_HASH_VALUE,
EXECUTIONS_DELTA Executions,
ROWS_PROCESSED_DELTA rows1,
round( CPU_TIME_DELTA /1000000,0) cpu_time,round(IOWAIT_DELTA /1000000,0) io_wait,
round( ELAPSED_TIME_DELTA /1000000,0) elapsed
from wrh$_sqlstat a where sql_id in('&SQL_ID')
order by snap_id, INSTANCE_NUMBER; 


-- 506: tunning advisor - create task

DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          sql_id      => '1ykb0cv92pwb5',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 60,
                          task_name   => '1ykb0cv92pwb5_tuning_task',
                          description => 'Tuning task for statement 1ykb0cv92pwb5');
  DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/ 

-- 507. tunning advisor - execute task
  
EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '1ykb0cv92pwb5_tuning_task'); 

-- 508. tunning advisor - check result

SET linesize 200
SET LONG 999999999
SET pages 1000
SET longchunksize 20000
SELECT DBMS_SQLTUNE.report_tuning_task('1ykb0cv92pwb5_tuning_task') AS recommendations FROM dual;  


--509. check SQL Profile
select * from dba_sql_profiles;
select NAME from dba_sql_profiles;
 



--###
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
