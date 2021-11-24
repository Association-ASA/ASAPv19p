//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
If (Form:C1466.currentTable#Null:C1517)
	If (Form:C1466.currentTable.id>0)
		
		//If ($numTable>0)
		C_COLLECTION:C1488($col)
		$col:=New collection:C1472("Copy All Tables & Fields definition"; "Create code to 'Add Record'"; "Copy Fields definition for ["+Table name:C256(Form:C1466.currentTable.id)+"]")
		$referenceLigne:=Pop up menu:C542($col.join(";"))
		
		Case of 
				
			: ($referenceLigne=1)
				SUPPORT_tablesAndFieldsList
				
			: ($referenceLigne=2)
				TOOLS_CreateAddRecordCode
				
			: ($referenceLigne=3)
				CALL WORKER:C1389("QST_setInMemory"; "lb_collectionToPasteboard"; Form:C1466.result)
				
				
		End case 
		
	End if 
Else 
	ALERT:C41("There is NO table.")
	
End if 