READ WRITE:C146([QuizzQuestionnaires:35])
GOTO RECORD:C242([QuizzQuestionnaires:35]; TbNumEnrQuestionnaire{PUMQuestionnaire})
If ([QuizzQuestionnaires:35]QuizzGeneral:6)
	[QuizzQuestionnaires:35]QuizzGeneral:6:=False:C215
	OBJECT SET TITLE:C194(*; "BouQuizzGeneral"; "Publier le questionnaire")
Else 
	[QuizzQuestionnaires:35]QuizzGeneral:6:=True:C214
	OBJECT SET TITLE:C194(*; "BouQuizzGeneral"; "Retirer le questionnaire")
End if 
SAVE RECORD:C53([QuizzQuestionnaires:35])
