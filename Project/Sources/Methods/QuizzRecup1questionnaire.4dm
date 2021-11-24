//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 21.10.19, 21:57:37
// ----------------------------------------------------
// Méthode : QuizzRecup1questionnaire
// Description
// 
//
// Paramètres $1=N° du questionnaire en alpha
// ----------------------------------------------------
ALL RECORDS:C47([QuizzQuestionnaires:35])
SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]ID:1; $TbIdQuestionnaires)
$NumQuestionnaireA:=$1
If (Count parameters:C259=1)
	ZAmnistieInternationale
	SET CHANNEL:C77(10; "")
Else 
	SET CHANNEL:C77(10; [DiaData:45]XTexte:7)
End if 
RECEIVE VARIABLE:C81($Var)
If ($Var#"QuizzQuestionnaires")
	ALERT:C41("Désolé, il semble que le fichier importé ne soit pas le bon...")
Else 
	DEFAULT TABLE:C46([QuizzQuestionnaires:35])
	RECEIVE VARIABLE:C81($Var)
	While ($Var="une autre")
		RECEIVE RECORD:C79
		If (Find in array:C230($TbIdQuestionnaires; [QuizzQuestionnaires:35]ID:1)>0)
			$NumQuestionnaireA:=String:C10([QuizzQuestionnaires:35]ID:1)
			$Rad:=$NumQuestionnaireA+".@"
			READ WRITE:C146(*)
			QUERY:C277([QuizzPhotos:36]; [QuizzPhotos:36]CodePhoto:5=$Rad)
			DELETE SELECTION:C66([QuizzPhotos:36])
			//CHERCHER([QuizzQuestionnaires];[QuizzQuestionnaires]ID=Num($NumQuestionnaireA))
			//SUPPRIMER SÉLECTION([QuizzQuestionnaires])
			QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]CodeQuestion:5=$Rad; *)
			QUERY:C277([QuizzQuestions:34];  | [QuizzQuestions:34]IDQuestionnaire:2=Num:C11($NumQuestionnaireA))
			DELETE SELECTION:C66([QuizzQuestions:34])
			QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5=$Rad)
			DELETE SELECTION:C66([QuizzReponses:33])
		Else 
			SAVE RECORD:C53
		End if 
		
		
		$Var:=""
		RECEIVE VARIABLE:C81($Var)
	End while 
	// $Var="in"
	
	RECEIVE VARIABLE:C81($Var)
	DEFAULT TABLE:C46([QuizzQuestions:34])
	RECEIVE VARIABLE:C81($Var)
	While ($Var="une autre")
		RECEIVE RECORD:C79
		SAVE RECORD:C53
		$Var:=""
		RECEIVE VARIABLE:C81($Var)
	End while 
	// $Var="QuizzReponses"
	
	DEFAULT TABLE:C46([QuizzReponses:33])
	RECEIVE VARIABLE:C81($Var)
	While ($Var="une autre")
		RECEIVE RECORD:C79
		[QuizzReponses:33]ID:1:=Sequence number:C244([QuizzReponses:33])
		SAVE RECORD:C53
		$Var:=""
		RECEIVE VARIABLE:C81($Var)
	End while 
	
	// $Var="QuizzPhotos"
	DEFAULT TABLE:C46([QuizzPhotos:36])
	RECEIVE VARIABLE:C81($Var)
	While ($Var="une autre")
		RECEIVE RECORD:C79
		[QuizzPhotos:36]ID:1:=Sequence number:C244([QuizzPhotos:36])
		SAVE RECORD:C53
		$Var:=""
		RECEIVE VARIABLE:C81($Var)
	End while 
End if 
SET CHANNEL:C77(11)
If (Count parameters:C259=1)
	ZAmnistieInternationale
End if 
