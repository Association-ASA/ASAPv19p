//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 16/04/18, 17:15:12
  // ----------------------------------------------------
  // Méthode : VCS_GetAllProjects
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
C_TEXT:C284($QS_VCS_COMP_DB_PATH)
ARRAY TEXT:C222($Projects_at;0x0000)
C_COLLECTION:C1488($coll;$0)

$coll:=New collection:C1472
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT DISTINCT(EXP_APPLICATION)
	FROM EXPORTS
	INTO :[$Projects_at];
	
	USE DATABASE SQL_INTERNAL;
End SQL

ARRAY TO COLLECTION:C1563($coll;$Projects_at;"project")
$0:=$coll.copy()