-- -----------------------------------------------------------------------------------
-- File Name    : https://github.com/makwanji/dba_scripts/sql/tbsf.sql
-- Author       : Jignesh Makwana
-- Description  : Find the list of files in database
-- Call Syntax  : @tbsn (connect as a apps user)
-- Requirements : connect with the apps user / appsread
-- Version      : 1.0
-- Last Modified: 23/07/2012
-- -----------------------------------------------------------------------------------

set linesize 120
set pagesize 100
col MEMBER 			for a50
col name 			for a50
col FILE_NAME 		for a50
col TABLESPACE_NAME	for a20


prompt "CONTROL FILE List"
select name,STATUS from v$controlfile order by name;

prompt "LOG FILE List"
select GROUP#,MEMBER,STATUS,TYPE from v$logfile order by GROUP#;

prompt "DATA FILE List"
select FILE_ID,FILE_NAME,STATUS,TABLESPACE_NAME from dba_data_files order by TABLESPACE_NAME,file_name;

prompt "TEMP FILE List"
select FILE_ID,FILE_NAME,STATUS,TABLESPACE_NAME from dba_temp_files order by TABLESPACE_NAME,file_name;

