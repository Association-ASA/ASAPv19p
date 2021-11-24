$evt:=Form event code:C388

Case of 
	: $evt=Sur clic:K2:4
		CONFIRM:C162("Êtes-vous sûr de vouloir modifier les paramètres du laboratoire "+NumLaboA+" pour la campagne "+NumCampagneDevisGel+" ?")
		If (Ok=1)
			
			READ WRITE:C146([CampagneGelGermes:25])
			$FT:=Records in selection:C76([CampagneGelGermes:25])
			DELETE SELECTION:C66([CampagneGelGermes:25])
			
			$FT:=Records in selection:C76([CampagneParticipations:17])
			If ($FT=0)
				CREATE RECORD:C68([CampagneParticipations:17])
				[CampagneParticipations:17]NumCampagne:3:=NumCampagneDevisGel
				[CampagneParticipations:17]UUIDPersonne:2:=[Personnes:12]UUID:1
				SAVE RECORD:C53([CampagneParticipations:17])
			End if 
			
			If (CBBacillus=True:C214)
				CREATE RECORD:C68([CampagneGelGermes:25])
				[CampagneGelGermes:25]NbreColisSupAvecRapport:5:=ARBacillus
				[CampagneGelGermes:25]NbreColisSupSansRapport:4:=SRBacillus
				[CampagneGelGermes:25]NomDuGerme:3:="BACILLUS CEREUS"
				[CampagneGelGermes:25]NumCampagne:6:=NumCampagneDevisGel
				[CampagneGelGermes:25]UUIDParticipation:2:=[CampagneParticipations:17]UUID:1
				SAVE RECORD:C53([CampagneGelGermes:25])
			End if 
			
			If (CBPseudomonas=True:C214)
				CREATE RECORD:C68([CampagneGelGermes:25])
				[CampagneGelGermes:25]NbreColisSupAvecRapport:5:=ARPseudomonas
				[CampagneGelGermes:25]NbreColisSupSansRapport:4:=SRPseudomonas
				[CampagneGelGermes:25]NomDuGerme:3:="PSEUDOMONAS"
				[CampagneGelGermes:25]NumCampagne:6:=NumCampagneDevisGel
				[CampagneGelGermes:25]UUIDParticipation:2:=[CampagneParticipations:17]UUID:1
				SAVE RECORD:C53([CampagneGelGermes:25])
			End if 
			
			If (CBLactique=True:C214)
				CREATE RECORD:C68([CampagneGelGermes:25])
				[CampagneGelGermes:25]NbreColisSupAvecRapport:5:=ARLactique
				[CampagneGelGermes:25]NbreColisSupSansRapport:4:=SRLactique
				[CampagneGelGermes:25]NomDuGerme:3:="BACTERIES LACTIQUES"
				[CampagneGelGermes:25]NumCampagne:6:=NumCampagneDevisGel
				[CampagneGelGermes:25]UUIDParticipation:2:=[CampagneParticipations:17]UUID:1
				SAVE RECORD:C53([CampagneGelGermes:25])
			End if 
			
			If (CBLMens=True:C214)
				CREATE RECORD:C68([CampagneGelGermes:25])
				[CampagneGelGermes:25]NbreColisSupAvecRapport:5:=ARLMens
				[CampagneGelGermes:25]NbreColisSupSansRapport:4:=SRLMens
				[CampagneGelGermes:25]NomDuGerme:3:="LEVURES-MOISISSURES ENSEMBLE"
				[CampagneGelGermes:25]NumCampagne:6:=NumCampagneDevisGel
				[CampagneGelGermes:25]UUIDParticipation:2:=[CampagneParticipations:17]UUID:1
				SAVE RECORD:C53([CampagneGelGermes:25])
			End if 
			
			If (CBLMsep=True:C214)
				CREATE RECORD:C68([CampagneGelGermes:25])
				[CampagneGelGermes:25]NbreColisSupAvecRapport:5:=ARLMsep
				[CampagneGelGermes:25]NbreColisSupSansRapport:4:=SRLMsep
				[CampagneGelGermes:25]NomDuGerme:3:="LEVURES-MOISISSURES SEPAREMENT"
				[CampagneGelGermes:25]NumCampagne:6:=NumCampagneDevisGel
				[CampagneGelGermes:25]UUIDParticipation:2:=[CampagneParticipations:17]UUID:1
				SAVE RECORD:C53([CampagneGelGermes:25])
			End if 
			CANCEL:C270
			
			
			// Des colis supplémentaires ont-ils été ajoutés
			$ColisARaprès:=ARBacillus+ARPseudomonas+ARLactique+ARLMens+ARLMsep  // Reste à codé après avoir homogénéisé le calcul des numéros liés
			
			
		Else 
			CANCEL:C270
		End if 
End case 
ZAmnistiePartielle(->[CampagneGelGermes:25])
