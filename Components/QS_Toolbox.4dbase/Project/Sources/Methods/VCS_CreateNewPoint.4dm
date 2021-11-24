//%attributes = {"invisible":true,"executedOnServer":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 09/04/18, 21:03:39
  // ----------------------------------------------------
  // Méthode : VCS_CreateNewPoint
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($loop_l;$CurrentStamp_l;$TimeMethod)
C_DATE:C307($today;$DateMethod)
C_TEXT:C284($methodPath_t;$code)
C_TEXT:C284($QS_VCS_COMP_DB_PATH;$QS_TBX_DBName;$rootfolder)
C_OBJECT:C1216($toSave)
C_COLLECTION:C1488($1)

$CurrentStamp_l:=Form:C1466.currentStamp
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
  //$QS_TBX_DBName:=Storage.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName
$QS_TBX_DBName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName

$today:=Current date:C33
$rootfolder:=String:C10($CurrentStamp_l)

Begin SQL
	
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	INSERT INTO EXPORTS
	(EXP_CODE, EXP_DATE, EXP_APPLICATION)
	VALUES
	(:[$rootfolder], :[$today], :[$QS_TBX_DBName]);
	
End SQL

ARRAY TEXT:C222($methodCode_at;0x0000)
ARRAY TEXT:C222($paths_at;0x0000)
COLLECTION TO ARRAY:C1562($1;$paths_at;"path")
METHOD GET CODE:C1190($paths_at;$methodCode_at;*)

For each ($toSave;$1)
	
	$methodPath_t:=$toSave.path
	$DateMethod:=Date:C102($toSave.dateStamp)
	$TimeMethod:=$toSave.timeStamp
	$loop_l:=Find in array:C230($paths_at;$methodPath_t)
	$Code:=$methodCode_at{$loop_l}
	
	Begin SQL
		
		USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE; -- Take more time, but more safe
		
		INSERT INTO VCS
		(VCS_PATH, VCS_CODE, VCS_DATE, VCS_TIME, VCS_TIMESTAMP, VCS_APPLICATION)
		VALUES
		(:[$methodPath_t], :[$code], :[$DateMethod], :[$TimeMethod], :[$rootfolder], :[$QS_TBX_DBName]);
		
	End SQL
	
End for each 

  // Restore the destination
Begin SQL
	USE DATABASE SQL_INTERNAL;
End SQL