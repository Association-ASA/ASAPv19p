//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 26/08/20, 16:08:21
// ----------------------------------------------------
// Méthode : ASAPMajRéponseEnvoyée
// Description
// Met à jour l'argument réponse envoyée dans les campagne participation
// si le labo a envoyé une réponse dans WebConnexion
// ----------------------------------------------------

QUERY:C277([WebConnexions:13]; [WebConnexions:13]BoolEnvoi:8=True:C214)
SELECTION TO ARRAY:C260([WebConnexions:13]Campagne:5; $TbCampagne; [WebConnexions:13]UUIDParticipation:12; $TbUUIDParticipation)
READ WRITE:C146([CampagneParticipations:17])
$TT:=Size of array:C274($TbCampagne)
For ($Salé; 1; $TT)
	QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUID:1=$TbUUIDParticipation{$salé})
	[CampagneParticipations:17]Arguments:5.RéponseEnvoyée:=True:C214
	SAVE RECORD:C53([CampagneParticipations:17])
End for 
ZAmnistieInternationale