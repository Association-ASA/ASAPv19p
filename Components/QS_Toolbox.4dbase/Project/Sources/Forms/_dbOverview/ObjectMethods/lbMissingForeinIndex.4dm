Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		If (Form:C1466.CILselected.length=1)
			$txt:=Form:C1466.CILselected[0].index+":  "+Form:C1466.CILselected[0].composite
			displayInfo ($txt)
		End if 
End case 