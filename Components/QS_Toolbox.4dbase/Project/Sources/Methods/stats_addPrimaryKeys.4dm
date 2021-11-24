//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  //should run on mono or server side! (apply to selection)

$primaryKeyDefaultName:="PK_UUID"

$logFolder:=Get 4D folder:C485(Logs folder:K5:19)
$logFileName:="add_primary_key"
$logFileSuffix:=".log"
$logFileIndex:=0
$logPath:=$logFolder+$logFileName+$logFileSuffix
While (Test path name:C476($logPath)=Is a document:K24:1)
	$logFileIndex:=$logFileIndex+1
	$logPath:=$logFolder+$logFileName+Char:C90(Space:K15:42)+String:C10($logFileIndex)+$logFileSuffix
End while 

$logFileDocRef:=Create document:C266($logPath)

If (OK=1)
	
	C_TEXT:C284($logMessage)
	USE CHARACTER SET:C205("utf-8";0)
	
	ARRAY LONGINT:C221($TABLE_IDS;0)
	ARRAY TEXT:C222($TABLE_NAMES;0)
	
	Begin SQL
		/* all tables without a primary key */
		SELECT TABLE_ID,TABLE_NAME
		FROM _USER_TABLES
		WHERE _USER_TABLES.TABLE_ID NOT IN 
		(SELECT TABLE_ID FROM _USER_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'P')
		INTO :$TABLE_IDS,:$TABLE_NAMES;
	End SQL
	
	If (Num:C11(Substring:C12(Application version:C493;1;2))<13)
		  //on v12 the above code return 0 tables if no table has primary key
		If (Size of array:C274($TABLE_IDS)=0)
			Begin SQL
				/* all tables */
				SELECT TABLE_ID,TABLE_NAME
				FROM _USER_TABLES
				INTO :$TABLE_IDS,:$TABLE_NAMES;
			End SQL
		End if 
	End if 
	
	$logMessage:="number of tables with no primary key: "+String:C10(Size of array:C274($TABLE_IDS))+"\n"
	SEND PACKET:C103($logFileDocRef;$logMessage)
	
	For ($i;1;Size of array:C274($TABLE_IDS))
		
		$logMessage:="adding primary keys...\n"
		SEND PACKET:C103($logFileDocRef;$logMessage)
		
		$TABLE_ID:=$TABLE_IDS{$i}
		$TABLE_NAME:=$TABLE_NAMES{$i}
		
		ARRAY TEXT:C222($COLUMN_NAMES;0)
		
		Begin SQL
			/* get field names */
			SELECT COLUMN_NAME
			FROM _USER_COLUMNS
			WHERE TABLE_ID = :$TABLE_ID
			INTO :$COLUMN_NAMES;
		End SQL
		
		  //define primary key name
		$primaryKeyIndex:=0
		$primaryKeyName:=$primaryKeyDefaultName
		While (Find in array:C230($COLUMN_NAMES;$primaryKeyName)#-1)
			$primaryKeyIndex:=$primaryKeyIndex+1
			$primaryKeyName:=$primaryKeyDefaultName+String:C10($primaryKeyIndex)
		End while 
		
		If (Num:C11(Substring:C12(Application version:C493;1;2))>13)
			$SQL:="ALTER TABLE "+"["+$TABLE_NAME+"]"+\
				" ADD TRAILING ["+$primaryKeyName+"] UUID AUTO_GENERATE PRIMARY KEY;"
		Else 
			  //trailing not supported
			$SQL:="ALTER TABLE "+"["+$TABLE_NAME+"]"+\
				" ADD ["+$primaryKeyName+"] UUID AUTO_GENERATE PRIMARY KEY;"
		End if 
		
		Begin SQL
			EXECUTE IMMEDIATE :$SQL;
		End SQL
		
		If (OK=1)
			
			$logMessage:=String:C10($TABLE_IDS{$i})+"\t"+$TABLE_NAME+"\t"+$primaryKeyName+"\n"
			SEND PACKET:C103($logFileDocRef;$logMessage)
			
			$COLUMN_ID:=0
			Begin SQL
				/* get primary key field number */
				SELECT _USER_CONS_COLUMNS.COLUMN_ID
				FROM _USER_CONSTRAINTS,_USER_CONS_COLUMNS
				WHERE CONSTRAINT_TYPE = 'P'
				AND _USER_CONS_COLUMNS.TABLE_ID = :$TABLE_ID
				AND _USER_CONS_COLUMNS.CONSTRAINT_ID = _USER_CONSTRAINTS.CONSTRAINT_ID
				INTO :$COLUMN_ID;
			End SQL
			
			If ($COLUMN_ID#0)
				
				$field:=Field:C253($TABLE_ID;$COLUMN_ID)
				ALL RECORDS:C47(Table:C252($TABLE_ID)->)
				$table:=Table:C252($TABLE_ID)  //to avoid compile error in line below
				APPLY TO SELECTION:C70($table->;$field->:=Generate UUID:C1066)
				
				If (Num:C11(Substring:C12(Application version:C493;1;2))<13)
					  //on v12 it is possible to add primary key while record is locked
					If (Records in set:C195("LockedSet")=0)
						$logMessage:="updated records: "+String:C10(Records in selection:C76($table->))+"\n"
						SEND PACKET:C103($logFileDocRef;$logMessage)
					Else 
						$logMessage:="could not update records: "+String:C10(Records in set:C195("LockedSet"))+"\n"
						SEND PACKET:C103($logFileDocRef;$logMessage)
					End if 
					USE SET:C118("LockedSet")
					ARRAY LONGINT:C221($lockedRecords;0)
					LONGINT ARRAY FROM SELECTION:C647($table->;$lockedRecords)
					
					  //on v12 is field value Null does not report autouuid nulls; need record number
					For ($j;1;Size of array:C274($lockedRecords))
						$logMessage:=String:C10($lockedRecords{$j})+"\n"
						SEND PACKET:C103($logFileDocRef;$logMessage)
					End for 
				End if 
				
				If (Num:C11(Substring:C12(Application version:C493;1;2))>13)
					$SQL:="ALTER TABLE "+"["+$TABLE_NAME+"] ENABLE LOG;"
					  //no need to create index here; in fact, it will result in error
					  //let 4D automatically add unique index for primary key
					Begin SQL
						EXECUTE IMMEDIATE :$SQL;
					End SQL
				End if 
				
			End if 
			
		Else 
			$logMessage:="error: "+$SQL+"\n"
			SEND PACKET:C103($logFileDocRef;$logMessage)
		End if 
		
	End for 
	
	If (Num:C11(Substring:C12(Application version:C493;1;2))<14)
		
		For ($i;1;Size of array:C274($TABLE_IDS))
			
			$logMessage:="adding primary keys...\n"
			SEND PACKET:C103($logFileDocRef;$logMessage)
			
			$TABLE_ID:=$TABLE_IDS{$i}
			
			$primaryKeyName:=""
			
			Begin SQL
				SELECT _USER_CONS_COLUMNS.COLUMN_NAME
				FROM _USER_CONSTRAINTS,_USER_CONS_COLUMNS
				WHERE CONSTRAINT_TYPE = 'P'
				AND _USER_CONS_COLUMNS.TABLE_ID = :$TABLE_ID
				AND _USER_CONS_COLUMNS.CONSTRAINT_ID = _USER_CONSTRAINTS.CONSTRAINT_ID
				INTO :$primaryKeyName;
			End SQL
			
			$indexName:=$TABLE_NAME+"."+$primaryKeyName
			
			$SQL:="CREATE UNIQUE INDEX "+"["+$indexName+"]"+\
				" ON ["+$TABLE_NAME+"] ("+"["+$primaryKeyName+"]);"
			
			Begin SQL
				EXECUTE IMMEDIATE :$SQL;
			End SQL
			
		End for 
		
	End if 
	
	USE CHARACTER SET:C205(*)
	CLOSE DOCUMENT:C267($logFileDocRef)
	SHOW ON DISK:C922($logPath)
	
End if 
