CONFIRM:C162("Désirez-vous modifier le commentaire ????"; "Oui c'est bien ça"; "Mais, non")
If (OK=1)
	[Diapositives:40]Commentaires:7:=VarComDia
	SAVE RECORD:C53([Diapositives:40])
End if 