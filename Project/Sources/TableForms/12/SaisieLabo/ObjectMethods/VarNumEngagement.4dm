$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		If (VarNumEngagement="")
			OB REMOVE:C1226([Personnes:12]Arguments:7;"NumEngagementCHORUS")
		Else 
			OB SET:C1220([Personnes:12]Arguments:7;"NumEngagementCHORUS";VarNumEngagement)
			OB SET:C1220([Personnes:12]Arguments:7;"FactureDansChorus";"Vrai")
			CaCChorus:=1
		End if 
		
End case 
