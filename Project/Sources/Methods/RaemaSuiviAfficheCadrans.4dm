//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 11/08/16, 15:56:47
  // ----------------------------------------------------
  // Méthode : RaemaSuiviAfficheCadrans
  // Description
  // Valorise des cadrans d'avancement des différents 
  // statuts des laboratoires
  // ----------------------------------------------------
VarAvancementAbsence:=Size of array:C274(TbAbsent)
Cadran1:=Size of array:C274(TbAbsent)*100/Size of array:C274(TbParticipantN)

VarAvancementEncours:=Size of array:C274(TbEnCours)
Cadran2:=Size of array:C274(TbEnCours)*100/Size of array:C274(TbParticipantN)

VarAvancementEnvoyée:=Size of array:C274(TbEnvoyé)
Cadran3:=Size of array:C274(TbEnvoyé)*100/Size of array:C274(TbParticipantN)
