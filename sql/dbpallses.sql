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
select sid,serial#,status,program,machine,process,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time 
from v$session where username is not null order by status,LOGIN_TIME;
select sid,serial#,status,program,machine,process,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time 
from v$session where username is not null and status='ACTIVE' order by status,LOGIN_TIME; 