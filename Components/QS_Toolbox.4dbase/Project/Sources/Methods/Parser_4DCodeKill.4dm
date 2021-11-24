//%attributes = {"invisible":true}
// PM: "killParser4DCode"

If (Storage:C1525.windows.parseProcess#Null:C1517)
	
	If (Storage:C1525.windows.parseProcess#0)
		POST OUTSIDE CALL:C329(Storage:C1525.windows.parseProcess)
	End if 
	
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 2)
	Until ((Process state:C330(Storage:C1525.windows.parseProcess)<Executing:K13:4) | Process aborted:C672)
	
	OB_windowNumberToStorage("parseProcess"; 0)
End if 

// - EOF -