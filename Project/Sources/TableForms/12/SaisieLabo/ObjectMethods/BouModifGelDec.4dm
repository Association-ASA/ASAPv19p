$evt:=Form event code:C388
Case of 
		
	: ($evt=Sur clic:K2:4)
		OnAChangéParticipation:=True:C214
		NumCampagneDevisGel:=CampagneDécembre
		QUERY:C277([RAEMACampagnes:20]; [RAEMACampagnes:20]NumCampagne:2=NumCampagneDevisGel)
		If ([RAEMACampagnes:20]DateMiseEnLigne:5#!00-00-00!)
			CONFIRM:C162("Cette campagne est terminée. Il est fortement déconseillé de la modifier. Êtes-vous sûr de vouloir le faire ?")
			
			If (Ok=1)
				$UUIDLabo:=[Personnes:12]UUID:1
				QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=NumCampagneDevisGel; *)
				QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]UUIDPersonne:2=$UUIDLabo)
				RELATE MANY:C262([CampagneParticipations:17]UUID:1)
				$FT:=Records in selection:C76([WebConnexions:13])
				If ($FT>0)
					ALERT:C41("Ce labo s'est déjà connecté lors de la campagne désignée. Ces données de participation ne peuvent être modifiées.")
				Else 
					$F:=Open form window:C675([Personnes:12]; "ModifRAEMAGel")
					DIALOG:C40([Personnes:12]; "ModifRAEMAGel")
				End if 
			Else 
				CANCEL:C270
			End if 
			
		Else 
			$F:=Open form window:C675([Personnes:12]; "ModifRAEMAGel")
			DIALOG:C40([Personnes:12]; "ModifRAEMAGel")
		End if 
End case 