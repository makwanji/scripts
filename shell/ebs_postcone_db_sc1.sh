#!/usr/bin/bash
# -------------------------------------------------------------------------------
#  SCRIPT          : ebs_postcone_db_sc1.sh
#  Application     : Oracle EBS DBA
#  Fonction        : post cloning script
#  History
#  --------
#  Date                Author          		 Update
#  11/1/2019           Jig                   Creation
# -------------------------------------------------------------------------------

sqlplus "/ as sysdba" << EOF
CREATE OR REPLACE DIRECTORY  ABC AS '/u01/DEV/apps/apps_st/ABC/';
EOF