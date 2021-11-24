//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/04/18, 09:10:06
  // ----------------------------------------------------
  // Méthode : VCS_GetOldVersion
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($Timestamp;$1)
C_TEXT:C284($path;$OldVersion;$2)
C_TEXT:C284($QS_VCS_COMP_DB_PATH;$QS_TBX_DBName)

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$QS_TBX_DBName:=Storage:C1525.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName
$Timestamp:=$1
$path:=$2

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT VCS_CODE
	FROM VCS
	WHERE VCS_TIME = :[$Timestamp] AND VCS_PATH = :[$path] AND VCS_APPLICATION = :[$QS_TBX_DBName]
	INTO :[$OldVersion];
	
	USE DATABASE SQL_INTERNAL;
	
End SQL

MM_removeFirstLine (->$OldVersion)
$0:=$OldVersion