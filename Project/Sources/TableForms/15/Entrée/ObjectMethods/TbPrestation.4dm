$evt:=Form event code:C388
Case of 
	: ($evt=Sur après frappe clavier:K2:26)
		$Texte:=Get edited text:C655+"@"
		QUERY:C277([Prestations:26];[Prestations:26]AnneePrestation:6=VarAnnée;*)
		QUERY:C277([Prestations:26]; & ;[Prestations:26]NomPrestation:3=$Texte)
		SELECTION TO ARRAY:C260([Prestations:26]NomPrestation:3;$TbPrestationEnCours)
		TbPrestation{TbPrestation}:=YSaisieAssiste (->$TbPrestationEnCours;1;False:C215;1)
		
		QUERY:C277([Prestations:26];[Prestations:26]AnneePrestation:6=VarAnnée;*)
		QUERY:C277([Prestations:26]; & ;[Prestations:26]NomPrestation:3=TbPrestation{TbPrestation})
		If (CaseAdilva=1)
			TbPrixUHT{TbPrestation}:=[Prestations:26]PrixPrestation:4*(90/100)
		Else 
			TbPrixUHT{TbPrestation}:=[Prestations:26]PrixPrestation:4
		End if 
		TbPrixHT{TbPrestation}:=TbPrixUHT{TbPrestation}
		TbQuantite{TbPrestation}:=1
		TbTauxTVA{TbPrestation}:=[Prestations:26]TauxTVAPrestation:5
		TbPrixTTC{TbPrestation}:=TbPrixHT{TbPrestation}*(1+([Prestations:26]TauxTVAPrestation:5/100))
		TbCodePresta{TbPrestation}:=[Prestations:26]CodePrestation:2
		FactureMiseAJourTotaux 
End case 