
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		DiaSuiviConnexions 
		PUMTypeAsaDia:=1
		VarDateDeb:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)-1))
		VarDateFin:=Date:C102("31/12/"+String:C10(Year of:C25(Current date:C33)-1))
		
End case 
