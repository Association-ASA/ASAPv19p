//%attributes = {}
If (Size of array:C274(PUMSuivi)>0)
	QUERY:C277([QuizzSuivi:32];[QuizzSuivi:32]IdSessionVisiteur:9=PUMSuivi{PUMSuivi})
	QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=[QuizzSuivi:32]IDQuestionnaire:2)
	VarTitreQuestionnaire:=[QuizzQuestionnaires:35]Titre:3+" par "+[QuizzQuestionnaires:35]Auteur:2
Else 
	PUMSuivi:=0
End if 