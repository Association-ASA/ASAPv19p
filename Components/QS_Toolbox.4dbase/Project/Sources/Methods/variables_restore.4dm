//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
#DECLARE($options : Object)

var $dbName; $QS_VCS_COMP_DB_PATH : Text
C_DATE:C307($savedDate)
var $blob : Blob

$dbName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
SET BLOB SIZE:C606($blob; 0)

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT  LIC_PARAM, LIC_DATE
	FROM LICENCE
	WHERE LIC_NAME = :[$dbName]
	INTO :[$blob], :[$savedDate];
	
	USE DATABASE SQL_INTERNAL;
End SQL

$options.path:=$QS_VCS_COMP_DB_PATH
$options.dbName:=$dbName
$options.lastUpdate:=""
$options.curentDate:=$savedDate

$0:=$blob
