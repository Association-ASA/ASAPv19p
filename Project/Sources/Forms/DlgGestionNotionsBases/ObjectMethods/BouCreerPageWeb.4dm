If (Macintosh command down:C546)
	C_LONGINT:C283($Salé;$FT)
	ALL RECORDS:C47([DiaTextesWeb:38])
	
	$FT:=Records in selection:C76([DiaTextesWeb:38])
	For ($Salé;1;$FT)
		DiaWebEcritLaPageTextes 
		NEXT RECORD:C51([DiaTextesWeb:38])
	End for 
	
	
Else 
	DiaWebEcritLaPageTextes 
End if 
ALERT:C41("fini")
