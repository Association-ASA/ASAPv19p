Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		If (Form:C1466.MFIselected.length=1)
			$txt:=Form:C1466.MFIselected[0].from+" --> "+Form:C1466.MFIselected[0].to
			displayInfo ($txt)
		End if 
End case 