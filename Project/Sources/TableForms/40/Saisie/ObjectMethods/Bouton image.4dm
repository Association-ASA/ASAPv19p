
CONFIRM:C162("Voulez-vous supprimer cette photo (la n°"+String:C10([Diapositives:40]NumOrdreDiapos:1)+") ???")
If (OK=1)
	CONFIRM:C162("Voulez-vous VRAIMENT supprimer cette photo (la n°"+String:C10([Diapositives:40]NumOrdreDiapos:1)+") ???")
	If (OK=1)
		If (Application type:C494=4D mode distant:K5:5)
			$prc:=Execute on server:C373("Ad3SupprimePhoto";0;"SupPhoto";[Diapositives:40]NumOrdreDiapos:1)
		End if 
	End if 
	
End if 