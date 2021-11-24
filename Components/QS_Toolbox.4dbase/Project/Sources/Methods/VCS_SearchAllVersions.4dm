//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 08/04/18, 17:23:05
  // ----------------------------------------------------
  // Méthode : VCS_SearchAllVersions
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

ARRAY TEXT:C222($Path_All_at;0x0000)
ARRAY DATE:C224($Date_all_at;0x0000)
ARRAY LONGINT:C221($Time_all_at;0x0000)
ARRAY TEXT:C222($TimeStamp_all_at;0x0000)
C_TEXT:C284($QS_VCS_COMP_DB_PATH;$QS_TBX_DBName)
C_COLLECTION:C1488($coll;$0)
$coll:=New collection:C1472

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
  //$QS_TBX_DBName:=Storage.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName
$QS_TBX_DBName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName


Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT VCS_PATH, VCS_DATE, VCS_TIME, VCS_TIMESTAMP
	FROM VCS
	WHERE VCS_APPLICATION = :[$QS_TBX_DBName]
	ORDER BY VCS_PATH ASC, VCS_DATE DESC
	INTO :[$Path_all_at], :[$Date_all_at], :[$Time_all_at], :[$TimeStamp_all_at];
	
	USE DATABASE SQL_INTERNAL;
End SQL

ARRAY TO COLLECTION:C1563($coll;$Path_all_at;"path";$Date_all_at;"dateStamp";$Time_all_at;"timeStamp";$TimeStamp_all_at;"timeStampAll")
$0:=$coll.copy()