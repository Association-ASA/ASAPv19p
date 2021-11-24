//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}

$ref_window:=Num:C11(Storage:C1525.windows.floatwindow)
If ($ref_window>0)
	If (Count parameters:C259=1)
		C_OBJECT:C1216($1)
		CALL FORM:C1391($ref_window; "floatWindow_writeToStorage"; $1)
	Else 
		CALL FORM:C1391($ref_window; "floatWindow_writeToStorage")
	End if 
Else 
	$1.trigger()  // To not block all the component
End if 