//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
C_OBJECT:C1216($1; $options)
C_BLOB:C604($2; $blob)

$options:=$1
$blob:=$2

var $dbName; $lastUpdate; $QS_VCS_COMP_DB_PATH : Text
var $curentDate : Date
var $count : Integer

$curentDate:=$options.currentDate
$lastUpdate:=$options.lastUpdate
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$dbName:=$options.dbName


Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT COUNT (*)
	FROM LICENCE
	WHERE LIC_NAME = :[$dbName]
	INTO :[$count];
	
End SQL

Case of 
	: ($count>0)
		
		Begin SQL
			
			UPDATE LICENCE
			SET LIC_PARAM = :[$blob], LIC_DATE = :[$curentDate]
			WHERE LIC_NAME = :[$dbName];
			
			USE DATABASE SQL_INTERNAL;
		End SQL
		
	: ($count=0)
		
		Begin SQL
			
			INSERT INTO LICENCE
			(LIC_PARAM, LIC_DATE, LIC_NAME)
			VALUES
			(:[$blob],:[$curentDate],:[$dbName]);
			
			USE DATABASE SQL_INTERNAL;
		End SQL
		
End case 