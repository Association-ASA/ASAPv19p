//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 12/04/18, 21:40:45
  // ----------------------------------------------------
  // Méthode : VCS_Get_TimeStampExported
  // Description
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($Path_t;$1;$0)
C_TEXT:C284($QS_VCS_COMP_DB_PATH;$VCS_QS_TBX_DBName)
ARRAY TEXT:C222($TimeStampExported;0x0000)

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$VCS_QS_TBX_DBName:=Storage:C1525.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName
$Path_t:=$1

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT VCS_TIMESTAMP
	FROM VCS
	WHERE VCS_PATH = :[$Path_t] AND VCS_APPLICATION = :[$VCS_QS_TBX_DBName]
	ORDER BY 1 DESC
	INTO :[$TimeStampExported];
	
	USE DATABASE SQL_INTERNAL;
End SQL

If (Size of array:C274($TimeStampExported)>0)
	$0:=$TimeStampExported{1}
Else 
	$0:="0"
End if 