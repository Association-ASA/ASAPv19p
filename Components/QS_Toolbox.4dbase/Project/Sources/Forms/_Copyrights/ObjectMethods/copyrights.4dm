Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Form:C1466.currentElement.site#"")
			OPEN URL:C673(Form:C1466.currentElement.site)
		End if 
End case 