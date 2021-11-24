
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		_O_DISABLE BUTTON:C193(ZBouChoix)
		
		
	: ($evt=Sur clic:K2:4)
		$FT:=Records in set:C195("UserSet")
		Case of 
			: ($FT=0)
				_O_DISABLE BUTTON:C193(ZBouChoix)
				
			: ($FT=1)
				_O_ENABLE BUTTON:C192(ZBouChoix)
				OBJECT SET TITLE:C194(ZBouChoix;"Détruire le panier sélectionné")
				
			Else 
				_O_ENABLE BUTTON:C192(ZBouChoix)
				OBJECT SET TITLE:C194(ZBouChoix;"Détruire les "+String:C10($FT)+" paniers sélectionnés")
		End case 
End case 

