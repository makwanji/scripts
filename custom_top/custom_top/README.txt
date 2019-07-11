Steps:

1. copy 5 files to the $APPL_TOP/admin folder
2. run the adsplice
3. this will create 2 custom_top

Note: 
if you want to change the custom_top name then edit the newprods.txt file and create copy of 2 files.
	a) xxcus1err.txt
	b) xxcus1prod.txt

Verificatoin :

select APPLICATION_ID,APPLICATION_SHORT_NAME,PRODUCT_CODE  from fnd_application where application_short_name in ('XXCUS1','XXCUS2');
select APPLICATION_ID,PRODUCT_VERSION from fnd_product_installations where APPLICATION_ID in (5011, 5012);
select username from dba_users where username in ('XXCUS1','XXCUS2');



[applmgr@ebsdemo122 ~]$ env | grep XX
XXCUS2_TOP=/u01/VIS/fs1/EBSapps/appl/xxcus2/12.0.0
XXCUS1_TOP=/u01/VIS/fs1/EBSapps/appl/xxcus1/12.0.0
[applmgr@ebsdemo122 ~]$ ls /u01/VIS/fs1/EBSapps/appl/xxcus2/12.0.0
admin  log  mesg  out  sql
[applmgr@ebsdemo122 ~]$ ls /u01/VIS/fs1/EBSapps/appl/xxcus1/12.0.0
admin  log  mesg  out  sql
[applmgr@ebsdemo122 ~]$
