-- -----------------------------------------------------------------------------------
-- File Name    : mysql_createdb.sql
-- Author       : Jignesh Makwana
-- Description  : Create database in MySQL Database
-- Call Syntax  : @mysql_createdb
-- Requirements : connect with server
-- Version      : 1.0
-- Last Modified: 23/07/2014
-- -----------------------------------------------------------------------------------

-- cnnect to database server
-- mysql -h isexdb.c0c7awbddcio.ap-southeast-1.rds.amazonaws.com -P 3306 -u admin -p


CREATE DATABASE `laravel`;
CREATE USER `laravel`@`*` IDENTIFIED BY 'laravel';
GRANT ALL ON laravel.* TO `isxprod `@`*`;
FLUSH PRIVILEGES;
exit;
