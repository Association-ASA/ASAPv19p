//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_BOOLEAN:C305($1)
If (Shift down:C543)
	
	$shared:=Storage:C1525.QS_TBX_SHARED_DATA
	Use ($shared)
		$shared.QS_TBX_crossReference:=False:C215
		$shared.QS_LH_commands:=0
	End use 
	
	Use (Storage:C1525.allMethods)
		Storage:C1525.allMethods.clear()
	End use 
	CALL WORKER:C1389("QST_getMethodsInformation"; "WKR_updateMethodsInformation"; $1)
End if 