//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 14.05.19, 16:55:55
  // ----------------------------------------------------
  // Méthode : QuizzAfficheLeQuestionnaire
  // Description
  //
  //
  // Paramètre = rang du PUMQuestionnaire
  // ----------------------------------------------------

$Rang:=$1
If ($Rang=0)
	ZViderSelectionCourante (->[QuizzPhotos:36])
	ZViderSelectionCourante (->[QuizzQuestionnaires:35])
	ZViderSelectionCourante (->[QuizzQuestions:34])
	ZViderSelectionCourante (->[QuizzReponses:33])
Else 
	$NumEnrQuestionnaire:=TbNumEnrQuestionnaire{$Rang}
	GOTO RECORD:C242([QuizzQuestionnaires:35];$NumEnrQuestionnaire)
	$Test:=String:C10([QuizzQuestionnaires:35]ID:1)+".@)"
	QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]IDQuestionnaire:2=[QuizzQuestionnaires:35]ID:1)
	RELATE MANY SELECTION:C340([QuizzReponses:33]IDQuestion:2)
	RELATE MANY SELECTION:C340([QuizzPhotos:36]IDQuestion:2)
	If ([QuizzQuestionnaires:35]QuizzGeneral:6)
		OBJECT SET TITLE:C194(*;"BouQuizzGeneral";"Retirer le questionnaire")
	Else 
		OBJECT SET TITLE:C194(*;"BouQuizzGeneral";"Publier le questionnaire")
	End if 
End if 