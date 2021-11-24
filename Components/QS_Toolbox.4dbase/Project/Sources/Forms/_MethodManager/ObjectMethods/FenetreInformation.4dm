Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		C_TEXT:C284($path)
		If (Form:C1466.currentMethod#"")
			$path:=Form:C1466.currentMethod
			SET TEXT TO PASTEBOARD:C523(Form:C1466.currentMethod)
		End if 
End case 