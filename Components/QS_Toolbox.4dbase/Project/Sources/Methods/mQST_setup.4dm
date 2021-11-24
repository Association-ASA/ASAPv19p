//%attributes = {"publishedSoap":false,"publishedWsdl":false,"shared":true,"publishedWeb":false,"publishedSql":false,"invisible":true,"executedOnServer":false,"preemptive":"indifferent","published4DMobile":{"scope":"none"}}
If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone#Null:C1517)
	$ref:=Open form window:C675("_Setup";Modal form dialog box:K39:7;Horizontally centered:K39:1;Vertically centered:K39:4)
	DIALOG:C40("_Setup")
Else 
	C_POINTER:C301($ptr)
	EXECUTE METHOD:C1007("qs_toolbox";*;$ptr)
End if 


