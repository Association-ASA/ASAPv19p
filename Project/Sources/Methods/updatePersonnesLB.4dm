//%attributes = {}
If (Storage:C1525.window#Null:C1517)
	If (Storage:C1525.window.lbPersonnes#0)
		DELAY PROCESS:C323(Current process:C322; 10)
		CALL FORM:C1391(Storage:C1525.window.lbPersonnes; "wLBpersonnes")
	End if 
End if 