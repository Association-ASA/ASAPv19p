//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 29/09/19, 07:21:55
// ----------------------------------------------------
// Méthode : QuizzImport
// Description
// Importe les enregistrements d'un quizz
//  exporté par QuizzExport
// ----------------------------------------------------
SET CHANNEL:C77(10; "")
If (OK=1)
	RECEIVE VARIABLE:C81($Var)
	If ($Var#"QuizzQuestionnaires")
		ALERT:C41("Désolé, il semble que le fichier importé ne soit pas le bon...")
	Else 
		READ WRITE:C146([QuizzQuestionnaires:35])
		ALL RECORDS:C47([QuizzQuestionnaires:35])
		DELETE SELECTION:C66([QuizzQuestionnaires:35])
		DEFAULT TABLE:C46([QuizzQuestionnaires:35])
		RECEIVE VARIABLE:C81($Var)
		While ($Var="une autre")
			RECEIVE RECORD:C79
			SAVE RECORD:C53
			$Var:=""
			RECEIVE VARIABLE:C81($Var)
		End while 
		// $Var="in"
		
		RECEIVE VARIABLE:C81($Var)
		// $Var="QuizzQuestions"
		READ WRITE:C146([QuizzQuestions:34])
		ALL RECORDS:C47([QuizzQuestions:34])
		DELETE SELECTION:C66([QuizzQuestions:34])
		DEFAULT TABLE:C46([QuizzQuestions:34])
		RECEIVE VARIABLE:C81($Var)
		While ($Var="une autre")
			RECEIVE RECORD:C79
			SAVE RECORD:C53
			$Var:=""
			RECEIVE VARIABLE:C81($Var)
		End while 
		// $Var="QuizzReponses"
		
		READ WRITE:C146([QuizzReponses:33])
		ALL RECORDS:C47([QuizzReponses:33])
		DELETE SELECTION:C66([QuizzReponses:33])
		DEFAULT TABLE:C46([QuizzReponses:33])
		RECEIVE VARIABLE:C81($Var)
		While ($Var="une autre")
			RECEIVE RECORD:C79
			SAVE RECORD:C53
			$Var:=""
			RECEIVE VARIABLE:C81($Var)
		End while 
		
		// $Var="QuizzPhotos"
		READ WRITE:C146([QuizzPhotos:36])
		ALL RECORDS:C47([QuizzPhotos:36])
		DELETE SELECTION:C66([QuizzPhotos:36])
		DEFAULT TABLE:C46([QuizzPhotos:36])
		RECEIVE VARIABLE:C81($Var)
		While ($Var="une autre")
			RECEIVE RECORD:C79
			SAVE RECORD:C53
			$Var:=""
			RECEIVE VARIABLE:C81($Var)
		End while 
	End if 
	SET CHANNEL:C77(11)
	ALERT:C41("Importation achevée")
End if 