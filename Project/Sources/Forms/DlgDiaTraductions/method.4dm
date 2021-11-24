
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		
		C_LONGINT:C283(VarNbLignes)
		
		ARRAY TEXT:C222(PUMTraduc;5)
		PUMTraduc{1}:="Nom de la lésion"
		PUMTraduc{2}:="Description de la lésion"
		PUMTraduc{3}:="Fiche réflexe de la lésion"
		PUMTraduc{4}:="Diapositives"
		PUMTraduc{5}:="Textes"
		PUMTraduc:=0
		
		ARRAY TEXT:C222(Colonne1;0)
		ARRAY TEXT:C222(Colonne2;0)
		ARRAY LONGINT:C221(Colonne3N;0)
		VarTestF:=""
		
		ARRAY LONGINT:C221(PUMTaille;5)
		PUMTaille{1}:=1
		PUMTaille{2}:=2
		PUMTaille{3}:=3
		PUMTaille{4}:=4
		PUMTaille{5}:=5
		PUMTaille:=1
		
		  // Ad3FabriqueTbTraduc 
		ARRAY BOOLEAN:C223(TbLignesMasque;0)
		
		VarNbLignes:=0
		VarNbSouligne:=0
		OBJECT SET VISIBLE:C603(*;"tradtext@";PUMTraduc=5)
End case 
