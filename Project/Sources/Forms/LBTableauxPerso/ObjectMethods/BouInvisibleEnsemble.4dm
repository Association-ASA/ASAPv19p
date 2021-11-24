
If (GestionTableau)
	CREATE SELECTION FROM ARRAY:C640(ZPtTable->; TbNumEnr)
End if 
CREATE SET:C116(ZPtTable->; ZNomEnsembleAvant)  // Utile en cas de gestion de liste pour  Ajouter à sélection
$Menu:="Afficher les caducs;-;Mars;Octobre;RAEMA de l’année;-;RAEMA Gel n-1;Colis sup n-1;Boite isotherme n-1;Pas inscrit RAEMA Gel;-;Afficher les participants;Participants de l'année;-;Correspondance entre pots;Colis supp AR;Colis supp SR;"
$Menu:=$Menu+"Boîtes isothermes;Sans pathogènes;ADILVA;Proforma DHL;Proforma Chronopost;Transporteur DHL;Transpoteur Chronopost;N°BDC Poudre;N°BDC Gel"
$VarChoixUtilisateur:=Pop up menu:C542($Menu)
$OC:=True:C214
Case of 
	: ($VarChoixUtilisateur=1)  // Afficher les caducs
		QUERY:C277([Personnes:12]; [Personnes:12]Caduc:8=True:C214; *)
		QUERY:C277([Personnes:12];  & [Personnes:12]TypePersonne:5="laboratoire")
		
		
		ASAPPerFabriqueTb(True:C214)
		
	: ($VarChoixUtilisateur=3)  // Mars
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 1)
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMars)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "Mars")
		QUERY:C277([CampagneParticipations:17];  & ; [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "Octobre")
		//CHERCHER PAR ATTRIBUT([CampagneParticipations]; & ;[CampagneParticipations]Arguments;"Sauvage";=;Null)
		DIFFERENCE:C122("Mars"; "Octobre"; "QueMars")
		USE SET:C118("QueMars")
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=4)  // Octobre
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 1)
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "Octobre")
		QUERY:C277([CampagneParticipations:17];  & ; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMars; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "Mars")
		//CHERCHER PAR ATTRIBUT([CampagneParticipations]; & ;[CampagneParticipations]Arguments;"Sauvage";=;Null)
		DIFFERENCE:C122("Octobre"; "Mars"; "QueOctobre")
		USE SET:C118("QueOctobre")
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=5)  // RAEMA de l’année
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 1)
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMars; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=7)  // Inscrit au RAEMA Gel en année n-1
		$AnnéeDernière:=(Year of:C25(Current date:C33)-1)
		$Année:=Num:C11(Request:C163("A quelle année voulez-vous comparer la liste de cette année ?"; String:C10($AnnéeDernière)))
		$NumRaemaMaiAvant:=RaemaTrouveNumCampagneParAn($Année; 2)
		$NumRaemaDécembreAvant:=RaemaTrouveNumCampagneParAn($Année; 4)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMaiAvant; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembreAvant; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "AnnéeDernière")
		$NumRaemaMaiMaintenant:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 2)
		$NumRaemaDécembreMaintenant:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 4)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMaiMaintenant; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembreMaintenant; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "AnnéeEnCours")
		DIFFERENCE:C122("AnnéeDernière"; "AnnéeEnCours"; "NonInscrit")
		USE SET:C118("NonInscrit")
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=8)  // Colis sup en année n-1
		$AnnéeDernière:=(Year of:C25(Current date:C33)-1)
		$Année:=Num:C11(Request:C163("A quelle année voulez-vous comparer la liste de cette année ?"; String:C10($AnnéeDernière)))
		$NumRaemaMarsAvant:=RaemaTrouveNumCampagneParAn($Année; 1)
		$NumRaemaOctobreAvant:=RaemaTrouveNumCampagneParAn($Année; 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAvant; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAvant; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; [CampagneParticipations:17]Arguments:5; "NbreColisSupSansRapport"; #; Null:C1517; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  | ; [CampagneParticipations:17]Arguments:5; "NbreColisSupAvecRapport"; #; Null:C1517; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "AnnéeDernière")
		//$FT:=Enregistrements trouvés([Personnes])
		//DÉBUT SELECTION([Personnes])
		//$rapport:=""
		//Boucle ($Salé;1;$FT)
		//$NumLabo:=ASAPTrouveNumeroLaboParUUID ([Personnes]UUID)
		//$rapport:=$rapport+$NumLabo+<>ZCR
		//ENREGISTREMENT SUIVANT([Personnes])
		//Fin de boucle 
		//TRACE
		$NumRaemaMarsAprès:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 1)
		$NumRaemaOctobreAprès:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAprès; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAprès; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; [CampagneParticipations:17]Arguments:5; "NbreColisSupSansRapport"; #; Null:C1517; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  | ; [CampagneParticipations:17]Arguments:5; "NbreColisSupAvecRapport"; #; Null:C1517; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "AnnéeEnCours")
		//$FT:=Enregistrements trouvés([Personnes])
		//DÉBUT SELECTION([Personnes])
		//$rapport:=""
		//Boucle ($Salé;1;$FT)
		//$NumLabo:=ASAPTrouveNumeroLaboParUUID ([Personnes]UUID)
		//$rapport:=$rapport+$NumLabo+<>ZCR
		//ENREGISTREMENT SUIVANT([Personnes])
		//Fin de boucle 
		//TRACE
		DIFFERENCE:C122("AnnéeDernière"; "AnnéeEnCours"; "SansColis")
		USE SET:C118("SansColis")
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=9)  // Boite isotherme en année n-1
		$AnnéeDernière:=(Year of:C25(Current date:C33)-1)
		$Année:=Num:C11(Request:C163("A quelle année voulez-vous comparer la liste de cette année ?"; String:C10($AnnéeDernière)))
		$NumRaemaMarsAvant:=RaemaTrouveNumCampagneParAn($Année; 1)
		$NumRaemaOctobreAvant:=RaemaTrouveNumCampagneParAn($Année; 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAvant; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAvant; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "BoîteIsotherme"; #; Null:C1517; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "AnnéeDernière")
		$NumRaemaMarsAprès:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 1)
		$NumRaemaOctobreAprès:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAprès; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAprès; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; [CampagneParticipations:17]Arguments:5; "BoîteIsotherme"; #; Null:C1517; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "AnnéeEnCours")
		DIFFERENCE:C122("AnnéeDernière"; "AnnéeEnCours"; "SansColis")
		USE SET:C118("SansColis")
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=10)  // Pas inscrit au RAEMA Gel
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 1)
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 3)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMars; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; #; True:C214)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "RAEMAPoudre")
		$NumRaemaMaiMaintenant:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 2)
		$NumRaemaDécembreMaintenant:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 4)
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMaiMaintenant; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembreMaintenant; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; #; True:C214)
		RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
		CREATE SET:C116([Personnes:12]; "RAEMAGel")
		DIFFERENCE:C122("RAEMAPoudre"; "RAEMAGel"; "NonInscritGel")
		USE SET:C118("NonInscritGel")
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=12)  // Veut sélectionner les participants à une campagne
		$NumCampagne:=Request:C163("De quelle campagne voulez-vous la liste des participants?")
		QUERY:C277([Personnes:12]; [CampagneParticipations:17]NumCampagne:3=$NumCampagne)
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=13)  // Veut sélectionner les participants de l'année
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 1)
		$NumRaemaMai:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 2)
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 3)
		$NumRaemaDécembre:=RaemaTrouveNumCampagneParAn(Year of:C25(Current date:C33); 4)
		QUERY:C277([Personnes:12]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMars; *)
		QUERY:C277([Personnes:12];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaMai; *)
		QUERY:C277([Personnes:12];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre; *)
		QUERY:C277([Personnes:12];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembre; *)
		QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		ASAPPerFabriqueTb
		
	: ($VarChoixUtilisateur=15)
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos prenant la correspondance entre les pots ?")
		If (OK=1)
			QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "CorrespondanceEntrePots"; =; True:C214)
			RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=16)
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos prenant des colis supp avec rapport ?")
		If (OK=1)
			QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "NbreColisSupAvecRapport"; #; Null:C1517)
			RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=17)
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos prenant des colis supp sans rapport ?")
		If (OK=1)
			QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "NbreColisSupSansRapport"; #; Null:C1517)
			RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=18)
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos prenant des boîtes isothermes ?")
		If (OK=1)
			QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "BoîteIsotherme"; #; Null:C1517; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "BoîteIsotherme"; #; 0)
			
			RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=19)
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos sans pathogènes ?")
		If (OK=1)
			QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "SansPathogene"; #; Null:C1517)
			RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=20)
		QUERY:C277([Personnes:12]; [Personnes:12]Caduc:8=False:C215; *)
		QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [Personnes:12]Arguments:7; "Association"; =; "Adilva@")
		ASAPPerFabriqueTb
		RELATE MANY SELECTION:C340([PersonnesAdresses:11]UUIDPersonne:2)
		QUERY:C277([PersonnesAdresses:11]; [PersonnesAdresses:11]TypeAdresse:9="Livraison")
		SELECTION TO ARRAY:C260([Personnes:12]UUID:1; $TBUUID; [Personnes:12]NomLong:2; $TBNomLong)
		SELECTION TO ARRAY:C260([PersonnesAdresses:11]CodePostal:6; $TBCodePostal; [PersonnesAdresses:11]Ville:7; $TBVille; [PersonnesAdresses:11]Pays:8; $TBPays; [PersonnesAdresses:11]UUIDPersonne:2; $TBUUIDPersonneAdresse)
		$TT:=Size of array:C274($TBUUID)
		$Rapport:=""
		For ($salé; 1; $TT)
			$Nom:=$TBNomLong{$salé}
			$NuméroLabo:=ASAPTrouveNumeroLaboParUUID($TBUUID{$salé})
			$L:=Find in array:C230($TBUUIDPersonneAdresse; $TBUUID{$salé})
			$Adresse:=$TBCodePostal{$L}+" "+$TBVille{$L}
			$Pays:=$TBPays{$L}
			$Rapport:=$Rapport+$NuméroLabo+<>ZTAB+$Nom+<>ZTAB+$Adresse+<>ZTAB+$Pays+<>ZCR
		End for 
		SET TEXT TO PASTEBOARD:C523($Rapport)
		ALERT:C41("La liste des laboratoire ADILVA a été copiée dans la presse papier. Tu n'as plus qu'à coller dans Excel =)")
		
	: ($VarChoixUtilisateur=21)
		ALERT:C41("Si vous souhaitez envoyer les proformas par mail, assurez-vous avant de les avoir générées sur le serveur")
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos ayant une proforma ?")
		If (OK=1)
			QUERY:C277([Personnes:12]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [CampagneParticipations:17]Arguments:5; "Transporteur"; =; "DHL@"; *)
			QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [Personnes:12]Arguments:7; "Proforma"; #; Null:C1517)
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=22)
		ALERT:C41("Si vous souhaitez envoyer les proformas par mail, assurez-vous avant de les avoir générées sur le serveur")
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos ayant une proforma ?")
		If (OK=1)
			QUERY:C277([Personnes:12]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [CampagneParticipations:17]Arguments:5; "Transporteur"; =; "Chronopost@"; *)
			QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [Personnes:12]Arguments:7; "Proforma"; #; Null:C1517)
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=23)
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos passant par DHL ?")
		If (OK=1)
			QUERY:C277([Personnes:12]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [CampagneParticipations:17]Arguments:5; "Transporteur"; =; "DHL@")
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=24)
		$Campagne:=Request:C163("Pour quelle campagne souhaitez-vous sélectionner les labos passant par Chronopost ?")
		If (OK=1)
			QUERY:C277([Personnes:12]; [CampagneParticipations:17]NumCampagne:3=$Campagne; *)
			QUERY BY ATTRIBUTE:C1331([Personnes:12];  & ; [CampagneParticipations:17]Arguments:5; "Transporteur"; =; "Chronopost@")
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=25)
		$AnnéeA:=String:C10(Year of:C25(Current date:C33))
		$AnnéeVoulue:=Request:C163("Pour quelle année souhaitez-vous sélectionner les labos ayant un numéro de bon de commande Poudre ?"; $AnnéeA)
		If (OK=1)
			$NumRaemaMars:=RaemaTrouveNumCampagneParAn(Num:C11($AnnéeVoulue); 1)
			$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn(Num:C11($AnnéeVoulue); 3)
			QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMars; *)
			QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "NumBonCommandePoudre"; #; Null:C1517)
			RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
			ASAPPerFabriqueTb
		End if 
		
	: ($VarChoixUtilisateur=26)
		$AnnéeA:=String:C10(Year of:C25(Current date:C33))
		$AnnéeVoulue:=Request:C163("Pour quelle année souhaitez-vous sélectionner les labos ayant un numéro de bon de commande Poudre ?"; $AnnéeA)
		If (OK=1)
			$NumRaemaMars:=RaemaTrouveNumCampagneParAn(Num:C11($AnnéeVoulue); 2)
			$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn(Num:C11($AnnéeVoulue); 4)
			QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=$NumRaemaMars; *)
			QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre; *)
			QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "RGNumBonCommande"; #; Null:C1517)
			RELATE ONE SELECTION:C349([CampagneParticipations:17]; [Personnes:12])
			ASAPPerFabriqueTb
		End if 
		
		
	Else 
		$OC:=False:C215
End case 

If ($OC)
	
	
	If (GestionTableau)
		CREATE SELECTION FROM ARRAY:C640(ZPtTable->; TbNumEnr)
	End if 
	
	
	LISTBOX SELECT ROW:C912(*; "Lb_Tableaux"; 0; lk remove from selection:K53:3)
	ZNbEnr:=Size of array:C274(TbPerNum)
	ZFenetreActualiseTitre
End if 