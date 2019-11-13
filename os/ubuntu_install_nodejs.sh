#!/bin/bash
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : ubuntu_install_nodejs.sh
#  Application     : Install NodeJS in Ubuntu server
#  Fonction        : call script to instll NodeJS in Ubuntu folder
#  History
#  --------
#  Date                Author          		 Update
#  11/13/2019          Jig                   Creation
# -------------------------------------------------------------------------------

#Install Node.js and node modules
sudo apt-get update
sudo apt-get install nodejs
sudo apt install nodejs-legacy
sudo apt-get install build-essential
sudo apt-get install npm
