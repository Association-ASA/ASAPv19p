$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY TEXT:C222(PUMChoix;4)
		PUMChoix{1}:="Tous"
		PUMChoix{2}:="Absence"
		PUMChoix{3}:="En cours"
		PUMChoix{4}:="Reçue"
		PUMChoix:=1
		
	: ($evt=Sur données modifiées:K2:15)
		$FT:=Size of array:C274(TbParticipantA)
		Case of 
			: (PUMChoix=1)  // Tous
				  // UTILISER ENSEMBLE("Concernées")
				For ($Salé;1;$FT)
					TbLignesCachées{$Salé}:=False:C215
				End for 
				
				
			: (PUMChoix=2)  // Absence
				  //UTILISER ENSEMBLE("Absence")
				For ($Salé;1;$FT)
					TbLignesCachées{$Salé}:=(Not:C34(TbCouleurFond{$Salé}=VarCouleurAbsent))
				End for 
				
			: (PUMChoix=3)  // En cours
				  //UTILISER ENSEMBLE("Encours")
				For ($Salé;1;$FT)
					TbLignesCachées{$Salé}:=(Not:C34(TbCouleurFond{$Salé}=VarCouleurEnCours))
				End for 
			: (PUMChoix=4)  // Réponse reçue
				  //UTILISER ENSEMBLE("Envoyé")
				For ($Salé;1;$FT)
					TbLignesCachées{$Salé}:=(Not:C34(TbCouleurFond{$Salé}=VarCouleurRecu))
				End for 
		End case 
		  // RaemaSuiviAfficheTbChoix 
		
End case 
