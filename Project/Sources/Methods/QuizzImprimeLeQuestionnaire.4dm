//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 12/11/21, 18:34:30
// ----------------------------------------------------
// Méthode : QuizzImprimeLeQuestionnaire
// Description
// Méthode qui imprime le questionnaire courant
//  désigné par son ID passée en paramètre  
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $ModeEvaluationN; $IdQuestionnaire; $L; $H)
C_PICTURE:C286(VarImage1; VarImage2; VarImage3; VarImage4; VarImage5)
C_TEXT:C284($1)
$IdQuestionnaire:=Num:C11($1)
VarContexteImpression:=""

// Impression de l'en-tête du questionnaire
$L:=Find in array:C230(<>TbQuestionnaireId; $IdQuestionnaire)
VarTitre:=<>TbQuestionnaireTitre{$L}
$NomAuteur:=<>TbQuestionnaireAuteur{$L}
$Institution:=<>TbQuestionnaireInstitution{$L}
VarSousTitre:="Questionnaire "+$Institution+" créé par "+$NomAuteur
ARRAY TEXT:C222($TbObjectifs; 0)
OB GET ARRAY:C1229(<>TbQuestionnaireArgument{$L}; "TbObjectifs"; $TbObjectifs)
VarObjectifs:="Objectifs du questionnaire : "+ZTableauVersTexte(->$TbObjectifs; ", ")+"."
$H:=Print form:C5("ImpressionQuestionnaire"; 0; 100)

// Impression des questions et des réponses
QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]IDQuestionnaire:2=$IdQuestionnaire)
SELECTION TO ARRAY:C260([QuizzQuestions:34]CodeQuestion:5; $TbCodeQuestion\
; [QuizzQuestions:34]ID:1; $TbIdQuestion)
SORT ARRAY:C229($TbCodeQuestion; $TbIdQuestion; >)
$FT:=Size of array:C274($TbCodeQuestion)
ARRAY TEXT:C222($PUMValeur; 5)
$PUMValeur{1}:="réponse unique sans retour possible"
$PUMValeur{2}:="réponse multiple sans retour possible"
$PUMValeur{3}:="réponse unique avec retour possible"
$PUMValeur{4}:="réponse multiple avec retour possible"
$PUMValeur{5}:="réponse unique avec bonne réponse obligatoire"
For ($Salé; 1; $FT)
	// Impression de la question
	$L:=Find in array:C230(<>TbQuestionCodeQuestion; $TbCodeQuestion{$Salé})
	$IDQuestionN:=<>TbQuestionId{$L}
	$ModeEvaluationN:=OB Get:C1224(<>TbQuestionArgument{$L}; "ModeEvaluation"; Est un entier long:K8:6)
	$ModeEvaluationN:=$ModeEvaluationN+Num:C11($ModeEvaluationN=0)
	VarQuestion:="Question n°"+String:C10($Salé)+" : "+<>TbQuestionLibelQuestion{$L}+" ("+$PUMValeur{$ModeEvaluationN}+")."
	VarContexteImpression:="ImpQuestion"
	$H:=Print form:C5("ImpressionQuestionnaire")
	
	// Impression des photos
	QUERY:C277([QuizzPhotos:36]; [QuizzPhotos:36]IDQuestion:2=$IDQuestionN)
	SELECTION TO ARRAY:C260([QuizzPhotos:36]NumPhotoA:3; $TbPhotoNumPhotoA\
		; [QuizzPhotos:36]CommentairePhoto:4; $TbPhotoCom\
		; [QuizzPhotos:36]CodePhoto:5; $TbPhotoCode\
		; [QuizzPhotos:36]ID:1; $TbPhotoId)
	SORT ARRAY:C229($TbPhotoCode; $TbPhotoCom; $TbPhotoNumPhotoA; $TbPhotoId; >)
	$TT:=Size of array:C274($TbPhotoCode)
	$CompteurPrincipal:=1
	While ($CompteurPrincipal<=$TT)
		For ($Fumé; 1; 5)
			$PtImage:=Get pointer:C304("VarPhoto"+String:C10($Fumé))
			$PtCom:=Get pointer:C304("VarCom"+String:C10($Fumé))
			$PtImage->:=<>VarImageVide
			$PtCom->:=""
			If ($CompteurPrincipal<=$TT)
				// L'image
				If (Find in array:C230(<>TbDiaposNumOrdreDiapos; Num:C11($TbPhotoNumPhotoA{$CompteurPrincipal}))>0)  // la photo appartient à la collection AsaDia
					$NomFichierImage:=<>PermCheDossierAsaDiaWeb+$TbPhotoNumPhotoA{$CompteurPrincipal}+"i.jpg"
				Else   // QAbattoir00023i.jpg <>TbQuizzNumPhotoA   <>TbQuizzNumPhotoWA
					$L:=Find in array:C230(<>TbQuizzNumPhotoA; $TbPhotoNumPhotoA{$CompteurPrincipal})
					$NomFichierImage:=<>PermCheDossierAsaDiaWeb+<>TbQuizzNumPhotoWA{$L}+"i.jpg"
				End if 
				READ PICTURE FILE:C678($NomFichierImage; $PtImage->)
				// le commentaire
				$PtCom->:=$TbPhotoCom{$CompteurPrincipal}
			End if 
			$CompteurPrincipal:=$CompteurPrincipal+1
		End for 
		$H:=Print form:C5("ImpressionQuestionnaire"; 235; 372)
	End while 
	
	// Impression des réponses
	ARRAY TEXT:C222($PUMEvaluation; 4)
	$PUMEvaluation{1}:="réponse non évaluée"
	$PUMEvaluation{2}:="bonne réponse"
	$PUMEvaluation{3}:="réponse incomplète"
	$PUMEvaluation{4}:="mauvaise réponse"
	QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]IDQuestion:2=$TbIdQuestion{$Salé})
	SELECTION TO ARRAY:C260([QuizzReponses:33]ArgumentaireReponse:4; $TbArgumentaireRéponse\
		; [QuizzReponses:33]Argument:7; $TbArgumentRéponse\
		; [QuizzReponses:33]CodeReponse:5; $TbCodeRéponse\
		; [QuizzReponses:33]LibelReponse:3; $TbLibelRéponse\
		; [QuizzReponses:33]ValeurReponse:6; $TbValeurRéponse)
	SORT ARRAY:C229($TbCodeRéponse; $TbArgumentaireRéponse; $TbArgumentRéponse; $TbLibelRéponse; $TbValeurRéponse; >)
	$SFT:=Size of array:C274($TbCodeRéponse)
	$Emoji:=(Num:C11($ModeEvaluationN%2=1)*"1F518")+(Num:C11($ModeEvaluationN%2=0)*"1F532")
	VarEmoji:=Emoji($Emoji)  // 128280  ou 0x1F518 =bouton radio 🔘    |  128306 ou 0x1F532 =Case à cocher 🔲
	For ($Fumé; 1; $SFT)
		VarRéponse:=$TbLibelRéponse{$Fumé}+" ("+$PUMEvaluation{$TbValeurRéponse{$Fumé}+1}+")."
		VarContexteImpression:="ImpRéponse"
		$H:=Print form:C5("ImpressionQuestionnaire")
		VarArgumentaire:="Argumentaire : "+$TbArgumentaireRéponse{$Fumé}
		VarContexteImpression:="ImpArgumentaire"
		$H:=Print form:C5("ImpressionQuestionnaire")
		// les éventuelles photos d'explication qui sont dans [QuizzReponses]Argument.TbNumPhotos avec le commentaire [QuizzReponses]Argument.TbComPhotos
		ARRAY TEXT:C222($TbComPhotos; 0)
		OB GET ARRAY:C1229($TbArgumentRéponse{$Fumé}; "TbComPhoto"; $TbComPhotos)
		$STT:=Size of array:C274($TbComPhotos)
		If ($STT>0)
			ARRAY TEXT:C222($TbNomPhotosA; 0)
			OB GET ARRAY:C1229($TbArgumentRéponse{$Fumé}; "TbNumPhoto"; $TbNomPhotosA)
			$CompteurPrincipal:=1
			While ($CompteurPrincipal<=$STT)
				For ($Sec; 1; 5)
					$PtImage:=Get pointer:C304("VarPhoto"+String:C10($Sec))
					$PtCom:=Get pointer:C304("VarCom"+String:C10($Sec))
					$PtImage->:=<>VarImageVide
					$PtCom->:=""
					If ($CompteurPrincipal<=$STT)
						// L'image
						If (Find in array:C230(<>TbDiaposNumOrdreDiapos; Num:C11($TbNomPhotosA{$CompteurPrincipal}))>0)  // la photo appartient à la collection AsaDia
							$NomFichierImage:=<>PermCheDossierAsaDiaWeb+$TbNomPhotosA{$CompteurPrincipal}+"i.jpg"
						Else   // QAbattoir00023i.jpg <>TbQuizzNumPhotoA   <>TbQuizzNumPhotoWA
							$L:=Find in array:C230(<>TbQuizzNumPhotoA; $TbNomPhotosA{$CompteurPrincipal})
							$NomFichierImage:=<>PermCheDossierAsaDiaWeb+<>TbQuizzNumPhotoWA{$L}+"i.jpg"
						End if 
						READ PICTURE FILE:C678($NomFichierImage; $PtImage->)
						// le commentaire
						$PtCom->:=$TbComPhotos{$CompteurPrincipal}
					End if 
					$CompteurPrincipal:=$CompteurPrincipal+1
				End for 
				$H:=Print form:C5("ImpressionQuestionnaire"; 235; 372)
			End while 
		End if 
	End for 
	$H:=Print form:C5("ImpressionQuestionnaire"; 2000; 2020)
	
End for 
