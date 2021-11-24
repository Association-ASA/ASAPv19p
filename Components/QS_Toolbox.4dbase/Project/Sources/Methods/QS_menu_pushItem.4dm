//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_COLLECTION:C1488($1)
C_TEXT:C284($2;$3)
C_BOOLEAN:C305($isOK)

$isOK:=True:C214

If (Count parameters:C259=4)
	C_BOOLEAN:C305($4)
	$isOK:=$4
End if 

$1.push(New object:C1471("label";$2;"menu";$3;"isValid";$isOk))
