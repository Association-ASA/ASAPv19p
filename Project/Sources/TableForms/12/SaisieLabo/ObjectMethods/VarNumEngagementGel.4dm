$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		If (VarNumEngagementGel="")
			OB REMOVE:C1226([Personnes:12]Arguments:7;"NumEngagementCHORUSGel")
		Else 
			OB SET:C1220([Personnes:12]Arguments:7;"NumEngagementCHORUSGel";VarNumEngagementGel)
			OB SET:C1220([Personnes:12]Arguments:7;"FactureDansChorusGel";"Vrai")
			CaCChorusGel:=1
		End if 
		
End case 
