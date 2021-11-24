//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 19/04/20, 10:32:46
  // ----------------------------------------------------
  // Méthode : AntichambreLireMetadonnees
  // Description
  // Méthode qui lit les métadonnées existantes 
  //  sur la photo affichée (VarImage)
  //  et met le résumé dans la variable VarMotsclefs
  // ----------------------------------------------------
ARRAY TEXT:C222($tTkeywords;0)
$Meta:=""
$Copyright:=""
VarMotsclefs:=""
GET PICTURE METADATA:C1122(VarImage;IPTC caption abstract:K68:100;$Meta)
GET PICTURE METADATA:C1122(VarImage;IPTC Keywords:K68:118;$tTkeywords)
GET PICTURE METADATA:C1122(VarImage;IPTC copyright notice:K68:106;$Copyright)
$MotsClés:=ZTableauVersTexte (->$tTkeywords;", ")
VarMotsclefs:="Mots-clés : "+$MotsClés+<>ZCR+"Résumé : "+$Meta+<>ZCR+"Copyright : "+$Copyright