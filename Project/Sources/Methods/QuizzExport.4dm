//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29.09.19, 07:08:30
  // ----------------------------------------------------
  // Méthode : QuizzExport
  // Description
  // Méthode qui exporte la totalité du quizz 
  //  à destination d'une base 4D si pas de paramètre
  //  et {$1} = Id du questionnaire à sauvegarder sinon
  //  sauvegarde tous les questionnaires
  //  et {$2} = contexte de la sauvegarde
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
$OC:=True:C214
$UnSeulQuestionnaire:=(Count parameters:C259>0)
If ($UnSeulQuestionnaire)
	$IdQuestionnaireA:=$1
	$IdQuestionnaireN:=Num:C11($IdQuestionnaireA)
	If (Count parameters:C259=2)
		$Action:="Sauvegarde à la demande de l'utilisateur"
		If ($2#"Sauvegarde@")
			$Mess:=Substring:C12($2;19)
			Case of 
				: ($Mess="QI@")  //  Insertion d'une question principale
					  // ALLER À ENREGISTREMENT([QuizzQuestions];NumEnrConcerné)
					$Pos:=Position:C15(".";[QuizzQuestions:34]CodeQuestion:5)
					$RangQuestionA:=Substring:C12([QuizzQuestions:34]CodeQuestion:5;($Pos+1))
					$Action:="Insertion d'une question principale avant la question "+$RangQuestionA
					$Action:=$Action+" : "+[QuizzQuestions:34]LibelQuestion:3
					
				: ($Mess="QS@")  //  Suppression d'une question
					  // ALLER À ENREGISTREMENT([QuizzQuestions];NumEnrConcerné)
					$Pos:=Position:C15(".";[QuizzQuestions:34]CodeQuestion:5)
					$CodeQuestion:=Substring:C12([QuizzQuestions:34]CodeQuestion:5;($Pos+1))
					$Action:="Suppression de question "+$CodeQuestion
					$Action:=$Action+" : "+[QuizzQuestions:34]LibelQuestion:3
					
				: ($Mess="QR@")  //  Ajout d'une réponse en bas de liste
					  // ALLER À ENREGISTREMENT([QuizzQuestions];NumEnrConcerné)
					$Action:="Ajout d'une réponse en bas de liste de la question "
					$Pos:=Position:C15(".";[QuizzQuestions:34]CodeQuestion:5)
					$CodeQuestion:=Substring:C12([QuizzQuestions:34]CodeQuestion:5;($Pos+1))
					$Action:=$Action+$CodeQuestion+" : "+[QuizzQuestions:34]LibelQuestion:3
					
					
				: ($Mess="RI@")  //  Insertion d'une réponse
					  // ALLER À ENREGISTREMENT([QuizzReponses];NumEnrConcerné)
					$Pos:=Position:C15(".";[QuizzReponses:33]CodeReponse:5)
					$CodeRéponse:=Substring:C12([QuizzReponses:33]CodeReponse:5;($Pos+1))
					$Action:="Insertion d'une réponse avant "+$CodeRéponse
					$Action:=$Action+" : "+[QuizzReponses:33]LibelReponse:3
					
				: ($Mess="RS@")  //  Suppression d'une question
					  // ALLER À ENREGISTREMENT([QuizzReponses];NumEnrConcerné)
					$Pos:=Position:C15(".";[QuizzReponses:33]CodeReponse:5)
					$CodeRéponse:=Substring:C12([QuizzReponses:33]CodeReponse:5;($Pos+1))
					$Action:="Suppression de la réponse "+$CodeRéponse
					$Action:=$Action+" : "+[QuizzReponses:33]LibelReponse:3
					
				: ($Mess="RQ@")  //  Ajout d'une question liée à la réponse
					  // ALLER À ENREGISTREMENT([QuizzReponses];NumEnrConcerné)
					$Pos:=Position:C15(".";[QuizzReponses:33]CodeReponse:5)
					$CodeRéponse:=Substring:C12([QuizzReponses:33]CodeReponse:5;($Pos+1))
					$Action:="Ajout d'une question liée à la réponse "+$CodeRéponse
					$Action:=$Action+" : "+[QuizzReponses:33]LibelReponse:3
					
				: ($Mess="EA@")  //  Ajout d'une question en fin de questionnaire
					$Action:="Ajout d'une question en fin de questionnaire"
			End case 
		End if 
	End if 
	  // le dossier de réception
	$CDDos:=Get 4D folder:C485(Dossier base:K5:14)+"RécupQuizz"+Séparateur dossier:K24:12
	If (Test path name:C476($CDDos)#Est un dossier:K24:2)
		CREATE FOLDER:C475($CDDos)
	End if 
	  // le fichier écrit
	$L:=Find in array:C230(<>TbQuestionnaireId;$IdQuestionnaireN)
	If ($L>0)
		$LibelQuestionnaire:=<>TbQuestionnaireTitre{$L}+" par "+<>TbQuestionnaireAuteur{$L}+"_"
		$NomCourt:="Sauve_"+$IdQuestionnaireA+"_"+Generate UUID:C1066+".txt"
		$CDFichier:=$CDDos+$NomCourt
	End if 
	$OC:=($L>0)
	SET CHANNEL:C77(12;$CDFichier)
Else 
	SET CHANNEL:C77(12;"")
End if 
If ($OC)
	<>MonBoolPasErreur:=True:C214
	ON ERR CALL:C155("aaaErreurVide")
	$Var:="QuizzQuestionnaires"
	SEND VARIABLE:C80($Var)
	If ($UnSeulQuestionnaire)
		QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=Num:C11($1))
	Else 
		ALL RECORDS:C47([QuizzQuestionnaires:35])
	End if 
	$FT:=Records in selection:C76([QuizzQuestionnaires:35])
	For ($Salé;1;$FT)
		$Var:="Une autre"
		SEND VARIABLE:C80($Var)
		SEND RECORD:C78([QuizzQuestionnaires:35])
		NEXT RECORD:C51([QuizzQuestionnaires:35])
	End for 
	$Var:="Fin"
	SEND VARIABLE:C80($Var)
	
	$Var:="QuizzQuestions"
	SEND VARIABLE:C80($Var)
	If ($UnSeulQuestionnaire)
		QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]CodeQuestion:5=($1+".@"))
	Else 
		ALL RECORDS:C47([QuizzQuestions:34])
	End if 
	$FT:=Records in selection:C76([QuizzQuestions:34])
	For ($Salé;1;$FT)
		$Var:="Une autre"
		SEND VARIABLE:C80($Var)
		SEND RECORD:C78([QuizzQuestions:34])
		NEXT RECORD:C51([QuizzQuestions:34])
	End for 
	
	
	$Var:="QuizzReponses"
	SEND VARIABLE:C80($Var)
	If ($UnSeulQuestionnaire)
		QUERY:C277([QuizzReponses:33];[QuizzReponses:33]CodeReponse:5=($1+".@"))
	Else 
		ALL RECORDS:C47([QuizzReponses:33])
	End if 
	$FT:=Records in selection:C76([QuizzReponses:33])
	For ($Salé;1;$FT)
		$Var:="Une autre"
		SEND VARIABLE:C80($Var)
		SEND RECORD:C78([QuizzReponses:33])
		NEXT RECORD:C51([QuizzReponses:33])
	End for 
	
	
	$Var:="QuizzPhotos"
	SEND VARIABLE:C80($Var)
	If ($UnSeulQuestionnaire)
		QUERY:C277([QuizzPhotos:36];[QuizzPhotos:36]CodePhoto:5=($1+".@"))
	Else 
		ALL RECORDS:C47([QuizzPhotos:36])
	End if 
	$FT:=Records in selection:C76([QuizzPhotos:36])
	For ($Salé;1;$FT)
		$Var:="Une autre"
		SEND VARIABLE:C80($Var)
		SEND RECORD:C78([QuizzPhotos:36])
		NEXT RECORD:C51([QuizzPhotos:36])
	End for 
	ON ERR CALL:C155("")
	
	If ($UnSeulQuestionnaire & <>MonBoolPasErreur) & (Application type:C494=4D Server:K5:6)
		
		CREATE RECORD:C68([DiaData:45])
		[DiaData:45]XNom:1:="Export données"
		[DiaData:45]XType:5:="ExportDonnées"
		[DiaData:45]XAlpha:14:=$NomCourt
		[DiaData:45]XEntier:2:=$IdQuestionnaireN
		[DiaData:45]XDate:3:=Current date:C33
		[DiaData:45]XHeure:13:=Current time:C178
		[DiaData:45]XTexte:7:=$CDFichier
		[DiaData:45]XTexteSup:8:=$Action
		SAVE RECORD:C53([DiaData:45])
	End if 
End if 
SET CHANNEL:C77(11)