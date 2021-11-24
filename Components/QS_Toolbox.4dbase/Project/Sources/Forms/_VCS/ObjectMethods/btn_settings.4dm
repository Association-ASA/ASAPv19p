$col:=Form:C1466.exportListSelected
$oldTimeStamp:=Request:C163("Enter the timestamp to replace:")
$newTimeStamp:=Request:C163("Enter the new timestamp to replace '"+$oldTimeStamp+"':")
If ($newTimeStamp#$oldTimeStamp)
	
	$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
	$QS_TBX_DBName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
	
	Begin SQL
		USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
		
		UPDATE VCS
		SET VCS_TIMESTAMP = :[$newTimeStamp]
		WHERE VCS_APPLICATION = :[$QS_TBX_DBName] and VCS_TIMESTAMP = :[$oldTimeStamp];
		
		USE DATABASE SQL_INTERNAL;
	End SQL
	
End if 
