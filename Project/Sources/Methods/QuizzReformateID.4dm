//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 17/03/20, 07:59:26
// ----------------------------------------------------
// Méthode : QuizzReformateID
// Description
// Méthode qui remet de l'ordre dans les [QuizzQuestionnaires]ID
// et les [QuizzQuestions]ID
//  et réactualise les eneregistrements liés
// ----------------------------------------------------




//-On appelle tous les quizz question liés à l’ancien ID et on leur attribue le nouveau numéro

//Pour chaque question :
//-On note son ancien ID dans quizz question Argument
//-On modifie son ID de façon à donner un ID séquentiel
//-On appelle tous les quizz réponse liés à l’ancien ID et on leur attribue le
//-On appelle tous les quizz photos liés à l’ancien ID et on leur attribue le n

C_LONGINT:C283($Salé; $FT)
READ WRITE:C146(*)
//On appelle les quizz questionnaires triés par ID.
ALL RECORDS:C47([QuizzQuestionnaires:35])
SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]ID:1; $TbIDQuestionnaireQuestionnaire)
LONGINT ARRAY FROM SELECTION:C647([QuizzQuestionnaires:35]; $TbNumEnrQuestionnaire)
SORT ARRAY:C229($TbIDQuestionnaireQuestionnaire; $TbNumEnrQuestionnaire; >)

//Pour chaque questionnaire :
$FT:=Size of array:C274($TbIDQuestionnaireQuestionnaire)
For ($Salé; 1; $FT)
	GOTO RECORD:C242([QuizzQuestionnaires:35]; $TbNumEnrQuestionnaire{$Salé})
	$AncienID:=$TbIDQuestionnaireQuestionnaire{$Salé}
	//-On note son ancien ID dans quizz questionnaire Argument
	//-On modifie son ID de façon à donner un ID séquentielOB FIXER([QuizzQuestionnaires]Argument;"AncienID";$AncienID)
	[QuizzQuestionnaires:35]ID:1:=$Salé
	SAVE RECORD:C53([QuizzQuestionnaires:35])
	
	//-On appelle tous les quizz suivi liés à l’ancien ID et on leur attribue le nouveau numéro
	QUERY:C277([QuizzSuivi:32]; [QuizzSuivi:32]IDQuestionnaire:2=$AncienID)
	$SFTs:=Records in selection:C76([QuizzSuivi:32])
	ARRAY LONGINT:C221($TbIDQuestionnaire2; 0)
	SELECTION TO ARRAY:C260([QuizzSuivi:32]IDQuestionnaire:2; $TbIDQuestionnaire2)
	For ($Fumé; 1; $SFTs)
		$TbIDQuestionnaire2{$Fumé}:=$Salé
	End for 
	ARRAY TO SELECTION:C261($TbIDQuestionnaire2; [QuizzSuivi:32]IDQuestionnaire:2)
	
	
	//-On appelle tous les quizz questions liés à l’ancien ID et on leur attribue le nouveau numéro
	QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]IDQuestionnaire:2=$AncienID)
	$SFT:=Records in selection:C76([QuizzQuestions:34])
	ARRAY LONGINT:C221($TbIDQuestionnaire2; 0)
	ARRAY TEXT:C222($TbCodeQuestion; 0)
	ARRAY LONGINT:C221($TbIDQuestion; 0)
	SELECTION TO ARRAY:C260([QuizzQuestions:34]IDQuestionnaire:2; $TbIDQuestionnaire2\
		; [QuizzQuestions:34]ID:1; $TbIDQuestion\
		; [QuizzQuestions:34]CodeQuestion:5; $TbCodeQuestion)
	For ($Fumé; 1; $SFT)
		$TbIDQuestionnaire2{$Fumé}:=$Salé
		$Pos:=Position:C15("."; $TbCodeQuestion{$Fumé})
		$TbCodeQuestion{$Fumé}:=String:C10($Salé)+Substring:C12($TbCodeQuestion{$Fumé}; $Pos)
		
		
		// passons aux réponses
		QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]IDQuestion:2=$TbIDQuestion{$Fumé})
		SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5; $TbCodeReponse)
		$TT:=Size of array:C274($TbCodeReponse)
		ARRAY LONGINT:C221($TbIDQR; $TT)
		For ($Sec; 1; $TT)
			$TbIDQR{$Sec}:=$TbIDQuestion{$Fumé}
			$Pos:=Position:C15("."; $TbCodeReponse{$Sec})
			$TbCodeReponse{$Sec}:=String:C10($Salé)+Substring:C12($TbCodeReponse{$Sec}; $Pos)
		End for 
		ARRAY TO SELECTION:C261($TbIDQR; [QuizzReponses:33]IDQuestion:2; $TbCodeReponse; [QuizzReponses:33]CodeReponse:5)
		
		QUERY:C277([QuizzPhotos:36]; [QuizzPhotos:36]IDQuestion:2=$TbIDQuestion{$Fumé})
		SELECTION TO ARRAY:C260([QuizzPhotos:36]CodePhoto:5; $TbCodePhoto)
		$TT:=Size of array:C274($TbCodePhoto)
		ARRAY LONGINT:C221($TbIDQP; $TT)
		For ($Sec; 1; $TT)
			$TbIDQP{$Sec}:=$TbIDQuestion{$Fumé}
			$Pos:=Position:C15("."; $TbCodePhoto{$Sec})
			$TbCodePhoto{$Sec}:=String:C10($Salé)+Substring:C12($TbCodePhoto{$Sec}; $Pos)
		End for 
		ARRAY TO SELECTION:C261($TbIDQP; [QuizzPhotos:36]IDQuestion:2; $TbCodePhoto; [QuizzPhotos:36]CodePhoto:5)
		
	End for 
	ARRAY TO SELECTION:C261($TbIDQuestionnaire2; [QuizzQuestions:34]IDQuestionnaire:2; $TbCodeQuestion; [QuizzQuestions:34]CodeQuestion:5)
	
	
End for 
//-On fixe le prochain numéro automatique pour les tables quizz
ALL RECORDS:C47([QuizzQuestionnaires:35])
ORDER BY:C49([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzQuestionnaires:35]; Numéro automatique table:K37:31; [QuizzQuestionnaires:35]ID:1)

ALL RECORDS:C47([QuizzSuivi:32])
ORDER BY:C49([QuizzSuivi:32]; [QuizzSuivi:32]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzSuivi:32]; Numéro automatique table:K37:31; [QuizzSuivi:32]ID:1)

ALL RECORDS:C47([QuizzQuestions:34])
ORDER BY:C49([QuizzQuestions:34]; [QuizzQuestions:34]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzQuestions:34]; Numéro automatique table:K37:31; [QuizzQuestions:34]ID:1)

ALL RECORDS:C47([QuizzReponses:33])
ORDER BY:C49([QuizzReponses:33]; [QuizzReponses:33]ID:1; <)
SELECTION TO ARRAY:C260([QuizzReponses:33]ID:1; $TbID)
$FT:=Size of array:C274($TbID)
For ($Salé; 1; $FT)
	$TbID{$Salé}:=$Salé
End for 
ARRAY TO SELECTION:C261($TbID; [QuizzReponses:33]ID:1)
SET DATABASE PARAMETER:C642([QuizzReponses:33]; Numéro automatique table:K37:31; $FT)

ALL RECORDS:C47([QuizzPhotos:36])
ORDER BY:C49([QuizzPhotos:36]; [QuizzPhotos:36]ID:1; <)
SELECTION TO ARRAY:C260([QuizzPhotos:36]ID:1; $TbID)
$FT:=Size of array:C274($TbID)
For ($Salé; 1; $FT)
	$TbID{$Salé}:=$Salé
End for 
ARRAY TO SELECTION:C261($TbID; [QuizzPhotos:36]ID:1)
SET DATABASE PARAMETER:C642([QuizzPhotos:36]; Numéro automatique table:K37:31; $FT)

ZAmnistieInternationale