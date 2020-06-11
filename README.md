# Oracle Database SQL's

### Database lock
```shell
cat > dbplock.sql<< EOF
SET PAGESIZE 60
SET LINESIZE 300

COLUMN owner FORMAT A20
COLUMN username FORMAT A20
COLUMN object_owner FORMAT A20
COLUMN object_name FORMAT A30
COLUMN locked_mode FORMAT A35

SELECT b.inst_id, b.session_id AS sid, NVL(b.oracle_username, '(oracle)') AS username, a.owner AS object_owner, a.object_name, Decode(b.locked_mode, 0, 'None', 1, 'Null (NULL)', 2, 'Row-S (SS)', 3, 'Row-X (SX)', 4, 'Share (S)', 5, 'S/Row-X (SSX)', 6, 'Exclusive (X)', b.locked_mode) locked_mode, b.os_user_name FROM   dba_objects a, gv\$locked_object b WHERE  a.object_id = b.object_id ORDER BY 1, 2, 3, 4; 
EOF
```

### Long running session

``` 
cat > dbplongses.sql << EOF
set lines 400 pages 400
select s.username,s.status,s.machine,s.sql_id,s.sid,s.serial#,s.last_call_et/60 mins_running,q.sql_text 
from v\$session s 
join v\$sqltext_with_newlines q
on s.sql_address = q.address
 where status='ACTIVE' and type <>'BACKGROUND'
and last_call_et> 1800 
order by sid,serial#,q.piece; 
EOF
```


### All running session
``` 
cat > dbpallses.sql << EOF
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
select sid,serial#,status,program,machine,process,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time from v\$session where username is not null order by status,LOGIN_TIME;
select sid,serial#,status,program,machine,process,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time from v\$session where username is not null and status='ACTIVE' order by status,LOGIN_TIME; 

EOF
```

### details about session

```
cat > dbpdigses.sql

select sid,serial#,status,program,machine,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time from v\$session where sid=&sid; 

EOF
```

### SQLID Plan


```
cat > dbpsqlplan.sql

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

EOF
```

