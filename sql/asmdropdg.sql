-- Jignesh
51198.00


51198.00

SET PAUSE ON
SET PAUSE 'Press return to Continue'
SET LINESIZE 300
SET PAGESIZE 60
 
SELECT name FROM v$asm_diskgroup
/


-- check disk and it's size
set linesize 180
col path for a50
select path,header_status from v$asm_disk;



-- Empty Datagroup

+DATA/ASM/ASMPARAMETERFILE/registry.253.1014457759

https://aprakash.wordpress.com/2012/04/24/ora-15027-active-use-of-diskgroup-data-precludes-its-dismount/


create spfile='+DATA1' from pfile='/tmp/jm1.txt';

alter diskgroup DATA1 set attribute 'compatible.asm'='11.2.0.0.0'; group altered.


SQL> alter diskgroup DATA1 set attribute 'compatible.asm'='11.2.0.0.0';

Diskgroup altered.

SQL> create spfile='+DATA1' from pfile='/tmp/jm1.txt';

File created.

SQL>



SQL> alter diskgroup DATA1 set attribute 'compatible.asm'='11.2.0.0.0';

Diskgroup altered.

SQL> create spfile='+DATA1' from pfile='/tmp/jm1.txt';

File created.



[grid@rac1 ~]$ sqlplus "/as sysasm"

SQL*Plus: Release 12.1.0.2.0 Production on Tue Jul 30 15:38:45 2019

Copyright (c) 1982, 2014, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup;
ASM instance started

Total System Global Area 1140850688 bytes
Fixed Size                  2933400 bytes
Variable Size            1112751464 bytes
ASM Cache                  25165824 bytes
ASM diskgroups mounted
SQL>



CREATE DISKGROUP RECO1 NORMAL REDUNDANCY
  FAILGROUP failure_group_1 DISK
    '/devices/diska1' NAME diska1,
    '/devices/diska2' NAME diska2
  FAILGROUP failure_group_2 DISK
    '/devices/diskb1' NAME diskb1,
    '/devices/diskb2' NAME diskb2;




SQL> col path for a50
SQL> /

PATH                                               HEADER_STATU
-------------------------------------------------- ------------
/dev/oracleasm/disk01                              MEMBER
/dev/oracleasm/disk02                              MEMBER
/dev/oracleasm/disk06                              MEMBER
/dev/oracleasm/disk04                              MEMBER
/dev/oracleasm/disk05                              MEMBER
/dev/oracleasm/disk03                              MEMBER

6 rows selected.

SQL> 1
  1* select path,header_status from v$asm_disk
SQL> alter diskgroup data mount;

Diskgroup altered.

SQL> drop diskgroup data;

Diskgroup dropped.

SQL> select path,header_status from v$asm_disk;

PATH                                               HEADER_STATU
-------------------------------------------------- ------------
/dev/oracleasm/disk01                              FORMER
/dev/oracleasm/disk02                              FORMER
/dev/oracleasm/disk06                              MEMBER
/dev/oracleasm/disk04                              MEMBER
/dev/oracleasm/disk05                              MEMBER
/dev/oracleasm/disk03                              MEMBER

6 rows selected.

SQL> CREATE DISKGROUP RECO1 EXTERNAL REDUNDANCY DISK '/dev/oracleasm/disk01','/dev/oracleasm/disk02';

Diskgroup created.

SQL> select path,header_status from v$asm_disk;

PATH                                               HEADER_STATU
-------------------------------------------------- ------------
/dev/oracleasm/disk01                              MEMBER
/dev/oracleasm/disk06                              MEMBER
/dev/oracleasm/disk04                              MEMBER
/dev/oracleasm/disk02                              MEMBER
/dev/oracleasm/disk05                              MEMBER
/dev/oracleasm/disk03                              MEMBER

6 rows selected.

SQL>



----- create disk group 
 select path,header_status from v$asm_disk;

PATH
--------------------------------------------------------------------------------
HEADER_STATU
------------
/dev/oracleasm/disk01
MEMBER

/dev/oracleasm/disk02
MEMBER

/dev/oracleasm/disk06
MEMBER


PATH
--------------------------------------------------------------------------------
HEADER_STATU
------------
/dev/oracleasm/disk04
MEMBER

/dev/oracleasm/disk05
MEMBER

/dev/oracleasm/disk03
MEMBER


6 rows selected.

SQL> col path for a50
SQL> /

PATH                                               HEADER_STATU
-------------------------------------------------- ------------
/dev/oracleasm/disk01                              MEMBER
/dev/oracleasm/disk02                              MEMBER
/dev/oracleasm/disk06                              MEMBER
/dev/oracleasm/disk04                              MEMBER
/dev/oracleasm/disk05                              MEMBER
/dev/oracleasm/disk03                              MEMBER

6 rows selected.

SQL> 1
  1* select path,header_status from v$asm_disk
SQL> alter diskgroup data mount;

Diskgroup altered.

SQL> drop diskgroup data;

Diskgroup dropped.

SQL> select path,header_status from v$asm_disk;

PATH                                               HEADER_STATU
-------------------------------------------------- ------------
/dev/oracleasm/disk01                              FORMER
/dev/oracleasm/disk02                              FORMER
/dev/oracleasm/disk06                              MEMBER
/dev/oracleasm/disk04                              MEMBER
/dev/oracleasm/disk05                              MEMBER
/dev/oracleasm/disk03                              MEMBER

6 rows selected.

SQL> CREATE DISKGROUP RECO1 EXTERNAL REDUNDANCY DISK '/dev/oracleasm/disk01','/dev/oracleasm/disk02';

Diskgroup created.



PATH                                               HEADER_STATU
-------------------------------------------------- ------------
/dev/oracleasm/disk01                              MEMBER
/dev/oracleasm/disk06                              MEMBER
/dev/oracleasm/disk04                              MEMBER
/dev/oracleasm/disk02                              MEMBER
/dev/oracleasm/disk05                              MEMBER
/dev/oracleasm/disk03                              MEMBER

6 rows selected.

SQL> exit
Disconnected from Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option
[grid@rac1 ~]$ lsdg
-bash: lsdg: command not found
[grid@rac1 ~]$ asmcmd lsdg
State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  EXTERN  N         512   4096  1048576    409596   219377                0          219377              0             N  DATA1/
MOUNTED  EXTERN  N         512   4096  1048576    102396   102344                0          102344              0             N  RECO1/
MOUNTED  NORMAL  N         512   4096  1048576    102396   100412                0           50206              0             N  REDO/
[grid@rac1 ~]$ sqlplus "/as sysasm"

SQL*Plus: Release 12.1.0.2.0 Production on Tue Jul 30 15:50:15 2019

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option

SQL> drop diskgroup RECO1;

Diskgroup dropped.

SQL>

