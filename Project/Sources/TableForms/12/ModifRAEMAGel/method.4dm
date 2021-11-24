$evt:=Form event code:C388

Case of 
	: $evt=Sur chargement:K2:1
		$UUIDLabo:=[Personnes:12]UUID:1
		NumLaboA:=ASAPTrouveNumeroLaboParUUID ($UUIDLabo)
		VarTitre:="Modification de la campagne "+NumCampagneDevisGel+" pour le labo n° "+NumLaboA
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=$UUIDLabo;*)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=NumCampagneDevisGel)
		RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)
		$FT:=Records in selection:C76([CampagneGelGermes:25])
		
		CBBacillus:=False:C215
		ARBacillus:=0
		SRBacillus:=0
		
		CBPseudomonas:=False:C215
		ARPseudomonas:=0
		SRPseudomonas:=0
		
		CBLactique:=False:C215
		ARLactique:=0
		SRLactique:=0
		
		CBLMens:=False:C215
		ARLMens:=0
		SRLMens:=0
		
		CBLMsep:=False:C215
		ARLMsep:=0
		SrLMsep:=0
		
		For ($salé;1;$FT)
			Case of 
				: [CampagneGelGermes:25]NomDuGerme:3="BACILLUS CEREUS"
					CBBacillus:=True:C214
					ARBacillus:=[CampagneGelGermes:25]NbreColisSupAvecRapport:5
					SRBacillus:=[CampagneGelGermes:25]NbreColisSupSansRapport:4
					
				: [CampagneGelGermes:25]NomDuGerme:3="PSEUDOMONAS"
					CBPseudomonas:=True:C214
					ARPseudomonas:=[CampagneGelGermes:25]NbreColisSupAvecRapport:5
					SRPseudomonas:=[CampagneGelGermes:25]NbreColisSupSansRapport:4
					
				: [CampagneGelGermes:25]NomDuGerme:3="BACTERIES LACTIQUES"
					CBLactique:=True:C214
					ARLactique:=[CampagneGelGermes:25]NbreColisSupAvecRapport:5
					SRLactique:=[CampagneGelGermes:25]NbreColisSupSansRapport:4
					
				: [CampagneGelGermes:25]NomDuGerme:3="LEVURES-MOISISSURES ENSEMBLE"
					CBLMens:=True:C214
					ARLMens:=[CampagneGelGermes:25]NbreColisSupAvecRapport:5
					SRLMens:=[CampagneGelGermes:25]NbreColisSupSansRapport:4
					
				: [CampagneGelGermes:25]NomDuGerme:3="LEVURES-MOISISSURES SEPAREMENT"
					CBLMsep:=True:C214
					ARLMsep:=[CampagneGelGermes:25]NbreColisSupAvecRapport:5
					SRLMsep:=[CampagneGelGermes:25]NbreColisSupSansRapport:4
					
			End case 
			NEXT RECORD:C51([CampagneGelGermes:25])
			
		End for 
		  // Avant de modifier les [CampagneGelGermes], y a-il des colis supplémentaires avec rapport
		ColisARavant:=ARBacillus+ARPseudomonas+ARLactique+ARLMens+ARLMsep
End case 
