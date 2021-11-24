
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$method:=Form:C1466.currentMethod
		If ($method#"")
			METHOD OPEN PATH:C1213($method;*)
		Else 
			BEEP:C151
		End if 
End case 
