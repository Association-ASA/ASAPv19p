//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 25/05/19, 08:07:22
  // ----------------------------------------------------
  // Méthode : QuizzEcritHTMLQuestion
  // Description
  // Méthode qui écrit le HTML de la question
  //   dont l'id est passé en paramètre
  // Paramètre : $1 = id de la question à afficher sur le Web
  // {$2} si existe, écrit la division quizzcorps et renvoie le HTML par AJAX

  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$L;$LDia)

$IdQuestionN:=$1
$EcritPartie:=False:C215
If (Count parameters:C259=2)
	$EcritPartie:=$2
End if 
$EcritTout:=Not:C34($EcritPartie)
$EnvoiDirect:=(Count parameters:C259=2) & ($EcritTout)
$IdQuestionA:=String:C10($IdQuestionN)
If (Count parameters:C259=2)
	QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]ID:1=$IdQuestionN)
End if 
$NumQuestionMultiple:=OB Get:C1224([QuizzQuestions:34]Argument:6;"ModeEvaluation";Est un entier long:K8:6)
$BoolQuestionMultiple:=($NumQuestionMultiple=2) | ($NumQuestionMultiple=4)
RELATE MANY:C262([QuizzQuestions:34]ID:1)  // rappel des réponses et des photos
$THTML:=""
If ($EcritTout)
	$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR2
	
	$THTML:=$THTML+" <head>"+<>ZCR
	$THTML:=$THTML+"  <title>Quizz</title>"+<>ZCR
	$THTML:=$THTML+"  <meta http-equiv="+<>ZGuil+"Content-Type"+<>ZGuil+" content="+<>ZGuil+"text/html; charset=UTF-8"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/style-asadia.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/evaluation.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/table.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/jquery-ui.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/multiple-select.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+"/>"+<>ZCR
	$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"styles/tooltip.css"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script>"+<>ZCR
	$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-ui.min.js"+<>ZGuil+"></script>"+<>ZCR
	  // $THTML:=$THTML+"  <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia.js"+<>ZGuil+"></script> <!--  jQuery AsaDia    -->"+<>ZCR
	$THTML:=$THTML+"  <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/evaluation.js"+<>ZGuil+"></script> <!-- jQuery du quizz    -->"+<>ZCR
	$THTML:=$THTML+"  <script>"+<>ZCR
	$THTML:=$THTML+"    $(function() {"+<>ZCR
	$THTML:=$THTML+"      $( document ).tooltip();"+<>ZCR
	$THTML:=$THTML+"    });"+<>ZCR
	$THTML:=$THTML+"  </script>"+<>ZCR
	$THTML:=$THTML+" </head>"+<>ZCR2
	
	$THTML:=$THTML+" <body>"+<>ZCR
	$THTML:=$THTML+"  <input id="+<>ZGuil+"languecourante"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil
	$THTML:=$THTML+" value="+<>ZGuil+"F"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  <div id="+<>ZGuil+"headerquizz"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"    <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"1024"+<>ZGuil+" id="+<>ZGuil+"AjaxDiagnoseF"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"    <br />Pour revenir à AsaDia, cliquez sur l'image ci-dessus<br /><br /><br />"+<>ZCR
	$THTML:=$THTML+"    <input id="+<>ZGuil+"quizzsuivi"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil
	$THTML:=$THTML+" value="+<>ZGuil+VarIdSuivi+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  </div>"+<>ZCR2
End if 
$L:=Find in array:C230(<>TbQuestionCodeQuestion;[QuizzQuestions:34]CodeQuestion:5)
$IDQuestionnaire:=<>TbQuestionIdQuestionnaire{$L}
$QuestionPrincipale:=<>TbQuestionQuestionPrincipale{$L}
$L:=Find in array:C230(<>TbQuestionnaireId;$IDQuestionnaire)
If ($EcritTout)
	$THTML:=$THTML+"  <div id="+<>ZGuil+"quizzcorps"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"      <br /><br />"+<>ZCR2
	
	$THTML:=$THTML+"      <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        Questionnaire : "+<>TbQuestionnaireTitre{$L}+" par "+<>TbQuestionnaireAuteur{$L}+"<br /><br />"+<>ZCR
	$THTML:=$THTML+"      </p>"+<>ZCR2
End if 


$THTML:=$THTML+"      <div  class="+<>ZGuil+"quizzquestion"+<>ZGuil+">"+<>ZCR

If ($QuestionPrincipale)
	$L:=Find in array:C230(<>TbQuestionnaireId;$IDQuestionnaire)
	NbreTotalQuestion:=<>TbQuestionnaireNbreQuestions{$L}
	ARRAY TEXT:C222(TbChapitre;0)
	QuizzOutilChapitreVersTableau ([QuizzQuestions:34]CodeQuestion:5;->TbChapitre)
	$LibelQuestion:="        Question "+TbChapitre{Size of array:C274(TbChapitre)}+" sur "+String:C10(NbreTotalQuestion)+" : "
Else 
	$L:=Find in array:C230(<>TbReponseCodeReponse;[QuizzQuestions:34]CodeQuestion:5)
	$LibelQuestion:="        Question suite à la réponse précédente "+<>ZGuil+<>TbReponseLibelReponse{$L}+<>ZGuil+" : "
End if 


$THTML:=$THTML+$LibelQuestion+[QuizzQuestions:34]LibelQuestion:3+"<br />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
SELECTION TO ARRAY:C260([QuizzPhotos:36]NumPhotoA:3;$TbPhotoNumPhotoA\
;[QuizzPhotos:36]CommentairePhoto:4;$TbPhotoCom\
;[QuizzPhotos:36]CodePhoto:5;$TbPhotoCode\
;[QuizzPhotos:36]ID:1;$TbPhotoId)
SORT ARRAY:C229($TbPhotoCode;$TbPhotoCom;$TbPhotoNumPhotoA;$TbPhotoId;>)

$FT:=Size of array:C274($TbPhotoId)
If ($FT>0)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">Cliquez sur la photographie pour l’afficher plein écran</p>"
	
	For ($Salé;1;$FT)
		$THTML:=$THTML+"           <div class="+<>ZGuil+"quizzblocphoto"+<>ZGuil+">"+<>ZCR
		$ComCourant:=$TbPhotoCom{$Salé}
		$NumPhotoCourant:=$TbPhotoNumPhotoA{$Salé}
		$LDia:=Find in array:C230(<>TbDiaposNumOrdreDiapos;Num:C11($NumPhotoCourant))
		If ($LDia>0)  // photo de la collection
			$IdCourante:=String:C10(<>TbNumEnrDiapos{$LDia})
			  // Duplication image pour éviter de lui donner le n° de la photo
			$DocSource:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"PhotosAsaDia"+Séparateur dossier:K24:12+$NumPhotoCourant+"i.jpg"
			$OK:=Test path name:C476($DocSource)
			$FinCible:="imagequizz"+String:C10($IdCourante)+"i.jpg"
			$CDDos:=<>PermCheDossierAsaDiaWeb+Séparateur dossier:K24:12+"ImagesQuizz"+Séparateur dossier:K24:12
			If (Test path name:C476($CDDos)#Est un dossier:K24:2)
				CREATE FOLDER:C475($CDDos)
			End if 
			$DocCible:=$CDDos+$FinCible
			If (Test path name:C476($DocCible)#Est un document:K24:1)
				COPY DOCUMENT:C541($DocSource;$DocCible)
			End if 
			$THTML:=$THTML+"             <img src="+<>ZGuil+"PhotosAsaDia/ImagesQuizz/"+$FinCible+<>ZGuil
		Else   // Photo ajoutée pour le Quizz
			$LDia:=Find in array:C230(<>TbQuizzNumPhotoA;$TbPhotoNumPhotoA{$Salé})
			$THTML:=$THTML+"             <img src="+<>ZGuil+"PhotosAsaDia/"+<>TbQuizzNumPhotoWA{$LDia}+"i.jpg"+<>ZGuil
		End if 
		$THTML:=$THTML+" alt="+<>ZGuil+"photo"+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil+" />"+<>ZCR
		$THTML:=$THTML+"             <br />"+$ComCourant+<>ZCR
		$THTML:=$THTML+"           </div>"
	End for 
End if 
$THTML:=$THTML+"        </p>"+<>ZCR
  // Modifié par : MBPASA2015 (21/04/2021)
$THTML:=$THTML+"        <div id="+<>ZGuil+"quizzreponse"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR  // pour recevoir les raisons d'un éventuel échec
$THTML:=$THTML+"      <div  class="+<>ZGuil+"quizzconsigne"+<>ZGuil+">Consigne :"+<>ZCR
$THTML:=$THTML+"        <p  class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR
If ($BoolQuestionMultiple)  // Questionnaire multiple
	$THTML:=$THTML+"         Cochez la case de chaque réponse qui vous parait être bonne.<br />"+<>ZCR
	$THTML:=$THTML+"         Cliquez sur le bouton "+<>ZGuil+"Envoyer les réponses"+<>ZGuil+".<br />"+<>ZCR
	  // $THTML:=$THTML+"         Le site vous posera les questions suivantes en fonction des réponses cochées.<br />"+<>ZCR
Else   // Questions simples
	$THTML:=$THTML+"         Cliquer sur la réponse qui vous parait être la bonne.<br />"+<>ZCR
End if 
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR
SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5;$TbCodeR;[QuizzReponses:33]LibelReponse:3;$TbLibelR;[QuizzReponses:33]ID:1;$TbIDR)
SORT ARRAY:C229($TbCodeR;$TbLibelR;$TbIDR;>)
$FT:=Size of array:C274($TbLibelR)
$Etoile:=Num:C11($EnvoiDirect)*"*"
For ($Salé;1;$FT)
	If ($BoolQuestionMultiple)  // Questionnaire multiple
		$THTML:=$THTML+"          <div class="+<>ZGuil+"quizzcasereponse"+<>ZGuil+">"+<>ZCR
		$Title:="Réponse "+String:C10($Salé)+" : "+$TbLibelR{$Salé}
		$THTML:=$THTML+"<input type="+<>ZGuil+"checkbox"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+"Cochez la case si la réponse vous paraît juste"+<>ZGuil
		$THTML:=$THTML+" id="+<>ZGuil+"casequizz"+String:C10($TbIDR{$Salé})+<>ZGuil+" /> "+$Title+<>ZCR
		$THTML:=$THTML+"          </div>"
	Else 
		$THTML:=$THTML+"          <div id="+<>ZGuil+"repquizz"+String:C10($TbIDR{$Salé})+$Etoile+<>ZGuil
		$THTML:=$THTML+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">"+<>ZCR
		  //$Title:="Réponse "+Chaîne($Salé)+" : "+$TbLibelR{$Salé}
		$Title:=$TbLibelR{$Salé}
		$THTML:=$THTML+"<img src="+<>ZGuil+"images/reponsepossible.png"+<>ZGuil
		$THTML:=$THTML+" id="+<>ZGuil+"imquizz"+String:C10($TbIDR{$Salé})+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" width="+<>ZGuil+"22px"+<>ZGuil+" /> "+$Title+<>ZCR
		$THTML:=$THTML+"          </div>"
	End if 
End for 
If ($BoolQuestionMultiple)  // Questionnaire multiple
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          <button id="+<>ZGuil+"boutonenvoimulti"+$IdQuestionA+$Etoile+<>ZGuil
	$THTML:=$THTML+" class="+<>ZGuil+"quizzreponse"+<>ZGuil+">Envoyer les réponses</button>"+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR
End if 
$THTML:=$THTML+"      </div>"+<>ZCR2
$THTML:=$THTML+"      <br /><br />"+<>ZCR
If ($EcritTout)
	$THTML:=$THTML+"  </div>"+<>ZCR
	$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"    <!--4dinclude piedF.shtml-->"+<>ZCR
	$THTML:=$THTML+"   </div>"+<>ZCR
	$THTML:=$THTML+" </body>"+<>ZCR
	$THTML:=$THTML+"</html>"
End if 
If ($EcritTout)
	$Nomshtml:="quizz"+Generate UUID:C1066+".shtml"
	$CDFichier:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$Nomshtml
	$Doc:=Create document:C266($CDFichier)
	SEND PACKET:C103($Doc;$THTML)
	CLOSE DOCUMENT:C267($Doc)
	$CDFichier:=Replace string:C233($CDFichier;Séparateur dossier:K24:12;"/")
	WEB SEND TEXT:C677($Nomshtml)
Else 
	WEB SEND TEXT:C677($THTML)
End if 
