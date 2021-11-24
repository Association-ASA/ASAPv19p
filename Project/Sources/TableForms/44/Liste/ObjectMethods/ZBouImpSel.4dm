$evt:=Form event code:C388
Case of 
	: ($Evt=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(Self:C308->;ZImprimer)
		
	: ($Evt=Sur clic:K2:4)
		ZImprimeSel 
End case 
