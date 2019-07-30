-- -----------------------------------------------------------------------------------
-- File Name    : https://github.com/makwanji/dba_scripts/os/oel7_install.sh
-- Author       : Jignesh Makwana
-- Description  : this script will configure the packages to intall oracle softwares
-- Call Syntax  : sh oel7_install.sh
-- Requirements : Linux, Unix
-- Version      : 1.0
-- Last Modified: 29/07/2019
-- -----------------------------------------------------------------------------------



# Env variable

DOMAIN_NAME=hitachiconsulting.com

export NODE1_HOSTNAME=rac1
export NODE2_HOSTNAME=rac2
export NODE1_FQ_HOSTNAME=${NODE1_HOSTNAME}.${DOMAIN_NAME}
export NODE2_FQ_HOSTNAME=${NODE2_HOSTNAME}.${DOMAIN_NAME}
export NODE1_PUBLIC_IP='10.0.0.102'

# setup hostname
echo "******************************************************************************"
echo "Setup hostname ." `date`
echo "******************************************************************************"

hostname ${NODE1_HOSTNAME}
cat > /etc/hostname <<EOF
${NODE1_HOSTNAME}
EOF

# setup IP

cat > /etc/hosts <<EOF
127.0.0.1 localhost.localdomain localhost
# Public
${NODE1_PUBLIC_IP}  ${NODE1_FQ_HOSTNAME}  ${NODE1_HOSTNAME}
EOF

echo "******************************************************************************"
echo "Install common rpm ." `date`
echo "******************************************************************************"

# configure Yum
yum-config-manager --enable rhui-REGION-rhel-server-optional
# rhui-REGION-rhel-server-rh-common

# Install RPM
yum install -y vim
yum install -y wget
yum install -y sshpass zip unzip
yum install -y xorg-x11-apps

echo "******************************************************************************"
echo "Install database server rpm ." `date`
echo "******************************************************************************"


# from web
cd /tmp/
wget https://oss.oracle.com/projects/compat-oracle/dist/files/Enterprise_Linux/compat-libstdc++-296-2.96-144.0.2.el7.i686.rpm
wget https://oss.oracle.com/projects/compat-oracle/dist/files/Enterprise_Linux/openmotif21-2.1.30-11.el7.i686.rpm
wget https://oss.oracle.com/projects/compat-oracle/dist/files/Enterprise_Linux/xorg-x11-libs-compat-6.8.2-1.EL.33.0.1.i386.rpm

yum install -y openmotif21-2.1.30-11.el7.i686.rpm
yum install -y xorg-x11-libs-compat-6.8.2-1.EL.33.0.1.i386.rpm
yum install -y compat-libstdc++-296-2.96-144.0.2.el7.i686.rpm



# Install RPM DB
yum install -y vim
yum install -y binutils
yum install -y compat-libstdc++-33.i686
yum install -y gcc.x86_64
yum install -y gcc-c++.x86_64
yum install -y gdbm.i686
yum install -y gdbm.x86_64
yum install -y glibc.i686
yum install -y glibc.x86_64
yum install -y glibc-common.x86_64
yum install -y glibc-devel.i686
yum install -y glibc-devel.x86_64
yum install -y libgcc.i686
yum install -y libgcc.x86_64
yum install -y libstdc++.i686
yum install -y libstdc++-devel.i686
yum install -y libstdc++.x86_64
yum install -y libstdc++-devel.x86_64
yum install -y libXi.i686
yum install -y libXp.i686
yum install -y libXp.x86_64
yum install -y libXtst.i686
yum install -y libaio.i686
yum install -y libaio.x86_64
yum install -y libgomp.x86_64
yum install -y make.x86_64
yum install -y redhat-lsb.x86_64
yum install -y sysstat.x86_64
yum install -y util-linux.x86_64
yum install -y ksh.x86_64
yum install -y nfs-utils.x86_64

# DB Server
yum install -y compat-libcap1.x86_64
yum install -y compat-libstdc++-33.x86_64
yum install -y elfutils-libelf-devel.x86_64
yum install -y libaio-devel.i686
yum install -y libaio-devel.x86_64
yum install -y xorg-x11-utils.x86_64

# Preprae fdisk

echo "******************************************************************************"
echo "Prepare /u01 disk." `date`
echo "******************************************************************************"
# New partition for the whole disk.
echo -e "n\np\n1\n\n\nw" | fdisk /dev/nvme1n1

# Add file system.
mkfs.xfs -f /dev/nvme1n1p1

# Mount it.
UUID=`blkid -o value /dev/xvdf1 | grep -v xfs`
mkdir /u01
cat >> /etc/fstab <<EOF
UUID=${UUID}  /u01    xfs    defaults 1 2
EOF
mount /u01

# create swapfile
dd if=/dev/zero of=/u01/swapfile bs=1M count=16384
mkswap /u01/swapfile
chmod 0600 /u01/swapfile
swapon /u01/swapfile
cat /proc/swaps

UUID=`blkid -o value /u01/swapfile | grep -v swap`
cat >> /etc/fstab <<EOF
UUID=${UUID} none swap  defaults  0  0
EOF



#install AWScli

curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
export PATH=~/.local/bin:$PATH
source ~/.bash_profile
pip --version

#Install the AWS CLI with pip
pip install awscli --upgrade --user
aws --version

#Download database software
mkdir -p /u01/stage /u01/software
aws s3 cp s3://sa-software-stage/OracleDB/linuxamd64_12102_database_1of2.zip /u01/stage
aws s3 cp s3://sa-software-stage/OracleDB/linuxamd64_12102_database_2of2.zip /u01/stage
aws s3 cp s3://sa-software-stage/OracleDB/linuxamd64_12102_grid_1of2.zip /u01/stage
aws s3 cp s3://sa-software-stage/OracleDB/linuxamd64_12102_grid_2of2.zip /u01/stage

unzip -q -o /u01/stage/linuxamd64_12102_database_1of2.zip -d /u01/software
unzip -q -o /u01/stage/linuxamd64_12102_database_2of2.zip -d /u01/software
unzip -q -o /u01/stage/linuxamd64_12102_grid_1of2.zip -d /u01/software
unzip -q -o /u01/stage/linuxamd64_12102_grid_2of2.zip -d /u01/software

ls -l /u01/software

# create group and user
echo "******************************************************************************"
echo "Install database server rpm ." `date`
echo "******************************************************************************"
groupadd -g 500 dba
useradd -u 5001 -g dba -d /home/oracle -m oracle
useradd -u 5000 -g dba -d /home/grid -m grid

ORACLE_PASSWORD=oracle
GRID_PASSWORD=grid

echo -e "${ORACLE_PASSWORD}\n${ORACLE_PASSWORD}" | passwd oracle
echo -e "${GRID_PASSWORD}\n${GRID_PASSWORD}" | passwd grid
chown -R oracle:dba /u01
chmod -R 775 /u01
chown -R oracle:dba /u01/software/grid



# configure shared disk

echo "******************************************************************************"
if [ ! -e /dev/nvme2n1p1 ]; then
  echo -e "n\np\n1\n\n\nw" | fdisk /dev/nvme2n1
fi
if [ ! -e /dev/nvme3n1p1 ]; then
  echo -e "n\np\n1\n\n\nw" | fdisk /dev/nvme3n1
fi
if [ ! -e /dev/nvme4n1p1 ]; then
  echo -e "n\np\n1\n\n\nw" | fdisk /dev/nvme4n1
fi
if [ ! -e /dev/nvme5n1p1 ]; then
  echo -e "n\np\n1\n\n\nw" | fdisk /dev/nvme5n1
fi
ls -l /dev/nvme*


# Disk configure
cat > /etc/scsi_id.config <<EOF
options=-g
EOF


#create partation
parted /dev/xvdm
mktable gpt
mkpart asmpart1 0% 100%
quit

# get UUID one by one and create file
udevadm info --query=property /dev/xvdl1 | grep ID_PART_ENTRY_UUID

cat > /etc/udev/rules.d/99-oracle-asmdevices.rules <<EOF
KERNEL=="xvd??", ENV{ID_PART_ENTRY_UUID}=="642f888b-db18-4538-8caa-132b765b1ac7", SYMLINK+="oracleasm/disk01", OWNER="oracle", GROUP="dba", MODE="0660"
KERNEL=="xvd??", ENV{ID_PART_ENTRY_UUID}=="e059797a-d350-47cd-bb5b-e5a01553770c", SYMLINK+="oracleasm/disk02", OWNER="oracle", GROUP="dba", MODE="0660"
KERNEL=="xvd??", ENV{ID_PART_ENTRY_UUID}=="8fa30be3-244e-4f53-af2c-8d9db1492b58", SYMLINK+="oracleasm/disk03", OWNER="oracle", GROUP="dba", MODE="0660"
KERNEL=="xvd??", ENV{ID_PART_ENTRY_UUID}=="4885524d-4b7a-48ee-aca3-2c90d804bf79", SYMLINK+="oracleasm/disk04", OWNER="oracle", GROUP="dba", MODE="0660"
KERNEL=="xvd??", ENV{ID_PART_ENTRY_UUID}=="560d278a-22b6-4afe-9a3e-63d568b27f26", SYMLINK+="oracleasm/disk05", OWNER="oracle", GROUP="dba", MODE="0660"
KERNEL=="xvd??", ENV{ID_PART_ENTRY_UUID}=="627edeac-5dbc-41b4-b36e-475277b43722", SYMLINK+="oracleasm/disk06", OWNER="oracle", GROUP="dba", MODE="0660"
EOF



# Implement new rule
udevadm trigger

ls -al /dev/oracleasm/*

http://alexzy.blogspot.com/2018/02/configuring-disk-devices-manually-for.html

# setup env file

export ORACLE_HOME=/u01/app/grid/product/12.1.0
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=+ASM


# Env
*.control_files='+DATA1/E122V/controlfile/cntrl01.dbf','+REDO/E122V/controlfile/cntrl02.dbf'
*.db_file_name_convert='/u01/E122V/data','+DATA1/E122V/datafile'
*.log_file_name_convert='/u01/E122V/data','+REDO/E122V/onlinelog'


#	temp
http://www.oracledistilled.com/oracle-database/restore-database-to-another-host-using-rman/

sqlplus "/as sysdba" << EOF
STARTUP NOMOUNT;
RESTORE CONTROLFILE FROM "/u04/rman/bkp/E122V_ctl_20190726_0mu7jh8i";
alter database mount;
catalog start with '/u04/rman/bkp' noprompt;
restore datafile 1;

catalog start with '/u04/rman/bkp';
catalog start with '/u01/app/oracle/oradata/orcl/backup';

/u04/rman/bkp/E122V_ctl_20190726_0mu7jh8i


SET NEWNAME FOR DATAFILE 1 TO '+DATA1/E122V/datafile/system01.dbf';


sqlplus "/as sysdba" << EOF
startup nomount;
EOF


rman target / 
RESTORE CONTROLFILE FROM "/u04/rman/bkp/E122V_ctl_20190726_0mu7jh8i";


rman target /
restore backup of datafile 1;


catalog start with '/rman/rman/';


alter system set db_file_name_convert='/u01/E122V/data/','+DATA1/E122V/datafile/' scope=spfile;

*.db_file_name_convert='/u01/E122V/data','+DATA1/E122V/datafile'
*.log_file_name_convert='/u01/E122V/data','+REDO/E122V/onlinelog'
