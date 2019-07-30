# -----------------------------------------------------------------------------------
# File Name    : https://github.com/makwanji/dba_scripts/sql/rman_backup_db_cfg.sh
# Author       : Jignesh Makwana
# Description  : Shell script to configure backup location to take backups
# Call Syntax  : nohup sh rman_backup_db.sh > rman_backup_db.log & 
# Requirements : Linux, Unix
# Version      : 1.0
# Last Modified: 23/07/2012
# -----------------------------------------------------------------------------------

# https://blog.pythian.com/exploring-options-of-using-rman-configure-to-simplify-backup/

# create folder structuer
# mkdir -p $HOME/dba/scripts
# mkdir -p /u01/bkp/logs


rman target /

run {
	CONFIGURE ARCHIVELOG DELETION POLICY TO BACKED UP 2 TIMES TO DISK;
	CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/u04/FRA/E122V/%d_%I_%T_%U' MAXOPENFILES 1;
	CONFIGURE CHANNEL 1 DEVICE TYPE DISK FORMAT '/u04/FRA/E122V/%d_%I_%T_%U' MAXOPENFILES 1;
	CONFIGURE CONTROLFILE AUTOBACKUP ON;
	CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/u04/FRA/E122V/%d_%F.CTL';
	CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS;
	show all;
}


# rman scripts

set echo on;
connect target;
show all;
backup incremental level 0 check logical database filesperset 1 tag "fulldb"
plus archivelog filesperset 8 tag "archivelog";


# rman - shell

$ rman @simple.rman
