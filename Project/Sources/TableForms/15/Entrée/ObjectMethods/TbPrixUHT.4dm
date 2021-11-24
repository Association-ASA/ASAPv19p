$evt:=Form event code:C388
If ($evt=Sur données modifiées:K2:15)
	TbQuantite{TbPrestation}:=1
	TbPrixHT{TbPrestation}:=TbPrixUHT{TbPrestation}
	TbTauxTVA{TbPrestation}:=20
	TbPrixTTC{TbPrestation}:=TbPrixHT{TbPrestation}*(1+(TbTauxTVA{TbPrestation}/100))
	FactureMiseAJourTotaux 
End if 