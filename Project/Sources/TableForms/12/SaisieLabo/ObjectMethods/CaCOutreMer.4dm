$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (CaCOutreMer=1)
			OB SET:C1220([Personnes:12]Arguments:7; "FacturationPays"; "Outre Mer")
		Else 
			OB REMOVE:C1226([Personnes:12]Arguments:7; "FacturationPays")
		End if 
End case 
