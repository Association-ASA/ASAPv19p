//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/09/19, 18:09:05
  // ----------------------------------------------------
  // Méthode : QuizzFabriqueTbGeneraux
  // Description
  // Méthode qui fabrique les tableaux de correspondance 
  //  permettant de remplir les questionnaires
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$Fumé;$SFT)

  // Les questionnaires
ALL RECORDS:C47([QuizzQuestionnaires:35])
SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]Argument:5;<>TbQuestionnaireArgument\
;[QuizzQuestionnaires:35]Auteur:2;<>TbQuestionnaireAuteur\
;[QuizzQuestionnaires:35]ID:1;<>TbQuestionnaireId\
;[QuizzQuestionnaires:35]Institution:4;<>TbQuestionnaireInstitution\
;[QuizzQuestionnaires:35]Titre:3;<>TbQuestionnaireTitre)
LONGINT ARRAY FROM SELECTION:C647([QuizzQuestionnaires:35];<>TbNumEnrQuestionnaire)


ALL RECORDS:C47([QuizzQuestions:34])
SELECTION TO ARRAY:C260([QuizzQuestions:34]Argument:6;<>TbQuestionArgument\
;[QuizzQuestions:34]CodeQuestion:5;<>TbQuestionCodeQuestion\
;[QuizzQuestions:34]ID:1;<>TbQuestionId\
;[QuizzQuestions:34]IDQuestionnaire:2;<>TbQuestionIdQuestionnaire\
;[QuizzQuestions:34]IDReponseMere:4;<>TbQuestionIDReponseMere\
;[QuizzQuestions:34]LibelQuestion:3;<>TbQuestionLibelQuestion)

ALL RECORDS:C47([QuizzReponses:33])
SELECTION TO ARRAY:C260([QuizzReponses:33]Argument:7;<>TbReponseArgument\
;[QuizzReponses:33]CodeReponse:5;<>TbReponseCodeReponse\
;[QuizzReponses:33]ID:1;<>TbReponseId\
;[QuizzReponses:33]IDQuestion:2;<>TbReponseIdQuestion\
;[QuizzReponses:33]ArgumentaireReponse:4;<>TbReponseArgumentaireReponse\
;[QuizzReponses:33]ValeurReponse:6;<>TbReponseValeurReponse\
;[QuizzReponses:33]LibelReponse:3;<>TbReponseLibelReponse)




  // Calcul du nombre de questions principales par questionnaire
$FT:=Size of array:C274(<>TbQuestionnaireArgument)
$SFT:=Size of array:C274(<>TbQuestionArgument)

ARRAY LONGINT:C221(<>TbQuestionnaireNbreQuestions;0)
ARRAY LONGINT:C221(<>TbQuestionnaireNbreQuestions;$FT)
ARRAY BOOLEAN:C223(<>TbQuestionQuestionPrincipale;$SFT)
ARRAY TEXT:C222(<>TbQuestionReponsesAttendues;0)
ARRAY TEXT:C222(<>TbQuestionReponsesAttendues;$SFT)
For ($Fumé;1;$SFT)  // pour chaque question
	$CodeQuestionCourant:=<>TbQuestionCodeQuestion{$Fumé}
	$Pos:=Position:C15(".";$CodeQuestionCourant)
	$ResteCode:=Substring:C12($CodeQuestionCourant;($Pos+1))
	$Pos:=Position:C15(".";$ResteCode)
	<>TbQuestionQuestionPrincipale{$Fumé}:=($Pos=0)
	If ($Pos=0)
		$L:=Find in array:C230(<>TbQuestionnaireId;<>TbQuestionIdQuestionnaire{$Fumé})
		If ($L>0)
			<>TbQuestionnaireNbreQuestions{$L}:=<>TbQuestionnaireNbreQuestions{$L}+1
		End if 
	End if 
	
	  // liste des bonnes réponses à une question
	$L1:=Find in array:C230(<>TbReponseIdQuestion;<>TbQuestionId{$Fumé})
	While ($L1>0)
		If (<>TbReponseValeurReponse{$L1}=1)
			<>TbQuestionReponsesAttendues{$Fumé}:=<>TbQuestionReponsesAttendues{$Fumé}+", "+<>TbReponseLibelReponse{$L1}
		End if 
		$L1:=Find in array:C230(<>TbReponseIdQuestion;<>TbQuestionId{$Fumé};($L1+1))
	End while 
	<>TbQuestionReponsesAttendues{$Fumé}:=Substring:C12(<>TbQuestionReponsesAttendues{$Fumé};3)
End for 


  // Liste des photos spéciales Quizz
QUERY:C277([DiaData:45];[DiaData:45]XType:5="QuizzPhoto")
SELECTION TO ARRAY:C260([DiaData:45]XNom:1;<>TbQuizzNomPhoto\
;[DiaData:45]XEntier:2;<>TbQuizzNumPhotoN\
;[DiaData:45]XAlpha:14;<>TbQuizzStructurePhoto\
;[DiaData:45]XDate:3;<>TbQuizzDatePhoto)
$FT:=Size of array:C274(<>TbQuizzNomPhoto)
ARRAY TEXT:C222(<>TbQuizzNumPhotoA;$FT)
ARRAY TEXT:C222(<>TbQuizzNumPhotoWA;$FT)
For ($Salé;1;$FT)
	<>TbQuizzNumPhotoA{$Salé}:=<>TbQuizzStructurePhoto{$Salé}+String:C10(<>TbQuizzNumPhotoN{$Salé})
	<>TbQuizzNumPhotoWA{$Salé}:="Q"+<>TbQuizzStructurePhoto{$Salé}+String:C10(<>TbQuizzNumPhotoN{$Salé};"00000")
End for 