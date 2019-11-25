#!/bin/ksh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : ubuntu_upgrade_1904.sh
#  Application     : Install Apache in Ubuntu server
#  Fonction        : call script to instll apache in Ubuntu folder
#  History
#  --------
#  Date                Author          		 Update
#  11/13/2019          Jig                   Creation
# -------------------------------------------------------------------------------

#Upgrade Ubuntu
sudo apt update && sudo apt dist-upgrade -y
sudo apt install update-manager-core
sudo nano /etc/update-manager/release-upgrades
