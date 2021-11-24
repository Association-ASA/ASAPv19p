// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 27/01/20, 05:25:40
// ----------------------------------------------------
// Méthode : DlgQuizz.BouExportTexte
// Description
// Méthode qui écrit sur le bureau le texte du questionnaire
//   dans un fichier codé Mac
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$Pas:=2*" "
$EspaceDebut:=4*" "
ARRAY TEXT:C222(PUMValeur; 4)
PUMValeur{1}:="Réponse unique sans retour possible"
PUMValeur{2}:="Réponse multiple sans retour possible"
PUMValeur{3}:="Réponse unique avec retour possible"
PUMValeur{4}:="Réponse multiple avec retour possible"

$NumEnrQuestionnaire:=TbNumEnrQuestionnaire{PUMQuestionnaire}
GOTO RECORD:C242([QuizzQuestionnaires:35]; $NumEnrQuestionnaire)
$Rapport:="Questionnaire "+[QuizzQuestionnaires:35]Titre:3+" par "+[QuizzQuestionnaires:35]Auteur:2+<>ZCR
ARRAY TEXT:C222($TbThème; 0)
OB GET ARRAY:C1229([QuizzQuestionnaires:35]Argument:5; "TbObjectifs"; $TbThème)
$Rapport:=$Rapport+"Objectifs : "+ZTableauVersTexte(->$TbThème)+<>ZCR
$Test:=String:C10([QuizzQuestionnaires:35]ID:1)+".@"
QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5=$Test)
SELECTION TO ARRAY:C260([QuizzReponses:33]Argument:7; $TbArgumentReponse\
; [QuizzReponses:33]ArgumentaireReponse:4; $TbArgumentaireReponse\
; [QuizzReponses:33]CodeReponse:5; $TbCodeReponse\
; [QuizzReponses:33]ID:1; $TbIdReponse\
; [QuizzReponses:33]IDQuestion:2; $TbReponseIDQuestion\
; [QuizzReponses:33]LibelReponse:3; $TbLibelReponse\
; [QuizzReponses:33]ValeurReponse:6; $TbValeurReponse)
SORT ARRAY:C229($TbCodeReponse; $TbArgumentReponse; $TbArgumentaireReponse; $TbIdReponse; $TbReponseIDQuestion; $TbLibelReponse; $TbValeurReponse; >)

$FT:=Size of array:C274($TbCodeReponse)
For ($Fumé; 1; $FT)
	$L:=Find in array:C230(<>TbQuestionId; $TbReponseIDQuestion{$Fumé})
	If ($L>0)
		$CodeQuestion:=<>TbQuestionCodeQuestion{$L}
		
		$Pos:=Position:C15("."; $CodeQuestion)
		$ResteCode:=Substring:C12($CodeQuestion; ($Pos+1))
		$Pos:=Position:C15("."; $ResteCode)
		$QuestionPrincipale:=($Pos=0)
		$Pos:=Position:C15("."; $TbCodeReponse{$Fumé})
		$RéponseCodeCourant:=Substring:C12($TbCodeReponse{$Fumé}; ($Pos+1))
		$RéponseIdCourantN:=$TbIdReponse{$Fumé}
		$RéponseIdCourantA:=String:C10($RéponseIdCourantN)
		$RéponseArgumentaireCourant:=$TbArgumentaireReponse{$Fumé}
		$RéponseIDQuestionCourantN:=$TbReponseIDQuestion{$Fumé}
		$RéponseIDQuestionCourantA:=String:C10($RéponseIDQuestionCourantN)
		$RéponseLibelCourant:=$TbLibelReponse{$Fumé}
		$ValeurCouranteReponseN:=$TbValeurReponse{$Fumé}
		// GESTION DE LA QUESTION
		If ($RéponseCodeCourant="@1")  // le code se terminant par 1 => nouvelle question
			ARRAY TEXT:C222($TbDecritChapitres; 0)
			ZTexteVersTableau($RéponseCodeCourant; ->$TbDecritChapitres; ".")
			$QuestionPrincipale:=(Size of array:C274($TbDecritChapitres)=2)
			$Pos:=Position:C15("."; <>TbQuestionCodeQuestion{$L})
			$Rapport:=$Rapport+"Question "+Substring:C12(<>TbQuestionCodeQuestion{$L}; ($Pos+1))+" : "+<>TbQuestionLibelQuestion{$L}+<>ZCR
			If (OB Is defined:C1231(<>TbQuestionArgument{$L}; "ModeEvaluation"))
				$ModeEVal:=OB Get:C1224(<>TbQuestionArgument{$L}; "ModeEvaluation"; Est un entier long:K8:6)
			Else 
				$ModeEVal:=1
			End if 
			$Rapport:=$Rapport+"Mode d'évaluation : "+PUMValeur{$ModeEVal}+<>ZCR
			
			// GESTION DES PHOTOS
			$IDQuestionN:=$TbReponseIDQuestion{$Fumé}
			$IDQuestionA:=String:C10($IDQuestionN)
			QUERY:C277([QuizzPhotos:36]; [QuizzPhotos:36]IDQuestion:2=$IDQuestionN)  // recherche d'éventuelles photos
			SELECTION TO ARRAY:C260([QuizzPhotos:36]CodePhoto:5; $TbCodePhoto\
				; [QuizzPhotos:36]CommentairePhoto:4; $TbComPhoto\
				; [QuizzPhotos:36]ID:1; $TbIdPhoto\
				; [QuizzPhotos:36]NumPhotoA:3; $TbNumPhotoA)
			SORT ARRAY:C229($TbCodePhoto; $TbComPhoto; $TbNumPhotoA; $TbIdPhoto; >)
			$Rapport:=$Rapport+"N° des photos associées : "+ZTableauVersTexte(->$TbNumPhotoA; " ")+<>ZCR
			$SFT:=Size of array:C274($TbNumPhotoA)
			For ($Salé; 1; $SFT)
				$Rapport:=$Rapport+"Photo n°"+$TbNumPhotoA{$Salé}+<>ZCR
				$L:=Find in array:C230(<>TbNumDia; Num:C11($TbNumPhotoA{$Salé}))
				$Triplette:=DiaWebAfficheTriplette($L; "F")
				$Rapport:=$Rapport+$Triplette+<>ZCR
				$Rapport:=$Rapport+"Commentaire à faire figurer sous la photo "+$TbNumPhotoA{$Salé}+" lors du questionnaire : "+<>ZCR
				$Rapport:=$Rapport+$TbComPhoto{$Salé}+<>ZCR
			End for 
		End if   // Fin de la gestion de la question et de ses photos
		
		// la réponse
		$Indentation:=Length:C16($TbCodeReponse{$Fumé})*$Pas
		// le libellé
		$Rapport:=$Rapport+$Indentation+"Réponse "+$RéponseCodeCourant+" : "+$RéponseLibelCourant+<>ZCR
		// la valeur de la réponse : pour l'instant bonne (1) incomplète(2) ou mauvaise(3)
		$Rapport:=$Rapport+"Valeur de la réponse : "+String:C10($ValeurCouranteReponseN)+" "+PUMValeur{$ValeurCouranteReponseN}+<>ZCR
		// l'argument
		$Rapport:=$Rapport+"Thèmes à évaluer dans cette réponse :"+<>ZCR
		$SFT:=Size of array:C274($TbThème)
		ARRAY TEXT:C222($TbObjectifsRéponse; 0)
		OB GET ARRAY:C1229($TbArgumentReponse{$Fumé}; "TbObjectifs"; $TbObjectifsRéponse)
		$CompteurTheme:=0
		For ($Salé; 1; $SFT)
			$Valeur:=$TbThème{$Salé}
			If ($Valeur#"")
				$CompteurTheme:=$CompteurTheme+1
				If (Find in array:C230($TbObjectifsRéponse; $Valeur)>0)
					$Rapport:=$Rapport+$Valeur+"      "
				End if 
			End if 
		End for 
		$Rapport:=$Rapport+<>ZCR+"Commentaire suite à la réponse "+$RéponseCodeCourant+" :"+<>ZCR+$RéponseArgumentaireCourant+<>ZCR
	End if 
	
End for 
SET TEXT TO PASTEBOARD:C523($Rapport)
