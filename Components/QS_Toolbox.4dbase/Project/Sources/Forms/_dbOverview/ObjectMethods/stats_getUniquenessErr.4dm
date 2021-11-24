Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		If (Form:C1466.UEselected.length=1)
			$txt:=Form:C1466.UEselected[0].typeMap+" --> "+Form:C1466.UEselected[0].log
			displayInfo ($txt)
		End if 
End case 