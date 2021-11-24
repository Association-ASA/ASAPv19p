//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 06/10/19, 11:17:23
  // ----------------------------------------------------
  // Méthode : QuizzSuiteChoixMultipleSuite
  // Description
  //   Réaction au clic sur un bouton "Suite" dans un questionnaire multiple
  //
  // Paramètre : $1 = message AJAX de type "multiplelancequizz" + Id du bouton d'envoi + "£" + id des cases cochées séparées par une virgule + "£" + id de session
  //   Id du bouton d'envoi défini dans QuizzEcritHTMLQuestion ligne 165 comme "boutonenvoimulti"+$IdQuestionA
  // multiplelancequizzboutonenvoimulti1043£casequizz45,casequizz41,casequizz40,casequizz38,£ONIRISA9115AC2DA0E466188A6577C98AC551F
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$L;$L1;$L2;$L3;$ModeEval)
C_OBJECT:C1216($ObjetQuestion)
$Mess:=$1
ARRAY TEXT:C222($TbAjax;0)
ZTexteVersTableau ($Mess;->$TbAjax;"£")
$QuestionDirecte:=($TbAjax{1}="@*")
  // Quelles réponses ont été cochées ?
ARRAY TEXT:C222($TbCaseCocheA;0)
ZTexteVersTableau ($TbAjax{2};->$TbCaseCocheA;",")
$FT:=Size of array:C274($TbCaseCocheA)
ARRAY LONGINT:C221($TbCaseCocheN;$FT)
For ($Salé;1;$FT)
	$TbCaseCocheN{$Salé}:=Num:C11($TbCaseCocheA{$Salé})
End for 
QUERY WITH ARRAY:C644([QuizzReponses:33]ID:1;$TbCaseCocheN)
SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5;$TbCodeRepCoch\
;[QuizzReponses:33]ValeurReponse:6;$TbValRepCoch\
;[QuizzReponses:33]LibelReponse:3;$TbLibRepCoch\
;[QuizzReponses:33]ArgumentaireReponse:4;$TbArgRepCoch\
;[QuizzReponses:33]ID:1;$TbIdRepCoch)

$IDQuestionN:=Num:C11($TbAjax{1})  // élimination de "multiplelancequizzboutonenvoimulti"

  // Quelles réponses étaient-elles possible ?
QUERY:C277([QuizzReponses:33];[QuizzReponses:33]IDQuestion:2=$IDQuestionN)
SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5;$TbCodeRepPos\
;[QuizzReponses:33]ValeurReponse:6;$TbValRepPos\
;[QuizzReponses:33]LibelReponse:3;$TbLibRepPos\
;[QuizzReponses:33]ArgumentaireReponse:4;$TbArgRepPos\
;[QuizzReponses:33]Argument:7;$TbObjRepPos\
;[QuizzReponses:33]ID:1;$TbIdRepPos)
SORT ARRAY:C229($TbCodeRepPos;$TbValRepPos;$TbLibRepPos;$TbArgRepPos;$TbObjRepPos;$TbIdRepPos;>)
$L:=Find in array:C230(<>TbQuestionId;$IDQuestionN)
$IntituléQuestion:=<>TbQuestionLibelQuestion{$L}
$L:=Find in array:C230(<>TbQuestionnaireId;<>TbQuestionIdQuestionnaire{$L})
$Structure:=<>TbQuestionnaireInstitution{$L}

  // Ecrivons le HTML dans un tableau à raison d'une ligne par réponse
$FT:=Size of array:C274($TbIdRepPos)
ARRAY TEXT:C222($TbHTMLRéponses;$FT)
$NbBonnesRéponses:=0
$NbMauvaisesRéponses:=0
$Action:=""
ARRAY LONGINT:C221($TbNumQuestionAvecSuite;0)
$IdQuestionSuivante:=""
For ($Salé;1;$FT)
	$IntituléRéponseCourante:=$TbLibRepPos{$Salé}
	$THTMLTab:=""
	$L:=Find in array:C230($TbCaseCocheN;$TbIdRepPos{$Salé})
	If ($L>0)
		$LQS:=Find in array:C230(<>TbQuestionCodeQuestion;$TbCodeRepPos{$Salé})
		If ($LQS>0)
			APPEND TO ARRAY:C911($TbNumQuestionAvecSuite;<>TbQuestionId{$LQS})
		End if 
		$Action:=$Action+", "+$TbLibRepPos{$Salé}  // L'action à noter = case cochée
	End if 
	$BonneRéponse:=(($TbValRepPos{$Salé}#1) & ($L<0)) | (($TbValRepPos{$Salé}=1) & ($L>0))
	$Couleur:=(Num:C11($BonneRéponse)*"#00FF00")+(Num:C11(Not:C34($BonneRéponse))*"#FF0000")
	$CodeEmoticon:=(Num:C11($BonneRéponse)*"&#128515;")+(Num:C11(Not:C34($BonneRéponse))*"&#128545;")
	$THTMLTab:=$THTMLTab+"      <tr class="+<>ZGuil+"lignetableaurepmultiple"+<>ZGuil+">"+<>ZCR
	$CochNonCoch:=(Num:C11($TbValRepPos{$Salé}=1)*"<b>Cocher</b> la réponse ")+(Num:C11($TbValRepPos{$Salé}#1)*"<b>Ne pas cocher</b> la réponse ")
	$THTMLTab:=$THTMLTab+"       <td width="+<>ZGuil+"25%"+<>ZGuil+" class="+<>ZGuil+"centrevertical"+<>ZGuil+" >"+<>ZCR
	$THTMLTab:=$THTMLTab+"         "+$CochNonCoch+"<b>"+$IntituléRéponseCourante+"</b>"+<>ZCR
	$THTMLTab:=$THTMLTab+"       </td>"+<>ZCR
	$THTMLTab:=$THTMLTab+"       <td width="+<>ZGuil+"40%"+<>ZGuil+" class="+<>ZGuil+"centrevertical"+<>ZGuil+" >"+<>ZCR
	$THTMLTab:=$THTMLTab+"       "+Replace string:C233($TbArgRepPos{$Salé};<>ZCR;" <br />")+<>ZCR
	$THTMLTab:=$THTMLTab+"       </td>"+<>ZCR
	$CochNonCoch:=(Num:C11($L>0)*"Vous avez coché cette réponse ")+(Num:C11($L<0)*"Vous n'avez pas coché cette réponse ")
	$THTMLTab:=$THTMLTab+"       <td width="+<>ZGuil+"25%"+<>ZGuil+" class="+<>ZGuil+"centrevertical"+<>ZGuil+" >"+<>ZCR
	$THTMLTab:=$THTMLTab+"         "+$CochNonCoch+<>ZCR
	$THTMLTab:=$THTMLTab+"       </td>"+<>ZCR
	$THTMLTab:=$THTMLTab+"       <td width="+<>ZGuil+"10%"+<>ZGuil+" class="+<>ZGuil+"centrevertical"+<>ZGuil+" >"+<>ZCR
	$THTMLTab:=$THTMLTab+"         <span class="+<>ZGuil+"emoticon"+<>ZGuil+">"+$CodeEmoticon+"</span>"
	$THTMLTab:=$THTMLTab+"       </td>"+<>ZCR
	$THTMLTab:=$THTMLTab+"      </tr>"+<>ZCR
	
	  // Insertion éventuelle des images d'illustration
	ARRAY TEXT:C222($TbNumPhotosSup;0)
	OB GET ARRAY:C1229($TbObjRepPos{$Salé};"TbNumPhoto";$TbNumPhotosSup)
	If (Size of array:C274($TbNumPhotosSup)>0)
		ARRAY TEXT:C222($TbComPhotosSup;0)
		OB GET ARRAY:C1229($TbObjRepPos{$Salé};"TbComPhoto";$TbComPhotosSup)
		$THTMLTab:=$THTMLTab+"</table>"+<>ZCR  // On ferme le tableau 
		$SFT:=Size of array:C274($TbNumPhotosSup)
		$THTMLTab:=$THTMLTab+"        <div class="+<>ZGuil+"quizzphotosupmultiple"+<>ZGuil+">"+<>ZCR
		For ($Fumé;1;$SFT)
			$THTMLTab:=$THTMLTab+"         <div class="+<>ZGuil+"comphotor"+<>ZGuil+">"+<>ZCR
			$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos;Num:C11($TbNumPhotosSup{$Fumé}))
			If ($L>0)
				$NumPhotoA:=$TbNumPhotosSup{$Fumé}
			Else 
				$NumPhotoA:="Q"+$Structure+String:C10(Num:C11($TbNumPhotosSup{$Fumé});"00000")
			End if 
			$THTMLTab:=$THTMLTab+"          <img src="+<>ZGuil+"PhotosAsaDia/"+$NumPhotoA+"i.jpg"+<>ZGuil\
				+" alt="+<>ZGuil+"Photo n°"+$TbNumPhotosSup{$Fumé}+<>ZGuil\
				+" title="+<>ZGuil+"Photo n°"+$TbNumPhotosSup{$Fumé}+<>ZGuil\
				+" width="+<>ZGuil+"180px"+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil+" />"+<>ZCR
			$THTMLTab:=$THTMLTab+"          <p class="+<>ZGuil+"petittextel"+<>ZGuil+">"+<>ZCR
			$THTMLTab:=$THTMLTab+"           "+$TbComPhotosSup{$Fumé}+<>ZCR
			$THTMLTab:=$THTMLTab+"          </p>"+<>ZCR
			$THTMLTab:=$THTMLTab+"         </div>"+<>ZCR
		End for 
		$THTMLTab:=$THTMLTab+"        </div>"+<>ZCR
		$THTMLTab:=$THTMLTab+"        <table class="+<>ZGuil+"tablerepmultiple"+<>ZGuil+">"+<>ZCR
	End if 
	$TbHTMLRéponses{$Salé}:=$THTMLTab
	
End for 

$L:=Find in array:C230(<>TbQuestionId;$IDQuestionN)
$ObjetQuestion:=<>TbQuestionArgument{$L}
$IdQuestionnaire:=<>TbQuestionIdQuestionnaire{$L}
$ModeEval:=OB Get:C1224($ObjetQuestion;"ModeEvaluation";Est un entier long:K8:6)
$RetourALaQuestion:=($ModeEval>2)

$THTML:="    <p class="+<>ZGuil+"quizzquestion"+<>ZGuil+">"+<>ZCR
  //Si ($NbMauvaisesRéponses=0)
  //$THTML:=$THTML+"        <img src="+<>ZGuil+"images/Bravo.gif"+<>ZGuil+" /><br />"+<>ZCR
  //$THTML:=$THTML+"Félicitations <br /> Vous avez coché toutes les bonnes réponses."
  //Sinon 
  //$THTML:=$THTML+"        <img src="+<>ZGuil+"images/Erreur.gif"+<>ZGuil+" /><br />"+<>ZCR
  //$s:=Num($NbMauvaisesRéponses>1)*"s"
  //$THTML:=$THTML+"        Désolé, votre réponse n'est pas bonne car vous avez fait "
  //$THTML:=$THTML+Chaîne($NbMauvaisesRéponses)+" mauvaise"+$s+" réponse"+$s
  //$THTML:=$THTML+" sur "+Chaîne($FT)+" possibles"
  //Fin de si 
$THTML:=$THTML+"        La question était : "+$IntituléQuestion
$THTML:=$THTML+"        <br /><br />"
$THTML:=$THTML+"        Veuillez trouver ci-dessous le tableau des résultats pour les réponses proposées :<br /><br />"+<>ZCR
$THTML:=$THTML+"        <table class="+<>ZGuil+"tablerepmultiple"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <tr>"+<>ZCR
$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"25%"+<>ZGuil+">Ce qu'il fallait faire</th>"+<>ZCR
$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"40%"+<>ZGuil+">Argumentaire</th>"+<>ZCR
$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"25%"+<>ZGuil+">Ce que vous avez fait</th>"+<>ZCR
$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"10%"+<>ZGuil+">Evaluation</th>"+<>ZCR
$THTML:=$THTML+"        </tr>"+<>ZCR

For ($Salé;1;$FT)
	$THTML:=$THTML+$TbHTMLRéponses{$Salé}
End for 
$THTML:=$THTML+"        </table>"+<>ZCR
$THTML:=$THTML+"    </p>"+<>ZCR2

  // tests d'existence d'une question suivante
  // Y a t'il une question secondaire liée à la réponse ?
$L1:=-1
$Suite:=""
$FT:=Size of array:C274($TbCodeRepCoch)
For ($Fumé;1;$FT)
	If ($L1=-1)
		$L1:=Find in array:C230(<>TbQuestionCodeQuestion;$TbCodeRepCoch{$Fumé})
		If ($L1>0)
			$Suite:=String:C10(<>TbQuestionId{$L1})
		End if 
	End if 
End for 
$QuestionSecondaire:=($L1>0)

ARRAY TEXT:C222($TbIndicesChapitreCodeCourant;0)
QuizzOutilChapitreVersTableau ($TbCodeRepPos{1};->$TbIndicesChapitreCodeCourant)


  // Y a t'il une question principale suivante ?
$Test:=$TbIndicesChapitreCodeCourant{1}+"."+String:C10(Num:C11($TbIndicesChapitreCodeCourant{2})+1)
$L2:=Find in array:C230(<>TbQuestionCodeQuestion;$Test)
If ($L2>0)
	$Suite:=String:C10(<>TbQuestionId{$L2})
End if 


$THTML:=$THTML+"   <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
If ($QuestionDirecte)
	$THTML:=$THTML+"    <button id="+<>ZGuil+"retourbilan"+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Revenir au bilan</button>"+<>ZCR
	$THTML:=$THTML+"   </p>"
Else 
	VarIdSuivi:=$TbAjax{3}
	QUERY:C277([QuizzSuivi:32];[QuizzSuivi:32]IdSessionVisiteur:9=VarIdSuivi)
	ORDER BY:C49([QuizzSuivi:32];[QuizzSuivi:32]Ordre:8;<)
	QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=[QuizzSuivi:32]IDQuestionnaire:2)
	QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]ID:1=[QuizzSuivi:32]IDQuestion:7)
	$Action:="Réponses cochées : "+Substring:C12($Action;3)
	QuizzNoteSuivi ($Action;$1;VarIdSuivi;"";->$TbNumQuestionAvecSuite)
	  // Les boutons de suite
	If ($RetourALaQuestion)
		$THTML:=$THTML+"    <button id="+<>ZGuil+"retour"+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Revenir à la question précédente</button>"+<>ZCR
	End if 
	
	If ($L1>0) | ($L2>0)
		$THTML:=$THTML+"    <button id="+<>ZGuil+"suite"+$Suite+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Question suivante</button>"+<>ZCR
		$THTML:=$THTML+("<br />"*8)
		$THTML:=$THTML+"   </p>"
		$THTML:=$THTML+("<br />"*10)
	Else 
		$THTML:=$THTML+"   </p>"
		$THTML:=$THTML+"         <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"            <br /><br />FIN DU QUESTIONNAIRE<br /><br />"+<>ZCR
		$THTML:=$THTML+"         </p>"+<>ZCR
		QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
		RELATE MANY:C262([QuizzQuestionnaires:35]ID:1)  //Toutes les questions
		QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32];[QuizzSuivi:32]Argument:6;"ChaineAjax";=;"rep@";*)
		QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32]; | [QuizzSuivi:32]Argument:6;"ChaineAjax";=;"mul@";*)
		QUERY:C277([QuizzSuivi:32]; & [QuizzSuivi:32]IdSessionVisiteur:9=VarIdSuivi)
		$THTML:=$THTML+QuizzBilanPerformanceTb 
	End if 
End if 
  // FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)