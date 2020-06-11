# Oracle Database
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
