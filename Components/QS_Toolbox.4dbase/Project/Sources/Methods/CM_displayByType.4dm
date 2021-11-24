//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($1)
C_TEXT:C284($2;$3)

$1.result:=False:C215  // By default, not displayed

If ($1.value.path=$2)
	$1.result:=True:C214
	
	If (Count parameters:C259=3)
		If ($1.value.name=$3)
			$1.result:=True:C214
		Else 
			$1.result:=False:C215
		End if 
	End if 
End if 

