//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/09/21, 12:05:54
  // ----------------------------------------------------
  // Méthode : QuizzPDFCataloguePhotosSup
  // Description
  // Méthode qui imprime le catalogue
  //  des photos originales des questionnaires
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
QUERY:C277([DiaData:45];[DiaData:45]XType:5="quizzphoto")
SELECTION TO ARRAY:C260([DiaData:45]XAlpha:14;$TbInstitution\
;[DiaData:45]XEntier:2;$TbRangN\
;[DiaData:45]XTexte:7;$TbEspèce\
;[DiaData:45]XTexteSup:8;$TbLesion)
$FT:=Size of array:C274($TbInstitution)
For ($Salé;1;$FT)
	
	
	
End for 

$H:=Print form:C5("PhotoSupImpression")