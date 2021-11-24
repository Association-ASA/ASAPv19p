//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
C_TEXT:C284($QS_VCS_COMP_DB_PATH)
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	DELETE FROM SETUP
	WHERE MOD_REF >0; -- delete all data
	
	USE DATABASE SQL_INTERNAL;
End SQL