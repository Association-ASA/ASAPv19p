$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		OnAChangéParticipation:=True:C214  // A priori changement dans les [CampagneParticipations]
		$NomTransporteur:=PUMTransporteur{PUMTransporteur}
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=CampagneDécembre;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
		$FT:=Records in selection:C76([CampagneParticipations:17])
		For ($Salé;1;$FT)
			If ($NomTransporteur#"")
				OB SET:C1220([CampagneParticipations:17]Arguments:5;"Transporteur";$NomTransporteur)
			Else 
				OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"Transporteur")
			End if 
			SAVE RECORD:C53([CampagneParticipations:17])
		End for 
		VarDecembreTransport:=$NomTransporteur
		ZAmnistiePartielle (->[CampagneParticipations:17])
End case 
