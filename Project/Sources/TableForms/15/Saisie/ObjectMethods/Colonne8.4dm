If (Form event code:C388=Sur gain focus:K2:7)
	QUERY:C277([Prestations:26];[Prestations:26]AnneePrestation:6=Year of:C25(Current date:C33))
	SELECTION TO ARRAY:C260([Prestations:26]NomPrestation:3;$TbNomPrest\
		;[Prestations:26]TauxTVAPrestation:5;$TbTVA\
		;[Prestations:26]PrixPrestation:4;$TbPrix)
	$Menu:=ZTableauVersTexte (->$TbNomPrest;";")
	$LigneChoisie:=Pop up menu:C542($Menu)
	$PrestationChoisie:=$TbNomPrest{$LigneChoisie}
	[Ventes:16]PrixUHT:5:=$TbPrix{$LigneChoisie}
	[Ventes:16]TauxTVA:8:=$TbTVA{$LigneChoisie}
	  // Recalcul de la ligne
	[Ventes:16]PrixTotalHT:7:=[Ventes:16]PrixUHT:5*[Ventes:16]Quantité:6
	REDRAW:C174(ListBoxVentes)
End if 