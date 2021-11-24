Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		If (Form:C1466.FKCLselected.length=1)
			C_TEXT:C284($txt)
			$txt:=Form:C1466.FKCLselected[0].from+" --> "+Form:C1466.FKCLselected[0].to
			displayInfo ($txt)
		End if 
End case 