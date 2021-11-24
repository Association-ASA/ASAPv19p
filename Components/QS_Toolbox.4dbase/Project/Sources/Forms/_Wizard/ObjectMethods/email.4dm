C_TEXT:C284($email)

Case of 
		
	: (Form event code:C388=On Losing Focus:K2:8)
		$email:=Form:C1466.email
		$email:=Lowercase:C14($email)
		
		If ((Not:C34(zfCheckEmail ($email)) & ($email#"")))
			ALERT:C41("Unvalid email format.\nPlease, correct it before moving forward.")
			GOTO OBJECT:C206(*;"email")
		End if 
		Form:C1466.email:=$email
End case 