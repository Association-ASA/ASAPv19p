If (PUMAuteurAC=Size of array:C274(PUMAuteurAC))  // Autre
	$Dem:=Request:C163("Et quel nouvel auteur, SVP...")
	If (OK=1) & ($dem#"")
		CONFIRM:C162("Ajouter l'auteur "+$Dem+"????")
		If (OK=1)
			$TT:=Size of array:C274(PUMAuteurAC)
			$Ligne:=$TT-1
			INSERT IN ARRAY:C227(PUMAuteurAC;$Ligne)
			PUMAuteurAC{$Ligne}:=$Dem
			DELETE FROM ARRAY:C228(PUMAuteurAC;($Ligne+1);2)
			SORT ARRAY:C229(PUMAuteurAC;>)
			ARRAY TO LIST:C287(PUMAuteurAC;"Auteurs")
			APPEND TO ARRAY:C911(PUMAuteurAC;"-")
			APPEND TO ARRAY:C911(PUMAuteurAC;"Autre")
		End if 
	Else 
		PUMAuteurAC:=0
	End if 
	
End if 