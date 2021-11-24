//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 16/10/21, 11:55:00
// ----------------------------------------------------
// Méthode : QuizzImpCatalogue
// Description
// Méthode qui imprime le catalogue
//  des images originales d'une institution
// Paramètre : $1=Nom de l'institution
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
C_PICTURE:C286($Image; VarImage1; VarImage2; VarImage3; VarImage4; VarImage5)
Origine:=$1
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="quizzphoto"; *)
QUERY:C277([DiaData:45]; [DiaData:45]XAlpha:14=Origine)
$Nom:="Catalogue"+Origine+".pdf"
ZPDFImprimer($Nom; ""; "DiaImpCatalogueOrganesSains")