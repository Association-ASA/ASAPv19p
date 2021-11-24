$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		TbPrixTTC{TbPrestation}:=TbPrixHT{TbPrestation}*(1+(TbTauxTVA{TbPrestation}/100))
		FactureMiseAJourTotaux 
End case 