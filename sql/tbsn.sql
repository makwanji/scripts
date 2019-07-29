-- -----------------------------------------------------------------------------------
-- File Name    : https://github.com/makwanji/dba_scripts/sql/tbsn.sql
-- Author       : Jignesh Makwana
-- Description  : Find the tablespace usage
-- Call Syntax  : @tbsn (connect as a apps user)
-- Requirements : connect with the apps user / appsread
-- Version      : 1.0
-- Last Modified: 23/07/2012
-- -----------------------------------------------------------------------------------

set linesize 120
set pagesize 100
col TABLESPACE_NAME for a25
col BYTES_MB for 999,999.999
col FREE_BYTES_MB for 99,999.999
col ACTUAL_USED_MB for 99,999.999
col FILE_USED_PTC for a8
col MAXBYTES_MB for 9999,999.999
col BAL_MAX_EXT_MB for 999,999.999
col max_ext_used_pt for a8
col AUTO_EXTEND for a3
SELECT a.tablespace_name
     , round(a.bytes_mb,3) bytes_mb
     , round(b.free_bytes_mb,3) free_bytes_mb
     , round((a.bytes_mb - b.free_bytes_mb),3) actual_used_mb
     , round(((a.bytes_mb - b.free_bytes_mb)*100/a.bytes_mb),3) || '%' file_used_ptc
     , round(a.maxbytes_mb,3) maxbytes_mb
     , round((a.maxbytes_mb - (a.bytes_mb - b.free_bytes_mb)),3) bal_max_ext_mb
     , round(((a.bytes_mb - b.free_bytes_mb)*100/a.maxbytes_mb),3) || '%' max_ext_used_pt
     , decode(a.autoext,0,'No','Yes') Auto_extend
  FROM (SELECT   dbf.tablespace_name
               , SUM (dbf.bytes)/1024/1024 bytes_mb
               , SUM (decode(dbf.maxbytes,0,dbf.bytes,dbf.maxbytes))/1024/1024 maxbytes_mb
               , sum (dbf.maxbytes) autoext
            FROM dba_data_files dbf
        GROUP BY tablespace_name) a
     , (SELECT   tablespace_name
               , SUM (BYTES) / 1024 / 1024 free_bytes_mb
            FROM dba_free_space
        GROUP BY tablespace_name) b
 WHERE a.tablespace_name = b.tablespace_name
-- and   round(((a.bytes_mb - b.free_bytes_mb)*100/a.bytes_mb),3) > 85
 order by round(((a.bytes_mb - b.free_bytes_mb)*100/a.bytes_mb),3) desc ;
