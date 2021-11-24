Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_TEXT:C284($intro;$remainingTime)
		C_LONGINT:C283($delta)
		
		$intro:="You can get a valid licence number by transfer directly on our bank account number:\n\n"
		$intro:=$intro+"IBAN: FR76 1009 6180 9500 0602 7800 138       BIC: CMCIFRPP\n\n"
		$intro:=$intro+"You can also pay by check sent to our postal address (French checks only).\n"
		$intro:=$intro+"You will receive your activation code by email as soon as we notice the payment.\n"
		$intro:=$intro+"PS: we need user name and mail information to create your activation code.\n"
		$intro:=$intro+"More information is available on our website or by mail at info@association-qualisoft.eu"
		
		If (Form:C1466.demo)
			$delta:=Date:C102(Form:C1466.end)-Current date:C33
			$remainingTime:="Still "+String:C10($delta)+" remaining  days to evaluate QS_Toolbox."
		End if 
		
		OBJECT SET TITLE:C194(*;"txtValidUntil";$intro)
		OBJECT SET TITLE:C194(*;"remainingTime";$remainingTime)
		
End case 