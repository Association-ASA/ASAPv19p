//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/08/19, 15:37:19
  // ----------------------------------------------------
  // Méthode : ASAPSurChargementSaisiePar
  // Description
  // Méthode qui affiche le contenu de [CampagneParticipations];"Visu"


RELATE MANY:C262([CampagneParticipations:17]UUID:1)
VarNumLaboA:=ASAPTrouveNumeroLaboParUUID ([CampagneParticipations:17]UUIDPersonne:2)
VarNumEnr:=Record number:C243([CampagneParticipations:17])
