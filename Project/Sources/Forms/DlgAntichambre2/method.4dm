
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		C_LONGINT:C283($Salé; $FT; $L)
		// PAGE 1
		// création du menu local des auteurs
		LIST TO ARRAY:C288("Auteurs"; PUMAuteurAC)
		SORT ARRAY:C229(PUMAuteurAC; >)
		APPEND TO ARRAY:C911(PUMAuteurAC; "-")
		APPEND TO ARRAY:C911(PUMAuteurAC; "Autre")
		// Initialisation des variables du dialogue
		DiaAC2Init
		
		
		// Liste des [XDonnees] = photos candidates en attente
		
		DiaAC2AfficheCandidates
		
		// PAGE 2
		VarMotsClefs:=""
		
		ARRAY LONGINT:C221(TbNumDAF; 0)
		ARRAY LONGINT:C221(TbNumDF; 0)
		Bas:=800
		Varimage:=VarImageVide
		VarOrientation:=""
		VarTaillePhoto:=""
		LesFlechesSontLà:=False:C215
		LesOrientationsSontLà:=False:C215
		ARRAY TEXT:C222(TbTb; 0)
		ARRAY TEXT:C222(TbLHT; 0)
		ARRAY TEXT:C222(TbTb; 8)
		ARRAY TEXT:C222(TbLHT; 8)
		ARRAY TEXT:C222(TbO; 0)
		ARRAY TEXT:C222(TbO; 8)
		ARRAY INTEGER:C220(TbTCa; 0)
		ARRAY INTEGER:C220(TbTCa; 8)
		LeMotClé:=""
		VarC11:=""
		VarC21:=""
		VarC31:=""
		VarC41:=""
		VarC11A:=""
		VarC21A:=""
		VarC31A:=""
		VarC41A:=""
		VarAfficheTriplette:=""
		VarDesType:=""
		VarImageFleche:=0
		ARRAY TEXT:C222(TbTb; 0)
		ARRAY TEXT:C222(TbTb; 4)
		OBJECT GET COORDINATES:C663(VarImage; GaucheInitial; HautInitial; DroiteInitial; BasInitial)
		ZViderSelectionCourante(->[Diapositives:40])
End case 
