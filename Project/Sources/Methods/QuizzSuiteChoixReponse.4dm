//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 26/05/19, 08:12:40
// ----------------------------------------------------
// Méthode : QuizzSuiteChoixReponse
// Description
//   Méthode qui écrit le HTML de la suite
//   à donner consécutivement à une réponse
// Paramètre : $1 = message AJAX  type "repquizz1_ASA9A5BCFBD0C424DF69CE6CB298C81430B"
// ----------------------------------------------------
C_LONGINT:C283($IDReponse; $NumEvaluation; $L1; $L2; $L3; $Pos; $Salé; $FT)
ARRAY LONGINT:C221($TbIdQuestionsRestantes; 0)

$Mess:=$1
$Retour:=(Count parameters:C259=2)
$Pos:=Position:C15("_"; $Mess)
$VarIdSuivi:=Substring:C12($Mess; ($Pos+1))
$Mess:=Substring:C12($Mess; 1; ($Pos-1))
$QuestionDirecte:=($Mess="@*")
$IDReponse:=Num:C11($Mess)
QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]ID:1=$IDReponse)
$ArgumentReponse:=[QuizzReponses:33]ArgumentaireReponse:4
$CodeReponse:=[QuizzReponses:33]CodeReponse:5
$LibeléRéponse:=[QuizzReponses:33]LibelReponse:3
$RéponseFausse:=([QuizzReponses:33]ValeurReponse:6#1)
ARRAY TEXT:C222($TbNumPhotosSup; 0)
OB GET ARRAY:C1229([QuizzReponses:33]Argument:7; "TbNumPhoto"; $TbNumPhotosSup)
ARRAY TEXT:C222($TbComPhotosSup; 0)
OB GET ARRAY:C1229([QuizzReponses:33]Argument:7; "TbComPhoto"; $TbComPhotosSup)
QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]ID:1=[QuizzReponses:33]IDQuestion:2)
$NumEvaluation:=OB Get:C1224([QuizzQuestions:34]Argument:6; "ModeEvaluation"; Est un entier long:K8:6)
$PossibleRetour:=($NumEvaluation>2)
QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=[QuizzQuestions:34]IDQuestionnaire:2)
QuizzNoteSuivi($LibeléRéponse; $1; $VarIdSuivi; $CodeReponse)

ARRAY TEXT:C222($TbIndicesChapitreCodeCourant; 0)
QuizzOutilChapitreVersTableau($CodeReponse; ->$TbIndicesChapitreCodeCourant)
//$Test:=$TbIndicesChapitreCodeCourant{1}+".@"
//CHERCHER([QuizzQuestions];[QuizzQuestions]CodeQuestion=$Test)
//SÉLECTION VERS TABLEAU([QuizzQuestions]CodeQuestion;$TbCodeQ;[QuizzQuestions]ID;$TbIdQ)
// Suites à donner
// Y a t'il une question secondaire liée à la réponse ?
$L1:=Find in array:C230(<>TbQuestionCodeQuestion; $CodeReponse)
// Y a t'il une question principale suivante ?
$Test:=$TbIndicesChapitreCodeCourant{1}+"."+String:C10(Num:C11($TbIndicesChapitreCodeCourant{2})+1)
$L2:=Find in array:C230(<>TbQuestionCodeQuestion; $Test)
// Y a t'il une question en reste d'une question multiple ?
OB GET ARRAY:C1229([QuizzSuivi:32]Argument:6; "TbQuestionsRestante"; $TbIdQuestionsRestantes)
$L3:=Size of array:C274($TbIdQuestionsRestantes)
Case of 
		
	: ($L1>0)
		$Suite:=String:C10(<>TbQuestionId{$L1})
		
	: ($L3>0)
		$Suite:=String:C10($TbIdQuestionsRestantes{1})
		
	: ($L2>0)
		$Suite:=String:C10(<>TbQuestionId{$L2})
		
End case 

Case of 
	: ([QuizzReponses:33]ValeurReponse:6=1)  // Bonne réponse
		//  on le félicite
		$THTML:="<img src="+<>ZGuil+"images/Bravo.gif"+<>ZGuil+" /><br />"+<>ZCR
		$THTML:=$THTML+"Félicitations <br /> Vous avez trouvé la bonne réponse."
		If ($ArgumentReponse#"")
			$THTML:=$THTML+"<br />La raison qui justifie cette réponse est : <br />"+<>ZCR
			$THTML:=$THTML+Replace string:C233($ArgumentReponse; <>ZCR; "<br />")
		End if 
		
	: ([QuizzReponses:33]ValeurReponse:6=2)  // Réponse ni bonne ni mauvaise
		//  on le félicite modestement
		$THTML:="<img src="+<>ZGuil+"images/Erreur.gif"+<>ZGuil+" /><br />"+<>ZCR
		$THTML:=$THTML+"Votre réponse n'est pas mauvaise <br /> Toutefois, elle aurait pû être meilleure ..."
		If ($ArgumentReponse#"")
			$THTML:=$THTML+"pour la raison suivante :<br />"+<>ZCR
			$THTML:=$THTML+Replace string:C233($ArgumentReponse; <>ZCR; "<br />")
		End if 
		
	: ([QuizzReponses:33]ValeurReponse:6=3)  // Mauvaise réponse
		$THTML:="<img src="+<>ZGuil+"images/Erreur.gif"+<>ZGuil+" /><br />"+<>ZCR
		$THTML:=$THTML+"Désolé, votre réponse est fausse..."
		If ($ArgumentReponse#"")
			$THTML:=$THTML+" pour la raison suivante :<br />"+<>ZCR
			$THTML:=$THTML+Replace string:C233($ArgumentReponse; <>ZCR; "<br />")
		End if 
	Else   // réponse non valorisée
		// Trace
End case 
// existe -t-il des photos d'explication ?
$FT:=Size of array:C274($TbComPhotosSup)
$THTML:=$THTML+"<br /><br />"
For ($Salé; 1; $FT)
	$NumPhotoSupA:=$TbNumPhotosSup{$Salé}
	$L:=Find in array:C230(<>TbNumDia; Num:C11($NumPhotoSupA))
	$PhotoCollection:=($L>0)
	$THTML:=$THTML+"           <div class="+<>ZGuil+"comphotor"+<>ZGuil+"> "+<>ZCR
	$Title:="Photo n°"+$NumPhotoSupA
	If ($PhotoCollection)
		$NomPhotoSup:=$NumPhotoSupA
		$Triplette:=DiaWebAfficheTriplette($L; "F")  // la triplette
	Else   // Photo pour le quizz
		$LDiaQuizz:=Find in array:C230(<>TbQuizzNumPhotoA; $NumPhotoSupA)
		$NomPhotoSup:="Q"+<>TbQuizzStructurePhoto{$LDiaQuizz}+String:C10(<>TbQuizzNumPhotoN{$LDiaQuizz}; "00000")
		$Triplette:=""
	End if 
	$THTML:=$THTML+"            <img src="+<>ZGuil+"PhotosAsaDia/"+$NomPhotoSup+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil
	$THTML:=$THTML+" title="+<>ZGuil+$Title+<>ZGuil+" width="+<>ZGuil+"180px"+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil+" />"+<>ZCR
	
	$THTML:=$THTML+"             <p class="+<>ZGuil+"petittextel"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"              "+Replace string:C233($TbComPhotosSup{$Salé}; <>ZCR; " <br />")+<>ZCR
	$THTML:=$THTML+"             </p>"+<>ZCR
	$THTML:=$THTML+"           </div>"+<>ZCR
	//$THTML:=$THTML+"           <div class="+<>ZGuil+"comphotor"+<>ZGuil+"> <!-- le commentaire souhaité de la photo 1    -->"+<>ZCR
	//$THTML:=$THTML+"                           "+<>ZCR
	//$THTML:=$THTML+"           </div>"+<>ZCR
	//$THTML:=$THTML+"           <div class="+<>ZGuil+"comphotor"+<>ZGuil+"> <!-- le commentaire souhaité de la photo 1    -->"+<>ZCR
	//$THTML:=$THTML+"              <span class="+<>ZGuil+"petittexter"+<>ZGuil+">"+$TbComPhotosSup{$Salé}+"</span>"+<>ZCR
	//$THTML:=$THTML+"              <br />"+<>ZCR
	//$THTML:=$THTML+"           </div>"+<>ZCR
End for 


$THTML:=$THTML+"<br /><br />"
// Ecriture du HTML des boutons
If ($QuestionDirecte)
	$THTML:=$THTML+"   <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"    <button id="+<>ZGuil+"retourbilan"+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Revenir au bilan</button>"+<>ZCR
	$THTML:=$THTML+"   </p>"
Else 
	Case of 
		: ($L1>0)  //  On propose la question secondaire suivante
			$THTML:=$THTML+"  <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
			If ($PossibleRetour & $RéponseFausse)
				$THTML:=$THTML+"    <button id="+<>ZGuil+"retour"+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">"
				$THTML:=$THTML+"     Revenir à la question précédente"
				$THTML:=$THTML+"    </button>"+<>ZCR
			End if 
			If ($NumEvaluation#5) | (Not:C34($RéponseFausse))
				$THTML:=$THTML+"    <button id="+<>ZGuil+"suite"+$Suite+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">"+"Question suivante"+"</button>"+<>ZCR
			End if 
			$THTML:=$THTML+"  </p>"+<>ZCR
			
		: ($L2>0)  //  On passe à la question principale suivante
			$THTML:=$THTML+"  <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
			If ($PossibleRetour & $RéponseFausse)
				$THTML:=$THTML+"    <button id="+<>ZGuil+"retour"+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Revenir à la question précédente</button>"+<>ZCR
			End if 
			If ($NumEvaluation#5) | (Not:C34($RéponseFausse))
				$THTML:=$THTML+"    <button id="+<>ZGuil+"suite"+$Suite+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">"+"Question suivante"+"</button>"+<>ZCR
			End if 
			$THTML:=$THTML+"  </p>"+<>ZCR
			
		: ($L3>0)  //  On passe à la question résiduelle du questionnaire multiple
			$THTML:=$THTML+"  <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
			If ($PossibleRetour & $RéponseFausse)
				$THTML:=$THTML+"    <button id="+<>ZGuil+"retour"+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Revenir à la question précédente</button>"+<>ZCR
			End if 
			$THTML:=$THTML+"    <button id="+<>ZGuil+"suite"+$Suite+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">"+"Question suivante"+"</button>"+<>ZCR
			$THTML:=$THTML+"  </p>"+<>ZCR
			
	End case 
	
	If (($L1+$L2+$L3)=-2) & Not:C34($PossibleRetour & $RéponseFausse)  // Plus rien à faire...
		$THTML:=$THTML+"<br /><br />FIN DU QUESTIONNAIRE"
		RELATE MANY:C262([QuizzQuestionnaires:35]ID:1)  //Toutes les questions
		QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32]; [QuizzSuivi:32]Argument:6; "ChaineAjax"; =; "rep@"; *)
		QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32];  | [QuizzSuivi:32]Argument:6; "ChaineAjax"; =; "mul@"; *)
		QUERY:C277([QuizzSuivi:32];  & [QuizzSuivi:32]IdSessionVisiteur:9=$VarIdSuivi)
		$THTML:=$THTML+QuizzBilanPerformanceTb  // le bilan
	Else 
		If ($NumEvaluation=5) & (($L1+$L2+$L3)=-2)
			$THTML:=$THTML+"    <button id="+<>ZGuil+"retour"+<>ZGuil+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Revenir à la question précédente</button>"+<>ZCR
		End if 
	End if 
End if 

//FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)