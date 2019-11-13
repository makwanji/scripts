#!/bin/ksh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : ubuntu_install_php.sh
#  Application     : Install PHP in Ubuntu server
#  Fonction        : call script to instll PHP in Ubuntu folder
#  History
#  --------
#  Date                Author          		 Update
#  11/13/2019          Jig                   Creation
# -------------------------------------------------------------------------------


#PHP Packages
sudo apt-get install php libapache2-mod-php php-mysql -y
