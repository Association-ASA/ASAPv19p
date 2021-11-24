$evt:=Form event code:C388
If ($evt=Sur chargement:K2:1)
	C_TEXT:C284(VarCode)
	VarCode:=""
	<>ZCR:=Char:C90(13)
	QUERY:C277([DiaData:45]; [DiaData:45]XNom:1="IVC"; *)
	QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="IVC")
	NJ:=[DiaData:45]XDate:3-!2009-06-03!
	OBJECT SET VISIBLE:C603(BouSS; Macintosh command down:C546)
	
	//Si (<>Provisoire)  // il a une version étudiante qui va bientôt s'arrêter
	//Si (<>FinValidité)
	//VarStatutEnr:="ATTENTION : LA PERIODE D'AUTORISATION EST TERMINEE"+<>ZCR
	//VarStatutEnr:=VarStatutEnr+"Veuillez vous ré-enregistrer immédiatement auprès de l'ASA, SVP..."
	//Sinon 
	//VarStatutEnr:="ATTENTION : LA PERIODE D'AUTORISATION SE TERMINE d'ICI "+Chaîne(90-(Date du jour-[DiaData]XDate))+" j."+<>ZCR
	//VarStatutEnr:=VarStatutEnr+"Veuillez vous ré-enregistrer au plus vite auprès de l'ASA, SVP..."
	//Fin de si 
	//Fin de si 
	
	//Si (<>TVB)
	FORM GOTO PAGE:C247(1)
	//Sinon 
	//FORM ALLER À PAGE(4)
	//Fin de si 
	OBJECT SET VISIBLE:C603(VarPlusJamaisCa; ([DiaData:45]XValeur:4#0))
	VarPlusJamaisCa:=Num:C11([DiaData:45]XBool:9)
	ARRAY TEXT:C222(TbNomsAuteurs; 19)
	TbNomsAuteurs{1}:="Laetitia AUBRY"
	TbNomsAuteurs{2}:="Jean-Christophe AUGUSTIN"
	TbNomsAuteurs{3}:="Jean-Denis BAILLY"
	TbNomsAuteurs{4}:="François-Henry  BOLNOT"
	TbNomsAuteurs{5}:="Laurine BOUTEILLER"
	TbNomsAuteurs{6}:="Hubert BRUGERE"
	TbNomsAuteurs{7}:="Jean-Michel CAPPELIER"
	TbNomsAuteurs{8}:="Vincent CARLIER"
	TbNomsAuteurs{9}:="Michèle CHEVALIER"
	TbNomsAuteurs{10}:="Pierre DEMONT"
	TbNomsAuteurs{11}:="André DENECKERE"
	TbNomsAuteurs{12}:="Alain GONTHIER"
	TbNomsAuteurs{13}:="Claude GRANDMONTAGNE"
	TbNomsAuteurs{14}:="Michel MAS"
	TbNomsAuteurs{15}:="Gilles QUINET"
	TbNomsAuteurs{16}:="Patrick RONJON"
	TbNomsAuteurs{17}:="Claude SERY"
	TbNomsAuteurs{18}:="Pierre TASSIN"
	TbNomsAuteurs{19}:="Sylvie VAREILLE"
End if 
