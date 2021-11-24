  // Autorise la méthode
ARRAY TEXT:C222(TbMéthodeAutorisée;1)
TbMéthodeAutorisée{1}:="RAEMACalculEnvoi"
SET ALLOWED METHODS:C805(TbMéthodeAutorisée)
  // Lance le formulaire d'impression
RAEMAGenereEtiquettePoudre 
VarNumCampagne:=[RAEMACampagnes:20]NumCampagne:2+" du "+String:C10([RAEMACampagnes:20]DateEnvoiColis:3;5)
QUERY:C277([RAEMANumEch:47];[RAEMANumEch:47]NumCampagne:5=[RAEMACampagnes:20]NumCampagne:2)
ORDER BY:C49([RAEMANumEch:47]Ordre:6;>)
FORM SET OUTPUT:C54([RAEMANumEch:47];"EtiquetteRAEMAPoudre")
PRINT LABEL:C39([RAEMANumEch:47];Char:C90(1))
