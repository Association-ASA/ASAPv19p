//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/04/19, 11:56:55
  // ----------------------------------------------------
  // Méthode : QuizzEcritHTMLCdF
  // Description
  //   Méthode qui écrit le chemin de fer
  //    de [QuizzQuestionnaires] courant
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($Fumé;$TT;$Salé;$FT)

$THTML:=""
$Pas:=<>ZInsec*2
$EspaceDebut:=4*" "
RELATE MANY:C262([QuizzQuestionnaires:35]ID:1)  // Rappel des questions
ARRAY OBJECT:C1221($TbQuestionArgument;0)
SELECTION TO ARRAY:C260([QuizzQuestions:34]LibelQuestion:3;$TbLibelQuestion\
;[QuizzQuestions:34]IDReponseMere:4;$TbIDReponseMere\
;[QuizzQuestions:34]ID:1;$TbQuestionIdQuestion\
;[QuizzQuestions:34]Argument:6;$TbQuestionArgument\
;[QuizzQuestions:34]CodeQuestion:5;$TbCodeQuestion)

  // SÉLECTION RETOUR([QuizzReponses]IDQuestion)  // rappel de toutes les réponses du questionnaire 

  // ou 
$TestCode:=String:C10([QuizzQuestionnaires:35]ID:1)+".@"
QUERY:C277([QuizzReponses:33];[QuizzReponses:33]CodeReponse:5=$TestCode)
ARRAY OBJECT:C1221($TbArgumentReponse;0)
SELECTION TO ARRAY:C260([QuizzReponses:33]Argument:7;$TbArgumentReponse\
;[QuizzReponses:33]ArgumentaireReponse:4;$TbArgumentaireReponse\
;[QuizzReponses:33]CodeReponse:5;$TbCodeReponse\
;[QuizzReponses:33]ID:1;$TbIdReponse\
;[QuizzReponses:33]IDQuestion:2;$TbReponseIDQuestion\
;[QuizzReponses:33]LibelReponse:3;$TbLibelReponse\
;[QuizzReponses:33]ValeurReponse:6;$TbValeurReponse)
  // fabrication du tableau de tri $TbCodeReponseTri permettant d'avoir plus de 9 réponses
$TT:=Records in selection:C76([QuizzReponses:33])
ARRAY TEXT:C222($TbCodeReponseTri;$TT)
For ($Salé;1;$TT)
	ARRAY TEXT:C222($TbChapitre;0)
	QuizzOutilChapitreVersTableau ($TbCodeReponse{$Salé};->$TbChapitre)
	$SFT:=Size of array:C274($TbChapitre)
	For ($Fumé;1;$SFT)
		$TbChapitre{$Fumé}:=String:C10(Num:C11($TbChapitre{$Fumé});"000")
	End for 
	$TbCodeReponseTri{$Salé}:=ZTableauVersTexte (->$TbChapitre;".")
End for 
SORT ARRAY:C229($TbCodeReponseTri;$TbCodeReponse;$TbArgumentReponse;$TbArgumentaireReponse;$TbIdReponse;$TbReponseIDQuestion;$TbLibelReponse;$TbValeurReponse;>)

  // existe t'il qu'une seule question principale ?
$Test:=String:C10([QuizzQuestionnaires:35]ID:1)+".2@"
$QuestionsPrincipalesMultiples:=(Find in array:C230($TbCodeReponse;$Test)>0)
$THTML:=""
$THTML:=$THTML+"      <div id="+<>ZGuil+"annoncequestionnaire"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <div id="+<>ZGuil+"annonce1"+<>ZGuil+">"+<>ZCR
$Title:="Voir le questionnaire sur le Web"
$THTML:=$THTML+"          "+$Title+"  <img src="+<>ZGuil+"images/oeil.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil\
+" title="+<>ZGuil+$Title+<>ZGuil+" id="+<>ZGuil+"oeil"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil+" class="+<>ZGuil+"curseurbouton"+<>ZGuil\
+" width="+<>ZGuil+"18px"+<>ZGuil+" />  <br /><br /><br />"+<>ZCR

$Title:="Afficher le mode plan ou détaillé"
$THTML:=$THTML+"          "+$Title+"  <img src="+<>ZGuil+"images/trianglehaut.jpeg"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil\
+" title="+<>ZGuil+$Title+<>ZGuil+" id="+<>ZGuil+"ModePlan"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil+" class="+<>ZGuil+"curseurbouton"+<>ZGuil\
+" width="+<>ZGuil+"18px"+<>ZGuil+" />  <br /><br /><br />"+<>ZCR

$Title:="Imprimer le questionnaire"
$THTML:=$THTML+"          "+$Title+"  <img src="+<>ZGuil+"images/IMPDF.GIF"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil\
+" title="+<>ZGuil+$Title+<>ZGuil+" id="+<>ZGuil+"ImpQuest"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil+" class="+<>ZGuil+"curseurbouton"+<>ZGuil\
+" width="+<>ZGuil+"18px"+<>ZGuil+" />  <br /><br /><br />"+<>ZCR

$Title:="Sauvegarder le questionnaire"
$THTML:=$THTML+"          "+$Title+"  <img src="+<>ZGuil+"images/Detail.PNG"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" hight="+<>ZGuil+"15px"+<>ZGuil+" width="+<>ZGuil+"15px"+<>ZGuil\
+" title="+<>ZGuil+$Title+<>ZGuil+" id="+<>ZGuil+"Sauvegarde"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil+" class="+<>ZGuil+"curseurbouton"+<>ZGuil\
+" width="+<>ZGuil+"18px"+<>ZGuil+" />  <br /><br /><br />"+<>ZCR

$Title:="Voir l'historique du questionnaire"
$THTML:=$THTML+"          "+$Title+"  <img src="+<>ZGuil+"images/Poubelle.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" hight="+<>ZGuil+"18px"+<>ZGuil+" width="+<>ZGuil+"13px"+<>ZGuil\
+" title="+<>ZGuil+$Title+<>ZGuil+" id="+<>ZGuil+"Histoire"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil+" class="+<>ZGuil+"curseurbouton"+<>ZGuil\
+" width="+<>ZGuil+"18px"+<>ZGuil+" />  <br /><br /><br /><br /><br /><br />"+<>ZCR

$Title:="Ajouter une question en bas de ce questionnaire"
$THTML:=$THTML+"          "+$Title+" <img src="+<>ZGuil+"images/Chemin de fer plus.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil\
+" title="+<>ZGuil+$Title+<>ZGuil+" id="+<>ZGuil+"EA"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil\
+" width="+<>ZGuil+"24px"+<>ZGuil+" />  "+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"annonce2"+<>ZGuil+">"+<>ZCR
ARRAY TEXT:C222($TbThème;0)
OB GET ARRAY:C1229([QuizzQuestionnaires:35]Argument:5;"TbObjectifs";$TbThème)
$THTML:=$THTML+"         Objectifs du questionnaire : <span class="+<>ZGuil+"textenews"+<>ZGuil+"> (séparés par un retour chariot)</span><br/>"+<>ZCR
$PlaceHolder:="Entrer ici les thèmes, à évaluer par le questionnaire, séparés par des retours à la ligne (exemple Abcès du foie)"
$THTML:=$THTML+"         <textarea  id="+<>ZGuil+"objectifs"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"areaobjectifs"+<>ZGuil+" placeholder="+<>ZGuil+$PlaceHolder+<>ZGuil+">"
$THTML:=$THTML+ZTableauVersTexte (->$TbThème)+"</textarea>"+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR

For ($Fumé;1;$TT)
	$L:=Find in array:C230($TbQuestionIdQuestion;$TbReponseIDQuestion{$Fumé})
	If ($L>0)
		$CodeQuestion:=$TbCodeQuestion{$L}
		
		$Pos:=Position:C15(".";$CodeQuestion)
		$ResteCode:=Substring:C12($CodeQuestion;($Pos+1))
		$Pos:=Position:C15(".";$ResteCode)
		$QuestionPrincipale:=($Pos=0)
		$Pos:=Position:C15(".";$TbCodeReponse{$Fumé})
		$RéponseCodeCourant:=Substring:C12($TbCodeReponse{$Fumé};($Pos+1))
		$RéponseIdCourantN:=$TbIdReponse{$Fumé}
		$RéponseIdCourantA:=String:C10($RéponseIdCourantN)
		$RéponseArgumentaireCourant:=$TbArgumentaireReponse{$Fumé}
		$RéponseIDQuestionCourantN:=$TbReponseIDQuestion{$Fumé}
		$RéponseIDQuestionCourantA:=String:C10($RéponseIDQuestionCourantN)
		$RéponseLibelCourant:=$TbLibelReponse{$Fumé}
		$ValeurCouranteReponseN:=$TbValeurReponse{$Fumé}
		If ($RéponseCodeCourant="@1")  // le code se terminant par 1 => nouvelle question
			$L:=Find in array:C230($TbQuestionIdQuestion;$RéponseIDQuestionCourantN)
			$IndentationQ:=Length:C16($RéponseCodeCourant)*$Pas
			ARRAY TEXT:C222($TbDecritChapitres;0)
			ZTexteVersTableau ($RéponseCodeCourant;->$TbDecritChapitres;".")
			$QuestionPrincipale:=(Size of array:C274($TbDecritChapitres)=2)
			$Class:="champquestion"+(Num:C11(Not:C34($QuestionPrincipale))*"secondaire")
			$THTML:=$THTML+"     <p class="+<>ZGuil+$Class+<>ZGuil+">"
			$Pos:=Position:C15(".";$TbCodeQuestion{$L})
			$Placeholder:=Num:C11($TbLibelQuestion{$L}="")*(" placeholder="+<>ZGuil+"Saisir le libellé de la question "+Substring:C12($TbCodeQuestion{$L};($Pos+1))+<>ZGuil)
			$Bold:=Num:C11($QuestionPrincipale)*"<b>"
			$FinBold:=Num:C11($QuestionPrincipale)*"</b>"
			$Lien:=Num:C11(Not:C34($QuestionPrincipale))*"liée à la réponse "
			$Décalage:=Num:C11(Not:C34($QuestionPrincipale))*"   "
			$THTML:=$THTML+$IndentationQ+$Bold+$Décalage+"Question "+$Lien+Substring:C12($TbCodeQuestion{$L};($Pos+1))+" : "+$FinBold
			$THTML:=$THTML+"       <textarea  id="+<>ZGuil+"QL"+String:C10($TbQuestionIdQuestion{$L})+<>ZGuil+" class="+<>ZGuil+"champquizz"+<>ZGuil+$Placeholder+">"
			$THTML:=$THTML+$TbLibelQuestion{$L}+"</textarea>"+<>ZCR
			
			If ($QuestionPrincipale)
				$Title:="insérer une question"
				$THTML:=$THTML+"      <img src="+<>ZGuil+"images/Chemin de fer égal.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
				$THTML:=$THTML+" id="+<>ZGuil+"QI"+$RéponseIDQuestionCourantA+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil+" width="+<>ZGuil+"24px"+<>ZGuil+" /> "+<>ZCR
			End if 
			
			If ($QuestionsPrincipalesMultiples & $QuestionPrincipale) | (Not:C34($QuestionPrincipale))
				$Title:="supprimer la question"
				$THTML:=$THTML+"     <img src="+<>ZGuil+"images/Chemin de fer moins.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
				$THTML:=$THTML+" id="+<>ZGuil+"QS"+$RéponseIDQuestionCourantA+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil+" width="+<>ZGuil+"24px"+<>ZGuil+" />  "+<>ZCR
			End if 
			
			$Title:="ajouter une réponse"
			$THTML:=$THTML+"      <img src="+<>ZGuil+"images/Chemin de fer plus.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
			$THTML:=$THTML+" id="+<>ZGuil+"QR"+$RéponseIDQuestionCourantA+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil+" width="+<>ZGuil+"24px"+<>ZGuil+" />"+<>ZCR
			
			  //Si ($QuestionPrincipale)  // le mode d'évaluation
			If (OB Is defined:C1231($TbQuestionArgument{$L};"ModeEvaluation"))
				$ModeEVal:=OB Get:C1224($TbQuestionArgument{$L};"ModeEvaluation";Est un entier long:K8:6)
			Else 
				$ModeEVal:=1
			End if 
			$THTML:=$THTML+"     <select id="+<>ZGuil+"MdE"+$CodeQuestion+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
			  //  <option selected value="ff">FireFox</option>
			$Selected:=Num:C11($ModeEVal<2)*"selected "
			$THTML:=$THTML+"       <option "+$Selected+"value="+<>ZGuil+String:C10(1)+<>ZGuil+" >Réponse unique sans retour possible</option>"+<>ZCR
			$Selected:=Num:C11($ModeEVal=2)*"selected "
			$THTML:=$THTML+"       <option "+$Selected+"value="+<>ZGuil+String:C10(2)+<>ZGuil+" >Réponse multiple sans retour possible</option>"+<>ZCR
			$Selected:=Num:C11($ModeEVal=3)*"selected "
			$THTML:=$THTML+"       <option "+$Selected+"value="+<>ZGuil+String:C10(3)+<>ZGuil+" >Réponse unique avec retour possible</option>"+<>ZCR
			$Selected:=Num:C11($ModeEVal=4)*"selected "
			$THTML:=$THTML+"       <option "+$Selected+"value="+<>ZGuil+String:C10(4)+<>ZGuil+" >Réponse multiple avec retour possible</option>"+<>ZCR
			$Selected:=Num:C11($ModeEVal=5)*"selected "
			$THTML:=$THTML+"       <option "+$Selected+"value="+<>ZGuil+String:C10(5)+<>ZGuil+" >Réponse unique avec bonne réponse obligatoire</option>"+<>ZCR
			$THTML:=$THTML+"     </select>"
			  //Fin de si 
			$THTML:=$THTML+"      <br /> <br />"
			$THTML:=$THTML+"     </p>"
			  // GESTION DES PHOTOS
			  // Ecriture de la div
			$THTML:=$THTML+"  <div class="+<>ZGuil+"textebanalgrand"+<>ZGuil+" id="+<>ZGuil+"LPP"+$RéponseIDQuestionCourantA+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+QuizzEcritHTMLPhotos ($RéponseIDQuestionCourantN)
			$THTML:=$THTML+"  </div>"+<>ZCR2
			
		End if 
		
		
		
		  // la réponse
		$Indentation:=Length:C16($TbCodeReponse{$Fumé})*$Pas
		  // le libellé
		$THTML:=$THTML+$Indentation+"<i>Réponse "+$RéponseCodeCourant+" : </i>"+<>ZCR
		$Placeholder:=Num:C11($RéponseLibelCourant="")*(" placeholder="+<>ZGuil+"Saisir le libellé de la réponse "+$RéponseCodeCourant+<>ZGuil)
		$THTML:=$THTML+"<textarea  id="+<>ZGuil+"RT"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"champquizz"+<>ZGuil+$Placeholder+">"
		$THTML:=$THTML+$RéponseLibelCourant+"</textarea>"+<>ZCR
		  // ses boutons
		  //$Title:="Cacher le détail de la réponse"
		  //$THTML:=$THTML+" <img src="+<>ZGuil+"images/Chemin de fer dormeur.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
		  //$THTML:=$THTML+" id="+<>ZGuil+"RV"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"imagevisu"+<>ZGuil+" width="+<>ZGuil+"24px"+<>ZGuil+" />  "+($Pas*2)+<>ZCR
		$Title:="insérer une réponse"
		$THTML:=$THTML+" <img src="+<>ZGuil+"images/Chemin de fer égal.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
		$THTML:=$THTML+" id="+<>ZGuil+"RI"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil+" width="+<>ZGuil+"24px"+<>ZGuil+" />  "+<>ZCR
		$Title:="supprimer la réponse"
		$THTML:=$THTML+" <img src="+<>ZGuil+"images/Chemin de fer moins.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
		$THTML:=$THTML+" id="+<>ZGuil+"RS"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil+" width="+<>ZGuil+"24px"+<>ZGuil+" />  "+<>ZCR
		$Title:="ajouter une question la réponse"
		$THTML:=$THTML+$Pas+" <img src="+<>ZGuil+"images/Chemin de fer plus.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
		$THTML:=$THTML+" id="+<>ZGuil+"RQ"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil+" width="+<>ZGuil+"24px"+<>ZGuil+" />"+<>ZCR
		  // la valeur de la réponse : pour l'instant bonne (1) incomplète(2) ou mauvaise(3)
		$VCR:=$ValeurCouranteReponseN
		$Checked0:=Num:C11($VCR=0)*(" selected="+<>ZGuil+"true"+<>ZGuil)
		$Checked1:=Num:C11($VCR=1)*(" selected="+<>ZGuil+"true"+<>ZGuil)
		$Checked2:=Num:C11($VCR=2)*(" selected="+<>ZGuil+"true"+<>ZGuil)
		$Checked3:=Num:C11($VCR=3)*(" selected="+<>ZGuil+"true"+<>ZGuil)
		$THTML:=$THTML+"<select  id="+<>ZGuil+"RV"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"selectquizz"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"  <option"+$Checked0+" value="+<>ZGuil+"0"+<>ZGuil+">Réponse non évaluée</option>"+<>ZCR
		$THTML:=$THTML+"  <option"+$Checked1+" value="+<>ZGuil+"1"+<>ZGuil+">Bonne réponse</option>"+<>ZCR
		$THTML:=$THTML+"  <option"+$Checked2+" value="+<>ZGuil+"2"+<>ZGuil+">Réponse incomplète</option>"+<>ZCR
		$THTML:=$THTML+"  <option"+$Checked3+" value="+<>ZGuil+"3"+<>ZGuil+">Mauvaise réponse</option>"+<>ZCR
		$THTML:=$THTML+"</select><br />"+<>ZCR
		  // l'argument
		$IndentationCom:=$Indentation+((19+Length:C16($TbCodeReponse{$Fumé}))*<>ZInsec)
		  // Modifié par : iMacASA2017 (21/09/2019)
		$THTML:=$THTML+"      <div id="+<>ZGuil+"LPP"+$TbCodeReponse{$Fumé}+<>ZGuil+">"+<>ZCR  // Fin de modif iMacASA2017 (21/09/2019)
		  // Modifié par : iMacASA2017 (19/12/2019) : ajout des thèmes d'évaluation
		$THTML:=$THTML+"<span class="+<>ZGuil+"textetheme"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"  <b>Thèmes à évaluer dans cette réponse</b> :"+<>ZCR
		$FT:=Size of array:C274($TbThème)
		ARRAY TEXT:C222($TbObjectifsRéponse;0)
		OB GET ARRAY:C1229($TbArgumentReponse{$Fumé};"TbObjectifs";$TbObjectifsRéponse)
		$CompteurTheme:=0
		For ($Salé;1;$FT)
			$Valeur:=$TbThème{$Salé}
			If ($Valeur#"")
				$CompteurTheme:=$CompteurTheme+1
				$Break:=Num:C11($CompteurTheme=4)*" <br />"
				$Checked:=Num:C11(Find in array:C230($TbObjectifsRéponse;$Valeur)>0)*(" checked")
				$THTML:=$THTML+"<input id="+<>ZGuil+"cbtheme"+$TbCodeReponse{$Fumé}+"_"+String:C10($Salé)+<>ZGuil
				$THTML:=$THTML+" type="+<>ZGuil+"checkbox"+<>ZGuil+$Checked+" />"+$Valeur+"            "+$Break+<>ZCR
			End if 
		End for 
		$THTML:=$THTML+" </span> "+<>ZCR  // Fin de modif iMacASA2017 (19/12/2019)
		If (True:C214)  // Modifié par : cgm (21/06/2020) pour photos explicatives
			$THTML:=$THTML+"       <div class="+<>ZGuil+"blocphotor"+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+"         <div class="+<>ZGuil+"ligne"+<>ZGuil+">"+$IndentationCom+"</div>"+<>ZCR  // Bloc de décalage du commentaire
			$THTML:=$THTML+"         <div class="+<>ZGuil+"comphoto"+<>ZGuil+">"+<>ZCR  // Le commentaire pour la réponse
			$THTML:=$THTML+"          <span class="+<>ZGuil+"petittexte"+<>ZGuil+">Commentaire suite à la réponse "+$RéponseCodeCourant+" : </span><br />"+<>ZCR
			$Placeholder:=Num:C11($RéponseLibelCourant="")*(" placeholder="+<>ZGuil+"Saisir le commentaire suite à la réponse "+$RéponseCodeCourant+<>ZGuil)
			$THTML:=$THTML+"<textarea  id="+<>ZGuil+"RC"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"areaquizz"+<>ZGuil+$Placeholder+">"
			$THTML:=$THTML+$RéponseArgumentaireCourant+"</textarea> <br /><br />"+<>ZCR
			$THTML:=$THTML+"         </div>"+<>ZCR
			$ArgumentReponse:=$TbArgumentReponse{$fumé}
			ARRAY TEXT:C222($TbNumPhotosSup;0)
			OB GET ARRAY:C1229($ArgumentReponse;"TbNumPhoto";$TbNumPhotosSup)
			ARRAY TEXT:C222($TbComPhotosSup;0)
			OB GET ARRAY:C1229($ArgumentReponse;"TbComPhoto";$TbComPhotosSup)
			$THTML:=$THTML+"         <div class="+<>ZGuil+"comphoto"+<>ZGuil+">"+<>ZCR  // Le bloc du champ avec la liste des photos et les photos
			$THTML:=$THTML+"          <p class="+<>ZGuil+"champannoncephotor"+<>ZGuil+">"+<>ZCR  // champ avec la liste des photos
			$THTML:=$THTML+"            Entrer les n° des photos associées (séparés par un espace)"+<>ZCR
			$THTML:=$THTML+"            <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"RCP"+$RéponseIdCourantA+<>ZGuil+" size="+<>ZGuil+"20px"+<>ZGuil
			$THTML:=$THTML+" class="+<>ZGuil+"champlistephotossup"+<>ZGuil+" value="+<>ZGuil+ZTableauVersTexte (->$TbNumPhotosSup;" ")+<>ZGuil+" />"+<>ZCR
			$THTML:=$THTML+"          </p>"+<>ZCR
			$THTML:=$THTML+"          <div class="+<>ZGuil+"blocphotor"+<>ZGuil+" id="+<>ZGuil+"RBP"+$RéponseIdCourantA+<>ZGuil+">"+<>ZCR  // conteneur du bloc des photos 
			$THTML:=$THTML+QuizzEcritHTMLBlocPhotosSup (->$TbNumPhotosSup;->$TbComPhotosSup;$RéponseIdCourantA)
			$THTML:=$THTML+"          </div>"+<>ZCR  // Fin du bloc photo
			$THTML:=$THTML+"         </div>"+<>ZCR  // Fin du bloc du champ liste des photos et des photos
			$THTML:=$THTML+"        </div>"+<>ZCR  // fin du bloc in-line-block permettant l'affichage des 3 blocs côte à côte
			$THTML:=$THTML+"      </div>"+<>ZCR  // fin de la div LPP
			
			
			  //Sinon 
			  //$THTML:=$THTML+"<br />"+$IndentationCom+"<span class="+<>ZGuil+"petittexte"+<>ZGuil+">Commentaire suite à la réponse "+$RéponseCodeCourant+" : </span><br />"+<>ZCR
			  //$Placeholder:=Num($RéponseLibelCourant="")*(" placeholder="+<>ZGuil+"Saisir le commentaire suite à la réponse "+$RéponseCodeCourant+<>ZGuil)
			  //$THTML:=$THTML+$IndentationCom+"<textarea  id="+<>ZGuil+"RC"+$RéponseIdCourantA+<>ZGuil+" class="+<>ZGuil+"areaquizz"+<>ZGuil+$Placeholder+">"
			  //$THTML:=$THTML+$RéponseArgumentaireCourant+"</textarea> <br /><br />"+<>ZCR
			  //  // Modifié par : iMacASA2017 (21/09/2019)
			  //$THTML:=$THTML+"</div>"  // Fin de modif
		End if 
	End if 
End for 
$0:=$THTML