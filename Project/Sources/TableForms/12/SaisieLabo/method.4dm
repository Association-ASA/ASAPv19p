
$evt:=Form event code:C388
[Personnes:12]UUID:1:=[Personnes:12]UUID:1
Case of 
	: ($evt=Sur chargement:K2:1)
		ASAPSurChargementSaisieLabo
		
		
		
	: ($evt=Sur validation:K2:3)
		ASAPSurValidationSaisieLabo
		//CRÉER SELECTION SUR TABLEAU([Personnes];TbNumEnr)
		//ASAPPerFabriqueTb 
		
	: ($evt=Sur libération:K2:2)
		UNLOAD RECORD:C212([Personnes:12])
End case 