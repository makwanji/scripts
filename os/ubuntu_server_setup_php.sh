#!/bin/ksh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : ubuntu_server_setup_php.sh
#  Application     : setup PHP Server in Ubuntu OS
#  Fonction        : This script will call others script
#  History
#  --------
#  Date                Author          		 Update
#  11/13/2019          Jig                   Creation
# -------------------------------------------------------------------------------

# Install Apache
echo "Install Apache2"
sh ./ubuntu_install_apache.sh

# Install PHP
echo "Install PHP"
sh ./ubuntu_install_php.sh

# Install MySQL Client
echo "Install MySQL Client"
sh ./ubuntu_install_mysql_client.sh
