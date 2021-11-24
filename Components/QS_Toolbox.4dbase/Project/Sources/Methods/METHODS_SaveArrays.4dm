//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // By this sequence, we create a shared object
SHARED_saveProperties 

C_COLLECTION:C1488($SharedData)
$SharedData:=New shared collection:C1527

Use (Storage:C1525)
	
	If (Storage:C1525.QS_TBX_METHODS_4DMobile=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_4DMobile:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_PREEMPTIVE=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_PREEMPTIVE:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_NbLignes=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_NbLignes:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_Comment=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_Comment:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_Vide=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_Vide:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_Appel=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_Appel:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_Complex=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_Complex:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_DernModif=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_DernModif:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_MethodName=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_MethodName:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_MethodCallees=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_MethodCallees:=New shared collection:C1527
	End if 
	
	If (Storage:C1525.QS_TBX_METHODS_MethodCallers=Null:C1517)
		Storage:C1525.QS_TBX_METHODS_MethodCallers:=New shared collection:C1527
	End if 
	
End use 