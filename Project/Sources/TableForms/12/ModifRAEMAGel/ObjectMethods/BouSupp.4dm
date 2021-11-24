$evt:=Form event code:C388

Case of 
	: $evt=Sur clic:K2:4
		CONFIRM:C162("Êtes-vous sûr de vouloir supprimer la participation du laboratoire "+NumLaboA+" pour la campagne "+NumCampagneDevisGel+" ?")
		If (Ok=1)
			READ WRITE:C146([CampagneGelGermes:25])
			READ WRITE:C146([CampagneParticipations:17])
			$FT:=Records in selection:C76([CampagneGelGermes:25])
			$FTT:=Records in selection:C76([CampagneParticipations:17])
			DELETE SELECTION:C66([CampagneGelGermes:25])
			DELETE SELECTION:C66([CampagneParticipations:17])
		End if 
End case 
CANCEL:C270
ZAmnistiePartielle (->[CampagneGelGermes:25])
