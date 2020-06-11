set lines 400 pages 400
select s.username,s.status,s.machine,s.sql_id,s.sid,s.serial#,s.last_call_et/60 mins_running,q.sql_text 
from v$session s 
join v$sqltext_with_newlines q
on s.sql_address = q.address
where status='ACTIVE' and type <> 'BACKGROUND'
and last_call_et > 1800 
order by sid,serial#,q.piece; 