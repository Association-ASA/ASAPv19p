CONFIRM:C162("Supprimer le questionnaire courant ???")
If (OK=1)
	QuizzFabriqueTbGeneraux 
	$NumEnrQuestionnaire:=TbNumEnrQuestionnaire{PUMQuestionnaire}
	GOTO RECORD:C242([QuizzQuestionnaires:35];$NumEnrQuestionnaire)
	$IdQuestionnaireA:=String:C10([QuizzQuestionnaires:35]ID:1)
	QuizzExport ($IdQuestionnaireA)  // Prudent
	READ WRITE:C146(*)
	GOTO RECORD:C242([QuizzQuestionnaires:35];$NumEnrQuestionnaire)
	DELETE RECORD:C58([QuizzQuestionnaires:35])
	QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]CodeQuestion:5=($IdQuestionnaireA+".@"))
	DELETE SELECTION:C66([QuizzQuestions:34])
	QUERY:C277([QuizzReponses:33];[QuizzReponses:33]CodeReponse:5=($IdQuestionnaireA+".@"))
	DELETE SELECTION:C66([QuizzReponses:33])
	QUERY:C277([QuizzPhotos:36];[QuizzPhotos:36]CodePhoto:5=($IdQuestionnaireA+".@"))
	DELETE SELECTION:C66([QuizzPhotos:36])
	ZAmnistieInternationale 
	QuizzFabriqueTbGeneraux 
	QuizzGestionSurChargement 
End if 
