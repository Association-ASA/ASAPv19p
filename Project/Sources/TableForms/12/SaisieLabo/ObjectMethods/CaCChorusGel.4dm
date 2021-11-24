$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (CaCChorusGel=1)
			OB SET:C1220([Personnes:12]Arguments:7; "FactureDansChorusGel"; "Vrai")
		Else 
			OB REMOVE:C1226([Personnes:12]Arguments:7; "FactureDansChorusGel")
		End if 
End case 
