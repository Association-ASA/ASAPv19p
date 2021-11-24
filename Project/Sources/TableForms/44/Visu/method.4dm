$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		GET WINDOW RECT:C443(FGauche;FHaut;FDroite;FBas)
		QUERY:C277([Diapositives:40];[Diapositives:40]NomLesion:4=[DiaLesions:44]NomLesion:1)
		  //NOMMER ENSEMBLE([Diapositives];"Exemples")
		  //OBJET FIXER VISIBLE(BouImagesMotif;(Enregistrements trouvés([Diapositives])>0))
		If ([DiaLesions:44]NomLesion:1="")
			[DiaLesions:44]NouvelleDefinition:14:=True:C214
			OBJECT SET ENTERABLE:C238([DiaLesions:44]NomLesion:1;True:C214)
		Else 
			OBJECT SET ENTERABLE:C238([DiaLesions:44]NomLesion:1;False:C215)
		End if 
		ModifLes:=([DiaLesions:44]NouvelleDefinition:14 | <>PermConcepteur)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]GrandTypeLesionnel:2;False:C215)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]TypeLesionnelPrecis:3;False:C215)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]DescriptionTypeMicro:5;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]DescriptionTypeMacro:4;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]Etiologie:6;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]MotifSaisie:7;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]JustificationConduite:8;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]NPC:9;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]FicheReflexe:12;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]Frequence:11;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]LesionsApparentees:10;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]ReferenceReglementaireFr:13;ModifLes)
		OBJECT SET ENTERABLE:C238([DiaLesions:44]NouvelleDefinition:14;ModifLes)
		OBJECT SET VISIBLE:C603(*;"cgm@";ModifLes)
		OBJECT SET VISIBLE:C603(*;"visu@";Not:C34(ModifLes))
		C_LONGINT:C283(LTL)
		LIST TO ARRAY:C288("JustificationConduite";PUMJC)
		LIST TO ARRAY:C288("Fréquence";PUMFr)
		LTL:=Load list:C383("TypeLésion")
		  // plaçons le PUM Hiérarchique sur la valeur choisie
		Case of 
			: ([DiaLesions:44]GrandTypeLesionnel:2="")
				SELECT LIST ITEMS BY POSITION:C381(LTL;0)
			: ([DiaLesions:44]GrandTypeLesionnel:2=[DiaLesions:44]TypeLesionnelPrecis:3)
				SELECT LIST ITEMS BY POSITION:C381(LTL;1)
			Else 
				  //Boucle ($salé;1;6)
				  //INFORMATION ELEMENT(LTL;$Salé;NumElément;TextElément;RefSousListe)
				  //Si (TextElément="") | ([Lésions]GrandTypeLésionnel=TextElément)
				  //Boucle ($fumé;1;1000)
				  //INFORMATION ELEMENT(RefSousListe;$fumé;NumSElément;TextSElément)
				  //Si ([Lésions]TypeLésionnelPrécis=TextSElément)
				  //$fumé:=1000
				  //Fin de si 
				  //Fin de boucle 
				  //$salé:=6
				  //Fin de si 
				  //Fin de boucle 
				  //SELECTIONNER ELEMENTS PAR REFERENCE(LTL;NumSElément)
		End case 
		ARRAY TEXT:C222(ZdDNL;0)
		ARRAY TEXT:C222(ZdDNLR;0)
		$NPC:=[DiaLesions:44]NPC:9
		$Rang:=Position:C15(<>ZCR;$NPC)
		While ($Rang>0)
			ZAjoutLigne (->ZdDNLR;Substring:C12($NPC;1;$Rang-1))
			$NPC:=Substring:C12($NPC;$Rang+1;10000)
			$Rang:=Position:C15(<>ZCR;$NPC)
		End while 
		VarSaisieNomLésion:=""
		FORM GOTO PAGE:C247(1)
		
	: ($evt=Sur redimensionnement:K2:27)  // Sur validation
		SET WINDOW RECT:C444(FGauche;FHaut;FDroite;FBas)
		
End case 