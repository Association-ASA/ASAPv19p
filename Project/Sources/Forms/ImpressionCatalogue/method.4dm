
$evt:=Form event code:C388
Case of 
	: ($evt=Sur impression corps:K2:18)
		
		Case of 
			: (ContexteImpression="CadreMoins")
				OBJECT SET VISIBLE:C603(*; "CadrePlus"; False:C215)
				OBJECT SET VISIBLE:C603(*; "CadreMoins"; True:C214)
				
				
			: (ContexteImpression="CadrePlus")
				OBJECT SET VISIBLE:C603(*; "CadrePlus"; True:C214)
				OBJECT SET VISIBLE:C603(*; "CadreMoins"; False:C215)
				
		End case 
		ContexteImpression:=""
End case 
