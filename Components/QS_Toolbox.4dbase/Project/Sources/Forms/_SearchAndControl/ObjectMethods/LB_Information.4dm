Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Right click:C712)
		Else 
			LB_displayCellContent 
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Right click:C712)
		Else 
			METHOD OPEN PATH:C1213(Form:C1466.currentElement.method;*)
		End if 
End case 