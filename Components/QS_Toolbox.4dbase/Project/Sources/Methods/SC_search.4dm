//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($1)
C_TEXT:C284($2;$3)

$1.result:=False:C215  // By default, not displayed

If ($1.value[$2]=$3)
	$1.result:=True:C214
End if 
