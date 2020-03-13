-- -----------------------------------------------------------------------------------
-- File Name    : patch.sql
-- Author       : Jignesh Makwana
-- Description  : Find the patch information
-- Call Syntax  : @patch
-- Requirements : 
-- Version      : 1.0
-- Last Modified: 12/03/2020
-- -----------------------------------------------------------------------------------

select BUG_NUMBER, LAST_UPDATE_DATE, LANGUAGE 
from ad_bugs where BUG_NUMBER = '&patch';