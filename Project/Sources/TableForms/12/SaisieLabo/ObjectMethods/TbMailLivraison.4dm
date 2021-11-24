$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		$Compteur:=0
		$TT:=Size of array:C274(TbMailLivraison)
		For ($Salé; 1; $TT)
			If (TbMailLivraison{$Salé}=True:C214)
				$Compteur:=$Compteur+1
			End if 
		End for 
		If ($Compteur>1)
			ALERT:C41("Vous ne pouvez saisir qu'une seule adresse de livraison")
			For ($Salé; 1; $TT)
				If (TbMailLivraison{$Salé}=True:C214)
					TbMailLivraison{$Salé}:=False:C215
				End if 
			End for 
		End if 
End case 
