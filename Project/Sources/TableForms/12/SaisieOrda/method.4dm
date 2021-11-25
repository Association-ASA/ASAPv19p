
$evt:=Form event code:C388
[Personnes:12]UUID:1:=[Personnes:12]UUID:1
Case of 
	: ($evt=On Load:K2:1)
		ASAPSurChargementSaisieLabo
		
		If (Form:C1466.visiteurOne)
			OBJECT SET ENABLED:C1123(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "bCancel"; True:C214)
			OBJECT SET ENABLED:C1123(*; "bouP@"; True:C214)
		End if 
		
	: ($evt=On Validate:K2:3)
		ASAPSurValidationSaisieLabo
		//CRÉER SELECTION SUR TABLEAU([Personnes];TbNumEnr)
		//ASAPPerFabriqueTb 
		
	: ($evt=On Unload:K2:2)
		UNLOAD RECORD:C212([Personnes:12])
End case 