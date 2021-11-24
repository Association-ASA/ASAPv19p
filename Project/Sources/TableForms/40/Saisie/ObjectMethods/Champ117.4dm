If (Find in array:C230(PUMAuteur; [Diapositives:40]Auteur:10)=-1)
	CONFIRM:C162("Voulez-vous mettre "+[Diapositives:40]Auteur:10+" dans le menu local ???")
	If (OK=1)
		APPEND TO ARRAY:C911(PUMAuteur; [Diapositives:40]Auteur:10)
		SORT ARRAY:C229(PUMAuteur; >)
		ARRAY TO LIST:C287(PUMAuteur; "Auteurs")
	End if 
End if 