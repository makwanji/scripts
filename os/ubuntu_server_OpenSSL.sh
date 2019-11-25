#!/bin/ksh
# set -x
# -------------------------------------------------------------------------------
#  SCRIPT          : ubuntu_server_OpenSSL.sh
#  Application     : setup OpenSSL
#  Fonction        :
#  History
#  --------
#  Date                Author          		 Update
#  11/17/2019          Jig                   Creation
# -------------------------------------------------------------------------------

#Reference
# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-18-04

#Create Certificate request
openssl req –new –newkey rsa:2048 –nodes –keyout server.key –out server.csr
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout apache-selfsigned.key -out apache-selfsigned.crt

https://www.itech-s.com/
http://adminix.itech-s.com/
Itech Global Solutions
isXpense


# Country Name (2 letter code) [AU]:SG
# State or Province Name (full name) [Some-State]:Singapore
# Locality Name (eg, city) []:Singapore
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:Itech Global Solutions
# Organizational Unit Name (eg, section) []:isXpense
# Common Name (e.g. server FQDN or YOUR name) []:adminix.itech-s.com
# Email Address []:admin@itech-s.com

# Creating an Apache Configuration Snippet with Strong Encryption Settings
/etc/apache2/conf-available/ssl-params.conf

SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
SSLHonorCipherOrder On
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
# Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
# Requires Apache >= 2.4
SSLCompression off
SSLUseStapling on
SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
# Requires Apache >= 2.4.11
SSLSessionTickets Off

# Modifying the Default Apache SSL Virtual Host File
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bak

sudo vim /etc/apache2/sites-available/default-ssl.conf


<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin adminix.itech-s.com
                ServerName adminix.itech-s.com

                DocumentRoot /var/www/livesite/public
                <Directory /var/www/livesite>
                AllowOverride All
                </Directory>

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                SSLCertificateKeyFile /etc/ssl/certs/apache-selfsigned.key

                SSLCertificateFile      /home/ubuntu/cert/adminix_itech-s_com.crt
                # SSLCertificateKeyFile /home/ubuntu/cert/private-key.pem
                SSLCertificateChainFile /home/ubuntu/cert/USERTrust_RSA_Certification_Authority.crt
                SSLCACertificateFile    /home/ubuntu/cert/AddTrust_External_CA_Root.crt


                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

        </VirtualHost>
</IfModule>



# Modifying the HTTP Host File to Redirect to HTTPS

cp /etc/apache2/sites-available/livesite.conf /etc/apache2/sites-available/livesite.conf.http

Redirect "/" "https://your_domain_or_IP/"

# Enabling the Changes in Apache
sudo a2enmod ssl
sudo a2enmod headers

sudo a2ensite default-ssl
sudo a2enconf ssl-params

sudo apache2ctl configtest
systemctl restart apache2

#Create Certificate
#change apache

#
# How do I generate a CSR key?
#

openssl req -new -newkey rsa:2048 -nodes -keyout /root/ssl/adminix.key -out adminix.csr


#Scp File

scp -i ~/.ssh/ix-prod.pem /Users/jig/Downloads/adminix_itech-s_com.zip ubuntu@18.139.155.135:/tmp
