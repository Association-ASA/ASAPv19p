Case of 
	: (VarImageFleche=0)
		SensFleche:="Flèche à droite"
		
	: (VarImageFleche=1)
		SensFleche:="Flèche en bas"
		
	: (VarImageFleche=2)
		SensFleche:="Flèche à gauche"
		
	: (VarImageFleche=3)
		SensFleche:="Flèche en haut"
End case 
$NomFleche:=String:C10(VarImageFleche+1)+"1"
//PtChampCourant:=Pointeur vers("VarC"+$NomFleche)
//OBJET FIXER SAISISSABLE(PtChampCourant->;(CaseSaisie=1))