//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/10/19, 06:28:59
  // ----------------------------------------------------
  // Méthode : QuizzGestionSurChargement
  // Description
  // Méthode exécutée sur chargement du formulaire projet 
  //  "DlgQuizz"
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
VarRapportQD:=""
ZAmnistieInternationale 
ALL RECORDS:C47([QuizzQuestionnaires:35])
If (Records in selection:C76([QuizzQuestionnaires:35])=0)
	ALERT:C41("Désolé;il n'y a rien à voir")
	CANCEL:C270
Else 
	ORDER BY:C49([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]DateCreation:7;<)
	SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]Institution:4;$TbInstitution;[QuizzQuestionnaires:35]Titre:3;$TbTitre)
	LONGINT ARRAY FROM SELECTION:C647([QuizzQuestionnaires:35];TbNumEnrQuestionnaire)
	$FT:=Size of array:C274($TbInstitution)
	ARRAY TEXT:C222(PUMQuestionnaire;$FT)
	For ($Salé;1;$FT)
		PUMQuestionnaire{$Salé}:=$TbInstitution{$Salé}+" - "+$TbTitre{$Salé}
	End for 
	PUMQuestionnaire:=1
	QuizzAfficheLeQuestionnaire (1)
End if 

  // page 3 = gestion des photos ajoutées
ARRAY TEXT:C222(TbSigleInstitution;0)
COPY ARRAY:C226(<>TbSigleInstitution;TbSigleInstitution)
TbSigleInstitution:=6
QuizzAfficheGestionPhotosSup 
