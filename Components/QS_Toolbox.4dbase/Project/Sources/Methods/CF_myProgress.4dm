//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// Cannot be preepmtif due to OBJECT SET VISIBLE

C_REAL:C285($1; $progress)
C_BOOLEAN:C305($continue)

$progress:=$1
If (Count parameters:C259=2)
	C_BOOLEAN:C305($2)
	$continue:=$2
End if 

If (Not:C34($continue))
	Form:C1466.myProgress:=$progress
	OBJECT SET VISIBLE:C603(*; "progress"; ($progress<100))
	$canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "progress")
	$canvas->:=progressBar_getSvg_object($canvas; $progress/100)
End if 