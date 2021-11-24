$evt:=Form event code:C388
Case of 
	: ($Evt=Sur chargement:K2:1)
		RadRemplace:=1
		OBJECT SET VISIBLE:C603(*; "Bouton radio@"; Not:C34(BoolRemplace))
End case 