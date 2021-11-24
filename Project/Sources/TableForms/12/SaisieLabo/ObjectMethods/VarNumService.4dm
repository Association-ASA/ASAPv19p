$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		If (VarNumService="")
			OB REMOVE:C1226([Personnes:12]Arguments:7;"NumServiceCHORUS")
		Else 
			OB SET:C1220([Personnes:12]Arguments:7;"NumServiceCHORUS";VarNumService)
			OB SET:C1220([Personnes:12]Arguments:7;"FactureDansChorus";"Vrai")
			CaCChorus:=1
		End if 
		
End case 
