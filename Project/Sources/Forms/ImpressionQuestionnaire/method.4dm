C_LONGINT:C283($G;$H;$D;$B;$LargeOpti;$HautOpti)

If (Form event code:C388=Sur impression corps:K2:18)
	Case of 
		: (VarContexteImpression="ImpQuestion")
			SET PRINT MARKER:C709(Entête formulaire:K43:3;100)
			OBJECT GET COORDINATES:C663(*;"VarQuestion";$G;$H;$D;$B)
			OBJECT GET BEST SIZE:C717(*;"VarQuestion";$LargeOpti;$HautOpti;$D-$G)
			If ($HautOpti<20)  // La question ne tient pas sur une ligne
				$Hauteur:=$H+24
			Else 
				$Hauteur:=$H+$HautOpti+5
				OBJECT SET COORDINATES:C1248(*;"VarQuestion";$G;$H;$D;$Hauteur)
			End if 
			SET PRINT MARKER:C709(Corps formulaire:K43:1;$Hauteur)
			
		: (VarContexteImpression="ImpRéponse")
			OBJECT GET COORDINATES:C663(*;"VarRéponse";$G;$H;$D;$B)
			SET PRINT MARKER:C709(Entête formulaire:K43:3;$H-1)
			OBJECT GET BEST SIZE:C717(*;"VarRéponse";$LargeOpti;$HautOpti;$D-$G)
			If ($HautOpti<20)  // La réponse ne tient pas sur une ligne
				$Hauteur:=$B
			Else 
				$Hauteur:=$H+$HautOpti
				OBJECT SET COORDINATES:C1248(*;"VarRéponse";$G;$H;$D;$Hauteur)
			End if 
			SET PRINT MARKER:C709(Corps formulaire:K43:1;$Hauteur)
			
			
		: (VarContexteImpression="ImpArgumentaire")
			VarRéponse:=""
			OBJECT GET COORDINATES:C663(*;"VarArgumentaire";$G;$H;$D;$B)
			SET PRINT MARKER:C709(Entête formulaire:K43:3;$H-1)
			OBJECT GET BEST SIZE:C717(*;"VarArgumentaire";$LargeOpti;$HautOpti;$D-$G)
			If ($HautOpti<20)  // L'argumentaire ne tient pas sur une ligne
				$Hauteur:=$B+3
			Else 
				$Hauteur:=$H+$HautOpti+3
				OBJECT SET COORDINATES:C1248(*;"VarArgumentaire";$G;$H;$D;$Hauteur)
			End if 
			SET PRINT MARKER:C709(Corps formulaire:K43:1;$Hauteur)
			
			
			
	End case 
	VarContexteImpression:=""
End if 