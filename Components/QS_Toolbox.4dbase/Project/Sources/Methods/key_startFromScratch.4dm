//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
  // key_startFromScratch
  // RESET ALL LICENCE INFORMATION

C_TEXT:C284($QS_VCS_COMP_DB_PATH)
C_OBJECT:C1216($file)

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	DELETE FROM LICENCE; -- delete all data
	USE DATABASE SQL_INTERNAL;
	
End SQL

$file:=Folder:C1567(fk licenses folder:K87:16).file("qs_toolbox.licence")
If ($file.exists)
	$file.delete()
End if 
