$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		If (JAiGrandit)
			OBJECT MOVE:C664(VarImage;PG;PH;PD;PB;*)
		End if 
		JAiGrandit:=False:C215
		$CDNomImage:=<>PermCheDossierAsaDiaWeb+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
		READ PICTURE FILE:C678($CDNomImage;VarImage)
		SET WINDOW TITLE:C213("Diapositives: enregistrement n°"+String:C10(Selected record number:C246([Diapositives:40]))+" sur "+String:C10(Records in selection:C76([Diapositives:40])))
		VarTypeLesionnel:=[Diapositives:40]GrandTypeLesionnel:5+" : "+[Diapositives:40]TypeLesionnelPrecis:6
		If (<>Boss)
			QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]LesionsLiees:12="@"+[Diapositives:40]NomLesion:4+"@")
			ARRAY TEXT:C222(PUMMotifSaisie;0)
			SELECTION TO ARRAY:C260([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;PUMMotifSaisie)
			OBJECT SET VISIBLE:C603(PUMMotifSaisie;<>Boss)
		End if 
		VarTriplette:=DiaAfficheTripletteSlash 
		VarLesRes:=Replace string:C233([Diapositives:40]NPC:14;<>ZCR;", ")
		QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
		VarFR:=[DiaLesions:44]FicheReflexe:12
		PICTURE PROPERTIES:C457(VarImage;$L;$H)
		FORM GOTO PAGE:C247(1+Num:C11($L<$H))
		
	: ($evt=Sur libération:K2:2)
		DiaFenetreActualiseTitre 
End case 