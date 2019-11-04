-- -----------------------------------------------------------------------------------
-- File Name    : dbinfo.sql
-- Author       : Jignesh Makwana
-- Description  : Find the database details
-- Call Syntax  : @dbinfo (connect as a apps user)
-- Requirements : connect with the apps user / appsread
-- Version      : 1.0
-- Last Modified: 23/07/2016
-- -----------------------------------------------------------------------------------

set linesize 180
set pagesize 100

prompt ==> Database information..!
col OPEN_MODE for a11
col FLASHBACK_ON for a4
select 	DBID, NAME, LOG_MODE, OPEN_MODE, PROTECTION_MODE, PROTECTION_LEVEL, DATABASE_ROLE, FLASHBACK_ON
from 	v$database;

prompt ==> Datafile information..!
col FILE_NAME for a60
col TABLESPACE_NAME for a15
select 	TABLESPACE_NAME, FILE_NAME, STATUS, to_char(round (BYTES/1024/1024/1024,2), '9999.99') Size_GB, 
		to_char(round (BYTES/1024/1024/1024,2), '9999.99') MSize_GB, STATUS, AUTOEXTENSIBLE 
from dba_data_files;


prompt ==> Tempfile information..!
select 	TABLESPACE_NAME, FILE_NAME, STATUS, to_char(round (BYTES/1024/1024/1024,2), '9999.99') Size_GB, 
		to_char(round (BYTES/1024/1024/1024,2), '9999.99') MSize_GB, STATUS, AUTOEXTENSIBLE 
from dba_temp_files;


prompt ==> Controlfile information..!
col NAME for a60
select 	NAME, STATUS, IS_RECOVERY_DEST_FILE REC, BLOCK_SIZE, FILE_SIZE_BLKS
from v$controlfile;


prompt ==> Redolog information..!
col MEMBER for a60
select 	MEMBER, b.GROUP#, THREAD#, to_char(round (BYTES/1024/1024/1024,2), '9999.99') Size_GB, b.STATUS, b.ARCHIVED
from 	v$logfile a, gv$log b
where	a.GROUP# = b.GROUP#;
