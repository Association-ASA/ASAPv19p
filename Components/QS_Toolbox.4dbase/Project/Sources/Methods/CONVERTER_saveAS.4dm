//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$MethodName:=Request:C163("New method name:")
$MethodTxt:=(OBJECT Get pointer:C1124(Object named:K67:5;"codeTo"))->

If (($MethodName#"") & ($MethodTxt#""))
	$code:=METHOD Get path:C1164(Path project method:K72:1;$MethodName;*)
	UPDT_WriteMethod ($code;$MethodTxt)
End if 

displayInfo ("Method '"+$MethodName+"' created in the host database.")