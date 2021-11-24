//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 27/05/21, 11:31:08
// ----------------------------------------------------
// Méthode : QuizzPhotosAfficheQuestionnaire
// Description
// Méthode qui, à partir d'une photo ajoutée
//  affiche les questionnaires concernés
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
QUERY:C277([QuizzPhotos:36]; [QuizzPhotos:36]NumPhotoA:3=[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2))
RELATE ONE SELECTION:C349([QuizzPhotos:36]; [QuizzQuestionnaires:35])
SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]ID:1; $TbIdQuestionnaire)
$Liste:=""
$FT:=Size of array:C274($TbIdQuestionnaire)
ARRAY TEXT:C222($TbQuestionnaireConcernés; 0)
For ($Salé; 1; $FT)
	$IdQuestionnaireA:=String:C10($TbIdQuestionnaire{$Salé})
	If (Find in array:C230($TbQuestionnaireConcernés; $IdQuestionnaireA)<0)
		APPEND TO ARRAY:C911($TbQuestionnaireConcernés; $IdQuestionnaireA)
	End if 
End for 
$0:=ZTableauVersTexte(->$TbQuestionnaireConcernés; ", ")

