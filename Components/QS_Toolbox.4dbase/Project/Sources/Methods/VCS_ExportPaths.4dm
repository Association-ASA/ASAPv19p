//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}

C_COLLECTION:C1488($coll)
$coll:=New collection:C1472
If (Count parameters:C259=1)
	$coll:=$1
Else 
	$coll:=Form:C1466.toExport.copy()
End if 

VCS_CreateNewPoint ($coll)

If (Count parameters:C259=0)
	Form:C1466.toExport.clear()
	SET TIMER:C645(1)  // Immediate call and update the methods updated during the lapstime
End if 
