//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/12/19, 15:37:02
  // ----------------------------------------------------
  // Méthode : QuizzBilanPerformance
  // Description
  //   Méthode qui permet d'automatiser le bilan 
  //   de la session Web d'un visieur pour un questionnaire
  //   et le renvoie sous forme détaillée
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)

If (Macintosh command down:C546)
	QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=1)
	QUERY:C277([QuizzSuivi:32];[QuizzSuivi:32]IdSessionVisiteur:9="ASADE87B7F43AEF4AEC91F57A998A5650DB")
End if 
  // recueil de tous les objectifs
ARRAY TEXT:C222($TbThème;0)
OB GET ARRAY:C1229([QuizzQuestionnaires:35]Argument:5;"TbObjectifs";$TbThème)
$TT:=Size of array:C274($TbThème)
ARRAY LONGINT:C221($TbOccurrence;0)  // La note optimale
ARRAY LONGINT:C221($TbOccurrence;$TT)
  // Etablissement de la performance optimale
  // Sélection des bonnes réponses
$Test:=String:C10([QuizzQuestionnaires:35]ID:1)+".@"
QUERY:C277([QuizzReponses:33];[QuizzReponses:33]CodeReponse:5=$Test;*)
QUERY:C277([QuizzReponses:33]; & [QuizzReponses:33]ValeurReponse:6=1)
ARRAY OBJECT:C1221($TbArgumentReponse;0)
SELECTION TO ARRAY:C260([QuizzReponses:33]Argument:7;$TbArgumentReponse)
$FT:=Size of array:C274($TbArgumentReponse)
For ($Salé;1;$FT)
	ARRAY TEXT:C222($TbOjectifs;0)
	OB GET ARRAY:C1229($TbArgumentReponse{$Salé};"TbObjectifs";$TbOjectifs)
	$SFT:=Size of array:C274($TbOjectifs)
	For ($Fumé;1;$SFT)
		$L:=Find in array:C230($TbThème;$TbOjectifs{$Fumé})
		If ($L>0)
			$TbOccurrence{$L}:=$TbOccurrence{$L}+1
		End if 
	End for 
End for 

  // forme du bilan : Pour l'objectif la performance X [$TbTheme] est Y (bonne, moyenne insuffisante) 
  //  fondée sur [$TbOccurrence] pour les raisons suivantes 
  // Bonne réponse + mauvais réponse avec raison et énoncé de la bonne réponse
ORDER BY:C49([QuizzSuivi:32];[QuizzSuivi:32]Ordre:8;>)
SELECTION TO ARRAY:C260([QuizzSuivi:32]Action:5;$TbAction\
;[QuizzSuivi:32]Argument:6;$TbArgument\
;[QuizzSuivi:32]DateDebut:3;$TbDateDebut\
;[QuizzSuivi:32]HeureDebut:4;$TbHeureDebut\
;[QuizzSuivi:32]ID:1;$TbIDSuivi\
;[QuizzSuivi:32]IDQuestion:7;$TbIDQuestion\
;[QuizzSuivi:32]IDQuestionnaire:2;$TbIDQuestionnaire\
;[QuizzSuivi:32]IdSessionVisiteur:9;$TbIdSessionVisiteur\
;[QuizzSuivi:32]Ordre:8;$TbOrdrer\
;[QuizzSuivi:32]ValeurReponse:10;$TbValeurReponse)

ARRAY TEXT:C222($TbNumReponseOK;0)  // Le tableau synchronisé avec $TbTheme et $TbOccurrence des réposnse exactes
ARRAY TEXT:C222($TbNumReponseKO;0)  // Le tableau synchronisé avec $TbTheme et $TbOccurrence des réposnse exactes
ARRAY TEXT:C222($TbNumReponseOK;Size of array:C274($TbThème))
ARRAY TEXT:C222($TbNumReponseKO;Size of array:C274($TbThème))
ARRAY REAL:C219($TbScoreNegatif;Size of array:C274($TbThème))

$FT:=Size of array:C274($TbIDSuivi)
For ($Salé;1;$FT)
	$Ajax:=OB Get:C1224($TbArgument{$Salé};"ChaineAjax";Est un texte:K8:3)
	$IDReponse:=-1
	$Pos:=Position:C15("_";$Ajax)
	If ($Pos>0)
		$IDReponse:=Num:C11(Substring:C12($Ajax;1;($Pos-1)))
	End if 
	Case of 
		: ($Ajax="rep@")
			QUERY:C277([QuizzReponses:33];[QuizzReponses:33]ID:1=$IDReponse)
			ARRAY TEXT:C222($TbObjectifsRéponse;0)
			OB GET ARRAY:C1229([QuizzReponses:33]Argument:7;"TbObjectifs";$TbObjectifsRéponse)
			$SFT:=Size of array:C274($TbObjectifsRéponse)
			If ($TbValeurReponse{$Salé}>1)  // C'est une réponse mauvaise de type unique
				$IDQuestion:=$TbIDQuestion{$Salé}
				
				For ($Fumé;1;$SFT)
					$L:=Find in array:C230($TbThème;$TbObjectifsRéponse{$Fumé})
					  // gestion des retours
					If ($FT>$Salé)  // On n'est pas sur le dernier suivi
						$Ajax2:=OB Get:C1224($TbArgument{$Salé+1};"ChaineAjax";Est un texte:K8:3)
						If ($Ajax2="ret@")
							QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]ID:1=$IDQuestion)
							RELATE MANY:C262([QuizzQuestions:34]ID:1)
							$NbReponsePossible:=Records in selection:C76([QuizzReponses:33])
							$OnTrouve:=False:C215
							$CompteurErreur:=0
							$NumQuestion:=$TbIDQuestion{$Salé}
							While ($FT>$Salé) & ($NumQuestion=$TbIDQuestion{$Salé})
								$Salé:=$Salé+1
								If ($OnTrouve=False:C215) & ($TbValeurReponse{$Salé}>1)
									$CompteurErreur:=$CompteurErreur+1
								End if 
								$L:=Find in array:C230($TbThème;$TbObjectifsRéponse{$Fumé})
								Case of 
									: ($TbValeurReponse{$Salé}=1)
										$OnTrouve:=True:C214
										$TbNumReponseOK{$L}:=$TbNumReponseOK{$L}+String:C10($IDReponse)+($CompteurErreur*"*")+","
									: ($TbValeurReponse{$Salé}>1)
										$TbNumReponseKO{$L}:=$TbNumReponseKO{$L}+String:C10($IDReponse)+","
								End case 
							End while 
							$TbScoreNegatif{$l}:=$TbScoreNegatif{$l}-(0.5-(0.5*($CompteurErreur/$NbReponsePossible)))
							$TbNumReponseKO{$L}:=$TbNumReponseKO{$L}+String:C10($IDReponse)+","
						Else 
							$TbScoreNegatif{$l}:=$TbScoreNegatif{$l}-1
							$TbNumReponseKO{$L}:=$TbNumReponseKO{$L}+String:C10($IDReponse)+","
						End if 
					Else 
						$TbScoreNegatif{$l}:=$TbScoreNegatif{$l}-1
						$TbNumReponseKO{$L}:=$TbNumReponseKO{$L}+String:C10($IDReponse)+","
					End if 
				End for 
			Else 
				For ($Fumé;1;$SFT)
					$L:=Find in array:C230($TbThème;$TbObjectifsRéponse{$Fumé})
					$TbNumReponseOK{$L}:=$TbNumReponseOK{$L}+String:C10($IDReponse)+","
				End for 
			End if 
			
		: ($Ajax="mul@")  // C'est une réponse type multiple 
			  // où ajax est de type "multiplelancequizz£casequizz66,casequizz67,casequizz297521,_ASA0A98570EAE114422BE64B50BBC4036A1"
			$Pos:=Position:C15("£";$Ajax)
			$CaseQuizz:=Substring:C12($Ajax;($Pos+1))
			$Pos:=Position:C15("_";$CaseQuizz)
			$CaseQuizz:=Substring:C12($CaseQuizz;1;($Pos-1))
			ARRAY TEXT:C222($TbCase;0)
			ZTexteVersTableau ($CaseQuizz;->$TbCase;",")
			$SFT:=Size of array:C274($TbCase)
			For ($Fumé;1;$SFT)
				$IDReponse:=Num:C11($TbCase{$Fumé})
				QUERY:C277([QuizzReponses:33];[QuizzReponses:33]ID:1=$IDReponse)
				If ([QuizzReponses:33]ValeurReponse:6>1)
					ARRAY TEXT:C222($TbObjectifsRéponse;0)
					OB GET ARRAY:C1229([QuizzReponses:33]Argument:7;"TbObjectifs";$TbObjectifsRéponse)
					$SFT:=Size of array:C274($TbObjectifsRéponse)
					For ($Sec;1;$SFT)
						$L:=Find in array:C230($TbThème;$TbObjectifsRéponse{$Sec})
						$TbScoreNegatif{$l}:=$TbScoreNegatif{$l}-1
						$TbNumReponseKO{$L}:=$TbNumReponseKO{$L}+String:C10($IDReponse)+","
					End for 
					
				End if 
			End for 
	End case 
	
End for 

  // Quels sont les thèmes réellement évalués ?
$FT:=Size of array:C274($TbNumReponseOK)
$Domaine:=""
For ($Salé;$FT;1;-1)
	If ($TbNumReponseOK{$Salé}="") & ($TbNumReponseKO{$Salé}="")  // Ni bonne ni mauvaise évaluation
		DELETE FROM ARRAY:C228($TbNumReponseOK;$Salé)
		DELETE FROM ARRAY:C228($TbNumReponseKO;$Salé)
		DELETE FROM ARRAY:C228($TbThème;$Salé)
	End if 
End for 
$Domaine:=ZTableauVersTexte (->$TbThème;", ")+"."



$THTML:="<br /><br /><p class="+<>Zguil+"textebilan"+<>Zguil+">"
$THTML:=$THTML+"<b>Bilan de vos réponses au questionnaire</b>:<br />"
$THTML:=$THTML+"Le questionnaire a permis de tester vos connaissances dans les domaines suivants : "+$Domaine+"<br /><br />"
$FT:=Size of array:C274($TbThème)
For ($Salé;1;$FT)
	$THTML:=$THTML+"<b>Pour le thème "+$TbThème{$Salé}+"</b><br />"
	ARRAY TEXT:C222($TbIdReponseKOA;0)
	ZTexteVersTableau ($TbNumReponseKO{$Salé};->$TbIdReponseKOA;",")
	ARRAY TEXT:C222($TbIdReponseOKA;0)
	ZTexteVersTableau ($TbNumReponseOK{$Salé};->$TbIdReponseOKA;",")
	If ($TbNumReponseKO{$Salé}="")
		$AlaAux:=(Num:C11(Size of array:C274($TbNumReponseOK)>1)*" aux questions ")
		$AlaAux:=$AlaAux+(Num:C11(Size of array:C274($TbNumReponseOK)=1)*" à la question ")
		$THTML:=$THTML+"vous avez bien répondu"+$AlaAux+"concernant ce thème."
	Else 
		  // éventuelles réponses correctes
		If ($TbNumReponseOK{$Salé}#"")
			$SFT:=Size of array:C274($TbIdReponseOKA)
			$QuestionRéponseOKOK:=""
			$QuestionRéponseKOOK:=""
			For ($Fumé;1;$SFT)
				$IdReponse:=Num:C11($TbIdReponseOKA{$Fumé})
				QUERY:C277([QuizzReponses:33];[QuizzReponses:33]ID:1=$IdReponse)
				QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]ID:1=[QuizzReponses:33]IDQuestion:2)
				If (Find in array:C230($TbIdReponseKOA;$TbIdReponseOKA{$Fumé})<0)
					$QuestionRéponseOKOK:=$QuestionRéponseOKOK+", "+<>Zguil+[QuizzQuestions:34]LibelQuestion:3+<>Zguil
				Else 
					$QuestionRéponseKOOK:=$QuestionRéponseKOOK+", "+<>Zguil+[QuizzQuestions:34]LibelQuestion:3+<>Zguil
				End if 
			End for 
			$QuestionRéponse:=Substring:C12($QuestionRéponse;3)
			If ($QuestionRéponseKOOK="")
				$THTML:=$THTML+"vous avez bien répondu à "+<>Zguil+$QuestionRéponseOKOK+<>Zguil
			Else 
				$THTML:=$THTML+"vous avez finalement trouvé la bonne réponse à "+<>Zguil+$QuestionRéponseKOOK+<>Zguil
			End if 
			$THTML:=$THTML+".<br />"
		End if 
		
		  // réponses incorrectes
		$SFT:=Size of array:C274($TbIdReponseKOA)
		$QuestionRéponse:=""
		For ($Fumé;1;$SFT)
			$IdReponse:=Num:C11($TbIdReponseKOA{$Fumé})
			QUERY:C277([QuizzReponses:33];[QuizzReponses:33]ID:1=$IdReponse)
			QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]ID:1=[QuizzReponses:33]IDQuestion:2)
			
			$QuestionRéponse:=$QuestionRéponse+", "+<>ZGuil+[QuizzQuestions:34]LibelQuestion:3+<>ZGuil
			$QuestionRéponse:=$QuestionRéponse+" où vous avez répondu "+<>ZGuil+[QuizzReponses:33]LibelReponse:3+<>ZGuil
			RELATE MANY:C262([QuizzQuestions:34]ID:1)  // rappel de toutes les réponses
			SELECTION TO ARRAY:C260([QuizzReponses:33]LibelReponse:3;$TbLibelRéponse;[QuizzReponses:33]ValeurReponse:6;$TbValeurReponse)
			
			$TT:=Size of array:C274($TbLibelRéponse)
			$NombreBonnesReponses:=0
			$IntitléRéponseExacte:=""
			For ($Sec;1;$TT)
				If ($TbValeurReponse{$Sec}=1)
					$NombreBonnesReponses:=$NombreBonnesReponses+1
					$IntitléRéponseExacte:=$IntitléRéponseExacte+", "+$TbLibelRéponse{$Sec}
				End if 
			End for 
			$IntitléRéponseExacte:=Substring:C12($IntitléRéponseExacte;3)
			$AuraiesentAurai:=(Num:C11($NombreBonnesReponses=0)*" alors qu'il n'y avait pas de bonne réponse")
			$AuraiesentAurai:=$AuraiesentAurai+(Num:C11($NombreBonnesReponses=1)*" alors que la bonne réponse était ")
			$AuraiesentAurai:=$AuraiesentAurai+(Num:C11($NombreBonnesReponses>1)*" alors que les bonnes réponses étaient ")
			$QuestionRéponse:=$QuestionRéponse+$AuraiesentAurai+<>ZGuil+$IntitléRéponseExacte+<>ZGuil
		End for 
		If ($NombreBonnesReponses<2)
			$QuestionRéponse:=Substring:C12($QuestionRéponse;3)
			$THTML:=$THTML+"vous avez mal répondu à la question "+$QuestionRéponse+".<br />"
		End if 
	End if 
	$THTML:=$THTML+"<br /><br />"
	
End for 
$THTML:=$THTML+"<br /><br /></p>"

$0:=$THTML