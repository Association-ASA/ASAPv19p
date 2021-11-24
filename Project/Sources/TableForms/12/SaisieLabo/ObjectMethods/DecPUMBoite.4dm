OnAChangéParticipation:=True:C214  // A priori changement dans les [CampagneParticipations]
$Mois:="Dec"
$PtBt:=Get pointer:C304("PUM"+$Mois+"Boite")
$LignePUM:=$PtBt->
READ WRITE:C146([CampagneParticipations:17])
QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=CampagneDécembre; *)
QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
$FT:=Records in selection:C76([CampagneParticipations:17])
For ($Salé; 1; $FT)
	OB SET:C1220([CampagneParticipations:17]Arguments:5; "BoîteIsotherme"; $LignePUM-1)
	SAVE RECORD:C53([CampagneParticipations:17])
	NEXT RECORD:C51([CampagneParticipations:17])
End for 
// ASAPActualiseTbParticipationN (CampagneMars;"BoîteIsotherme";PUMMarsBoite-1)

ZAmnistiePartielle(->[CampagneParticipations:17])