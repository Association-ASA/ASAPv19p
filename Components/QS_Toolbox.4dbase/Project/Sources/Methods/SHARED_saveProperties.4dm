//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_COLLECTION:C1488($SharedData)
$SharedData:=New shared collection:C1527

Use (Storage:C1525)
	If (Storage:C1525.QS_TBX_METHODS_Invisible=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_Invisible:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_Web=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_Web:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_SOAP=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_SOAP:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_WSDL=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_WSDL:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_SHARED=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_SHARED:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_SQL=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_SQL:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_OnServer=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_OnServer:=New shared collection:C1527
	End if 
	
End use 