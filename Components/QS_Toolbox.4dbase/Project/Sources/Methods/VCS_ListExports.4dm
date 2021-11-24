//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
ARRAY TEXT:C222($Exports_at;0x0000)
ARRAY DATE:C224($ExportsDates_ad;0x0000)
C_COLLECTION:C1488($coll;$0)
$coll:=New collection:C1472

C_TEXT:C284($QS_VCS_COMP_DB_PATH;$QS_TBX_DBNAME)
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$QS_TBX_DBNAME:=Storage:C1525.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT EXP_CODE, EXP_DATE
	FROM EXPORTS
	WHERE EXP_APPLICATION = :[$QS_TBX_DBName]
	ORDER BY 2 DESC 
	INTO :[$Exports_at], :[$ExportsDates_ad];
	
	USE DATABASE SQL_INTERNAL;
	
End SQL

ARRAY TO COLLECTION:C1563($coll;$Exports_at;"uniqueID";$ExportsDates_ad;"timeStamp")
$0:=$coll.copy()