If (Find in array:C230(PUMAuteur; [Diapositives:40]Auteur:10)=-1)
	CONFIRM:C162("Voulez-vous mettre "+[Diapositives:40]Auteur:10+" dans le menu local ???")
	If (OK=1)
		ZAjoutLigne(->PUMAuteur; [Diapositives:40]Auteur:10)
	End if 
End if 