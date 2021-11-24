$evt:=Form event code:C388
Case of 
		
	: ($evt=Sur données modifiées:K2:15)
		TbPrixHT{TbQuantite}:=TbPrixUHT{TbQuantite}*TbQuantite{TbQuantite}
		TbPrixTTC{TbQuantite}:=TbPrixHT{TbPrestation}*(1+(TbTauxTVA{TbPrestation}/100))
		FactureMiseAJourTotaux
End case 
