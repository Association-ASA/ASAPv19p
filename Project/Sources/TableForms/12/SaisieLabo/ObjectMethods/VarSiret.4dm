$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		If (VarSiret="")
			OB REMOVE:C1226([Personnes:12]Arguments:7; "NumSiretLabo")
		Else 
			OB SET:C1220([Personnes:12]Arguments:7; "NumSiretLabo"; VarSiret)
		End if 
		
End case 
