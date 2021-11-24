//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
var $QS_VCS_COMP_DB_PATH : Text
var $indexID; $indexName : Text
var $columnName_t; $tableName_t : Text

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684)

$err:=Method called on error:C704
ON ERR CALL:C155("BASE_noERROR")
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

$columnName_t:="MOD_NAME"
$tableName_t:="SETUP"
$indexName:="setup_moduleName"

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	SELECT INDEX_ID
	FROM _USER_IND_COLUMNS
	WHERE (TABLE_NAME = :$tableName_t) AND (COLUMN_NAME = :$columnName_t)
	INTO :$indexID;
	USE DATABASE SQL_INTERNAL;
End SQL

If ($indexID="")
	Begin SQL
		USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
		
		CREATE INDEX SETUP_moduleName ON SETUP (MOD_NAME);
		CREATE INDEX EXPORT_application ON EXPORTS (EXP_APPLICATION);
		CREATE INDEX VCS_application ON VCS (VCS_APPLICATION);
		CREATE INDEX VCS_timeStamp ON VCS (VCS_TIMESTAMP);
		USE DATABASE SQL_INTERNAL;
	End SQL
	
End if 

ON ERR CALL:C155($err)

If (Count parameters:C259=1)
	var $1 : Object
	signal_addResult($1; Current method name:C684)
End if 