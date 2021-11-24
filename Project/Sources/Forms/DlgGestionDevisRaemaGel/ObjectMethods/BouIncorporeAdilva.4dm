If (False:C215)
	
	C_LONGINT:C283($Salé; $FT)
	$FT:=Size of array:C274(Colonne1)
	//TABLEAU TEXTE(TbNomsGermes;0)
	//TOUT SÉLECTIONNER([CampagneGelGermes])
	//VALEURS DISTINCTES([CampagneGelGermes]NomDuGerme;TbNomsGermes)
	//TRIER TABLEAU(TbNomsGermes;>)
	//TABLEAU ENTIER LONG(TbOrdre;Taille tableau(TbNomsGermes))
	//TbOrdre{1}:=30
	//TbOrdre{2}:=10
	//TbOrdre{3}:=50
	//TbOrdre{4}:=40
	//TbOrdre{5}:=20
	//TRIER TABLEAU(TbOrdre;TbNomsGermes;>)
	COPY ARRAY:C226(<>TbNomGermeSchémaGEL; TbNomsGermes)
	ARRAY TEXT:C222(TbPeriodeGel; 2)
	TbPeriodeGel{1}:="Mai"
	TbPeriodeGel{2}:="Décembre"
	
	
	// TABLEAU DES [CampagneGelGermes] à remplir
	ARRAY LONGINT:C221(TbAnCampagne; 0)
	ARRAY LONGINT:C221(TbNbrePotAvecRapport; 0)
	ARRAY LONGINT:C221(TbNbrePotSansRapport; 0)
	ARRAY TEXT:C222(TbNomDuGermee; 0)
	ARRAY TEXT:C222(TbUUIDPersonne; 0)
	ARRAY TEXT:C222(TbPeriode; 0)
	$Année:=Year of:C25(Current date:C33)
	$NumRaemaMai:=RaemaTrouveNumCampagneParAn($Année; 2)
	$NumRaemaDécembre:=RaemaTrouveNumCampagneParAn($Année; 4)
	
	For ($Salé; 1; $FT)
		// $NumRaemaCourant:=ColRGA1{$Salé}  // le n° RAEMA du laboratoire
		$UUIDPersonne:=ASAPTrouveUUIDLaboParNumero(Num:C11(ColRGA1{$Salé}))
		QUERY:C277([Personnes:12]; [Personnes:12]UUID:1=$UUIDPersonne)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMai)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembre; *)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUIDPersonne:2=$UUIDPersonne)
		
		If (GA15AdilvaGelOK)
			READ WRITE:C146([CampagneGelGermes:25])
			QUERY:C277([CampagneGelGermes:25]; [CampagneGelGermes:25]NumCampagne:6=$NumRaemaMai; *)
			QUERY:C277([CampagneGelGermes:25];  | [CampagneGelGermes:25]NumCampagne:6=$NumRaemaDécembre; *)
			QUERY:C277([CampagneGelGermes:25];  & [CampagneGelGermes:25]UUIDParticipation:2=[CampagneParticipations:17]UUID:1)
			DELETE SELECTION:C66([CampagneGelGermes:25])
			
			For ($Fumé; 1; 10)  // pour les 2x 5 germes de l'année
				$CompteurPeriode:=7+(Num:C11($Fumé>5)*15)
				$NumPériode:=1+Num:C11($Fumé>5)
				$Incrémentation:=$Fumé-(Num:C11($Fumé>5)*5)
				$Pt:=Get pointer:C304("ColRGA"+String:C10($CompteurPeriode+$Incrémentation))
				$NbEnvoi:=Num:C11($Pt->{$Salé})  // envoi principal
				$Pt:=Get pointer:C304("ColRGA"+String:C10($CompteurPeriode+$Incrémentation+5))
				$NbAvec:=Num:C11($Pt->{$Salé})  // avec rapport
				$Pt:=Get pointer:C304("ColRGA"+String:C10($CompteurPeriode+$Incrémentation+10))
				$NbSans:=Num:C11($Pt->{$Salé})  // sans rapport
				
				If ($NbEnvoi>0)
					//AJOUTER À TABLEAU(TbAnCampagne;VarPermMilleRaemaGel)
					APPEND TO ARRAY:C911(TbNbrePotAvecRapport; $NbAvec)
					APPEND TO ARRAY:C911(TbNbrePotSansRapport; $NbSans)
					APPEND TO ARRAY:C911(TbNomDuGermee; TbNomsGermes{$Incrémentation})
					APPEND TO ARRAY:C911(TbUUIDPersonne; $UUIDPersonne)
					APPEND TO ARRAY:C911(TbPeriode; $NumRaemaMai)
					If ($NbEnvoi>1)
						TbNbrePotSansRapport{Size of array:C274(TbNbrePotSansRapport)}:=TbNbrePotSansRapport{Size of array:C274(TbNbrePotSansRapport)}+($NbEnvoi-1)
					End if 
				Else 
					If (($NbAvec+$NbSans)>0)
						ALERT:C41("Des pot supplémentaires sont demandés sans qu'il y ait de d'envoi principal...")
					End if 
				End if 
			End for 
		End if 
		
	End for 
	//TABLEAU VERS SÉLECTION(TbAnCampagne;[CampagneGelGermes]AnCampagne\
						;TbNbrePotAvecRapport;[CampagneGelGermes]NbrePotAvecRapport\
						;TbNbrePotSansRapport;[CampagneGelGermes]NbrePotSansRapport\
						;TbNomDuGermee;[CampagneGelGermes]NomDuGerme\
						;TbUUIDPersonne;[CampagneGelGermes]NumRaema\
						;TbPeriode;[CampagneGelGermes]Periode)
	
	GA15RaemaGelActualiseLoto
	
	
	// DONNEES héritées du fichier de l'ADILVA
	//ColRGA1;Colonne1  = N° RAEMA
	//ColRGA2 = N° de département
	//ColRGA3 = Nom département
	//ColRGA4 = CP + localité
	//ColRGA5 = Nom Directeur
	//ColRGA6 = Mail directeur
	//ColRGA7 = Téléphone
	// COMMANDE INITIALE de MAI
	//ColRGA8;Colonne2 =  Bacillus Mai
	//ColRGA9;Colonne3 = Pseudo Mai
	//ColRGA10;Colonne4 = Lactiques Mai
	//ColRGA11;Colonne5 = LM Ens Mai
	//ColRGA12;Colonne6 /= LM Sep Mai
	
	// Pots sup AVEC COFRAC
	//ColRGA13 =  Bacillus 
	//ColRGA14 = Pseudo
	//ColRGA15 = Lactiques
	//ColRGA16 = LM Ens
	//ColRGA17 = LM Sep
	
	// Pots sup SANS COFRAC
	//ColRGA18 =  Bacillus 
	//ColRGA19 = Pseudo
	//ColRGA20 = Lactiques
	//ColRGA21 = LM Ens
	//ColRGA22 = LM Sep
	
	// COMMANDE INITIALE de DECEMBRE
	//ColRGA23;Colonne7  // Bacillus Décembre
	//ColRGA24;Colonne8  // Pseudo Décembre
	//ColRGA25;Colonne9  // Lactiques Décembre
	//ColRGA26;Colonne10  // LM Ens Décembre
	//ColRGA27;Colonne11  // LM Sep Décembre
	
	// Pots sup AVEC COFRAC
	//ColRGA28 =  Bacillus 
	//ColRGA29 = Pseudo
	//ColRGA30 = Lactiques
	//ColRGA31 = LM Ens
	//ColRGA32 = LM Sep
	
	// Pots sup SANS COFRAC
	//ColRGA33 =  Bacillus 
	//ColRGA34 = Pseudo
	//ColRGA35 = Lactiques
	//ColRGA36 = LM Ens
	//ColRGA37 = LM Sep
	
	
	
End if 