CONFIRM:C162("Désirez-vous enregistrer cette diapositive sans commentaire ????"; "Oui c'est bien ça"; "Mais, non")
If (OK=1)
	[Diapositives:40]DiapoCommentaire:26:=True:C214
	SAVE RECORD:C53([Diapositives:40])
End if 