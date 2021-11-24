//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/04/18, 20:54:16
  // ----------------------------------------------------
  // Méthode : VCS_Get_Exported_Info
  // Description
  // Paramètres
  // ----------------------------------------------------

ARRAY TEXT:C222($PathExported_at;0x0000)
ARRAY DATE:C224($DateExported_at;0x0000)
ARRAY LONGINT:C221($TimeExported_at;0x0000)
ARRAY LONGINT:C221($TimeStampExported_at;0x0000)
C_TEXT:C284($QS_VCS_COMP_DB_PATH;$1)
C_TEXT:C284($timestamp;$QS_TBX_DBName)
C_COLLECTION:C1488($coll;$0)
$coll:=New collection:C1472

$timestamp:=$1
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$QS_TBX_DBName:=Storage:C1525.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT VCS_PATH, VCS_DATE, VCS_TIME, VCS_TIMESTAMP
	FROM VCS
	WHERE VCS_TIMESTAMP = :[$Timestamp] AND VCS_APPLICATION = :[$QS_TBX_DBName]
	INTO :[$PathExported_at], :[$DateExported_at], :[$TimeExported_at], :[$TimeStampExported_at];
	
	USE DATABASE SQL_INTERNAL;
End SQL

ARRAY TO COLLECTION:C1563($coll;$PathExported_at;"path";$DateExported_at;"dateStamp";$TimeExported_at;"timeStamp";$TimeStampExported_at;"exportDate")
$0:=$coll.copy()