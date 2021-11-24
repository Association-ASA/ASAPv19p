$Evt:=Form event code:C388
Case of 
	: ($Evt=Sur impression corps:K2:18)
		
		Case of 
			: (ContexteImpression="Ventes")
				SET PRINT MARKER:C709(Entête formulaire:K43:3; 303)
				OBJECT GET COORDINATES:C663(*; "ChampIntitule"; $G; $H; $D; $B)
				OBJECT GET BEST SIZE:C717(*; "ChampIntitule"; $LargeOpt; $HautOpt; $D-$G)
				If ($HautOpt<20)  // il tient sur une ligne
					SET PRINT MARKER:C709(Corps formulaire:K43:1; 323)
				Else 
					$Hauteur:=$H+$HautOpt+2
					OBJECT SET COORDINATES:C1248(*; "ChampIntitule"; $G; $H; $D; $Hauteur)
					SET PRINT MARKER:C709(Corps formulaire:K43:1; $Hauteur)
				End if 
		End case 
		ContexteImpression:=""
		
		// OBJET FIXER VISIBLE(*;"Etran@";$Et)
		
	: ($Evt=Sur impression corps:K2:18)
		//OBJET FIXER FORMATAGE([Factures]TotalHT;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTVA;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTTC;<>PermEnE)
		//OBJET FIXER FORMATAGE(VarTFF;<>PermEnF)
		
End case 