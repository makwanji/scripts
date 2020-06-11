select sid,serial#,status,program,machine,username,sql_id,to_char(logon_time, 'hh24:mi dd/mm/yy') login_time 
from v$session where sid=&sid; 
