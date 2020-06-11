# Oracle Database
<!-- /TOC -->

## Database Perfomance
### DB Locking session


##Database Object
##Database Tablespace
##RMAN Backup/Restore

Help document


select 'set newname for datafile '||file#||' to ''+DATA1'';' from v$datafile; 
select 'set newname for logfile '||file#||' to ''+DATA1'';' from v$logfile; 

set newname for tempfile <fileno> to '<path>'
set newname for logfile 1 to '+REDO'




##### Table of Contents  
[Database Perfomance](#Database-Perfomance)  
[Emphasis](#emphasis)  
...snip...    
<a name="headers"/>
## Database-Perfomance






# TSA RMAN Example

rman auxiliary / 

run {
startup nomount;
duplicate target database to CNV backup location '/tmp/20140906/';
}


#### Code
```sql
rman auxiliary / 

run {
startup nomount;
duplicate target database to CNV backup location '/tmp/20140906/';
}
```




#### Code
```bash

cat > dbplock.sql << EOF
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
