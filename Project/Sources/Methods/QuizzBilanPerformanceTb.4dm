//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/12/19, 15:37:02
  // ----------------------------------------------------
  // Méthode : QuizzBilanPerformanceTb
  // Description
  //   Méthode qui permet d'automatiser le bilan 
  //   de la session Web d'un visiteur pour un questionnaire
  //   et le renvoie sous forme détaillée
  // ----------------------------------------------------
  // forme du bilan : Tableau à 5 colonnes (la question, la réponse, la solution, l'évaluation incluant sa raison et la possibilité de revoir une question )

C_LONGINT:C283($Salé;$FT;$ModeEval;$L;$L2;$L3)
C_OBJECT:C1216($Objet)
If (Macintosh command down:C546)  // Permet le test sur une session
	QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=330732)
	RELATE MANY:C262([QuizzQuestionnaires:35]ID:1)  //Toutes les questions
	QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32];[QuizzSuivi:32]Argument:6;"ChaineAjax";=;"rep@";*)  // Les réponses simples
	QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32]; | [QuizzSuivi:32]Argument:6;"ChaineAjax";=;"mul@";*)  // Les réponses multiple
	QUERY:C277([QuizzSuivi:32]; & [QuizzSuivi:32]IdSessionVisiteur:9="ASAE457506813144E5A87C3BB4B7B26D625")  // La session
End if 

  // recueil de tous les objectifs prévus dans le cadre du questionnaire
ARRAY TEXT:C222($TbThème;0)
OB GET ARRAY:C1229([QuizzQuestionnaires:35]Argument:5;"TbObjectifs";$TbThème)
$TTT:=Size of array:C274($TbThème)

  // Tableaux des reponses concernées
RELATE MANY SELECTION:C340([QuizzReponses:33]IDQuestion:2)  //Toutes les reponses possibles
SELECTION TO ARRAY:C260([QuizzReponses:33]ID:1;$TbIdReponseN\
;[QuizzReponses:33]Argument:7;$TbArgumentReponse\
;[QuizzReponses:33]ArgumentaireReponse:4;$TbArgumentaireReponse\
;[QuizzReponses:33]IDQuestion:2;$TbIdQuestionReponse\
;[QuizzReponses:33]LibelReponse:3;$TbLibelReponse\
;[QuizzReponses:33]ValeurReponse:6;$TbValeurReponse)
If ($TTT>0)
	$FT:=Size of array:C274($TbArgumentReponse)
	ARRAY TEXT:C222($TbThemeReponse;$FT)
	For ($Salé;1;$FT)
		ARRAY TEXT:C222($TbObjectifsRéponse;0)
		OB GET ARRAY:C1229($TbArgumentReponse{$Salé};"TbObjectifs";$TbObjectifsRéponse)
		$TbThemeReponse{$Salé}:=ZTableauVersTexte (->$TbObjectifsRéponse;"£")
	End for 
End if 

ORDER BY:C49([QuizzSuivi:32];[QuizzSuivi:32]Ordre:8;>)
SELECTION TO ARRAY:C260([QuizzSuivi:32]Argument:6;$TbArgument\
;[QuizzSuivi:32]IDQuestion:7;$TbIDQuestion\
;[QuizzSuivi:32]IDQuestionnaire:2;$TbIDQuestionnaire)
$FT:=Size of array:C274($TbArgument)
ARRAY LONGINT:C221($TbIdRep;0)  // ID de la réponse  => Libéllé
ARRAY TEXT:C222($TbLibéllé;0)
ARRAY BOOLEAN:C223($TbBoolCochée;0)
ARRAY BOOLEAN:C223($TbBoolRepBonne;0)
ARRAY TEXT:C222($TbListeRéponsesAttendues;0)
ARRAY TEXT:C222($TbIntituléQuestion;0)
ARRAY TEXT:C222($TbCodeQuestion;0)
ARRAY TEXT:C222($TbThemeConcerné;0)
ARRAY TEXT:C222($TbMotif;0)
ARRAY TEXT:C222($TbThemeExistant;0)
$NbreReponsePossibles:=0
$NbreReponseFausses:=0
For ($Salé;1;$FT)
	$Ajax:=OB Get:C1224($TbArgument{$Salé};"ChaineAjax";Est un texte:K8:3)
	
	Case of 
		: ($Ajax="rep@")  // Ajax de type repquizz2_ASADE87B7F43AEF4AEC91F57A998A5650DB
			$Pos:=Position:C15("_";$Ajax)
			$IdReponseCouranteN:=Num:C11(Substring:C12($Ajax;1;($pos-1)))
			$L:=Find in array:C230($TbIdReponseN;$IdReponseCouranteN)
			ARRAY TEXT:C222($TbObjectifsRéponse;0)
			OB GET ARRAY:C1229($TbArgumentReponse{$L};"TbObjectifs";$TbObjectifsRéponse)
			$SFT:=Size of array:C274($TbObjectifsRéponse)
			$MotifRéponse:=$TbArgumentaireReponse{$L}
			If ($SFT>0)  // Il existe des objectifs
				For ($Fumé;1;$SFT)
					APPEND TO ARRAY:C911($TbIdRep;$IdReponseCouranteN)
					APPEND TO ARRAY:C911($TbLibéllé;$TbLibelReponse{$L})
					APPEND TO ARRAY:C911($TbBoolCochée;True:C214)
					APPEND TO ARRAY:C911($TbBoolRepBonne;($TbValeurReponse{$L}=1))
					$L1:=Find in array:C230(<>TbQuestionId;$TbIdQuestionReponse{$L})
					APPEND TO ARRAY:C911($TbListeRéponsesAttendues;<>TbQuestionReponsesAttendues{$L1})
					APPEND TO ARRAY:C911($TbIntituléQuestion;<>TBQUESTIONLIBELQUESTION{$L1})
					APPEND TO ARRAY:C911($TbCodeQuestion;<>TBQUESTIONCODEQUESTION{$L1})
					APPEND TO ARRAY:C911($TbThemeConcerné;$TbObjectifsRéponse{$Fumé})
					APPEND TO ARRAY:C911($TbMotif;$MotifRéponse)
					If (Find in array:C230($TbThemeExistant;$TbObjectifsRéponse{$Fumé})<0)
						APPEND TO ARRAY:C911($TbThemeExistant;$TbObjectifsRéponse{$Fumé})
					End if 
				End for 
				$NbreReponsePossibles:=$NbreReponsePossibles+1
				$NbreReponseFausses:=$NbreReponseFausses+Num:C11($TbValeurReponse{$L}#1)
				
			Else   // Aucun objectif n'a été donné
				APPEND TO ARRAY:C911($TbIdRep;$IdReponseCouranteN)
				APPEND TO ARRAY:C911($TbLibéllé;$TbLibelReponse{$L})
				APPEND TO ARRAY:C911($TbBoolCochée;True:C214)
				APPEND TO ARRAY:C911($TbBoolRepBonne;($TbValeurReponse{$L}=1))
				$L1:=Find in array:C230(<>TbQuestionId;$TbIdQuestionReponse{$L})
				APPEND TO ARRAY:C911($TbListeRéponsesAttendues;<>TbQuestionReponsesAttendues{$L1})
				APPEND TO ARRAY:C911($TbIntituléQuestion;<>TBQUESTIONLIBELQUESTION{$L1})
				APPEND TO ARRAY:C911($TbCodeQuestion;<>TBQUESTIONCODEQUESTION{$L1})
				APPEND TO ARRAY:C911($TbThemeConcerné;"")
				APPEND TO ARRAY:C911($TbMotif;$MotifRéponse)
				$NbreReponsePossibles:=$NbreReponsePossibles+1
				$NbreReponseFausses:=$NbreReponseFausses+Num:C11($TbValeurReponse{$L}#1)
			End if 
			
		: ($Ajax="mul@")  // Ajax de type multiplelancequizzboutonenvoimulti1043£casequizz45,casequizz41,casequizz40,casequizz38,£ONIRISA9115AC2DA0E466188A6577C98AC551F
			  //Détermination des cases cochées
			ARRAY TEXT:C222($TbAjax;0)
			ZTexteVersTableau ($Ajax;->$TbAjax;"£")
			  // Quelles réponses ont été cochées ?
			ARRAY TEXT:C222($TbCase;0)
			ZTexteVersTableau ($TbAjax{2};->$TbCase;",")
			$IDQuestionN:=Num:C11($TbAjax{1})  // élimination de "multiplelancequizzboutonenvoimulti"
			$SFT:=Size of array:C274($TbCase)
			ARRAY LONGINT:C221($TbCaseN;$SFT)
			For ($Fumé;1;$SFT)
				$TbCaseN{$Fumé}:=Num:C11($TbCase{$Fumé})
			End for 
			  // Traitement de toutes les réponses possibles pour cette question multiple
			QUERY:C277([QuizzReponses:33];[QuizzReponses:33]IDQuestion:2=$IDQuestionN)
			SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5;$TbCodeReponse\
				;[QuizzReponses:33]CodeReponse:5;$TbCodeReponse\
				;[QuizzReponses:33]ID:1;$TbIdReps)
			SORT ARRAY:C229($TbCodeReponse;$TbIdReps;>)
			$TT:=Size of array:C274($TbCodeReponse)
			For ($Sec;1;$TT)
				$IdReponseCouranteN:=$TbIdReps{$Sec}
				$L:=Find in array:C230(<>TbReponseCodeReponse;$TbCodeReponse{$Sec})
				ARRAY TEXT:C222($TbObjectifsRéponse;0)
				OB GET ARRAY:C1229(<>TbReponseArgument{$L};"TbObjectifs";$TbObjectifsRéponse)
				$SFT:=Size of array:C274($TbObjectifsRéponse)
				$Bool:=(Find in array:C230($TbCaseN;$TbIdReps{$Sec})<0)
				$Libellé:=<>TbReponseLibelReponse{$L}+(Num:C11($Bool)*"<br /><b>Case non cochée</b>")
				$CaseCochée:=Not:C34($Bool)
				$L1:=Find in array:C230(<>TbQuestionId;<>TbReponseIdQuestion{$L})
				$RéponsesAttendues:=<>TbQuestionReponsesAttendues{$L1}
				  // Additionnons les valeurs booléennes cochées et vraie : si la somme =1 la réponse en mauvaise
				$RéponseValeurBonne:=Num:C11(<>TbReponseValeurReponse{$L}=1)+Num:C11($CaseCochée)
				$ValeurRéponse:=($RéponseValeurBonne#1)  // Car + par + fait +   aussi bien que - par  - 
				$MotifRéponse:=<>TbReponseArgumentaireReponse{$L}
				If ($SFT>0)  // Il existe des objectifs
					For ($Fumé;1;$SFT)
						APPEND TO ARRAY:C911($TbIdRep;$IdReponseCouranteN)
						APPEND TO ARRAY:C911($TbLibéllé;$Libellé)
						APPEND TO ARRAY:C911($TbBoolCochée;$CaseCochée)
						APPEND TO ARRAY:C911($TbBoolRepBonne;$ValeurRéponse)
						APPEND TO ARRAY:C911($TbListeRéponsesAttendues;$RéponsesAttendues)
						APPEND TO ARRAY:C911($TbIntituléQuestion;<>TBQUESTIONLIBELQUESTION{$L1})
						APPEND TO ARRAY:C911($TbCodeQuestion;<>TBQUESTIONCODEQUESTION{$L1})
						APPEND TO ARRAY:C911($TbThemeConcerné;$TbObjectifsRéponse{$Fumé})
						APPEND TO ARRAY:C911($TbMotif;$MotifRéponse)
						If (Find in array:C230($TbThemeExistant;$TbObjectifsRéponse{$Fumé})<0)
							APPEND TO ARRAY:C911($TbThemeExistant;$TbObjectifsRéponse{$Fumé})
						End if 
					End for 
					$NbreReponsePossibles:=$NbreReponsePossibles+1
					$NbreReponseFausses:=$NbreReponseFausses+Num:C11(Not:C34($ValeurRéponse))
				Else   // Pas d'objectif déclaré
					APPEND TO ARRAY:C911($TbIdRep;$IdReponseCouranteN)
					APPEND TO ARRAY:C911($TbLibéllé;$Libellé)
					APPEND TO ARRAY:C911($TbBoolCochée;$CaseCochée)
					APPEND TO ARRAY:C911($TbBoolRepBonne;$ValeurRéponse)
					APPEND TO ARRAY:C911($TbListeRéponsesAttendues;$RéponsesAttendues)
					APPEND TO ARRAY:C911($TbIntituléQuestion;<>TBQUESTIONLIBELQUESTION{$L1})
					APPEND TO ARRAY:C911($TbCodeQuestion;<>TBQUESTIONCODEQUESTION{$L1})
					APPEND TO ARRAY:C911($TbThemeConcerné;"")
					APPEND TO ARRAY:C911($TbMotif;$MotifRéponse)
					$NbreReponsePossibles:=$NbreReponsePossibles+1
					$NbreReponseFausses:=$NbreReponseFausses+Num:C11(Not:C34($ValeurRéponse))
				End if 
			End for 
		Else 
			  // TRACE
	End case 
End for 



  //$FT:=Taille tableau($TbMotif)
  //$Rapport:="Id réponse"+<>ZTab+"Libéllé"+<>ZTab+"Coché"+<>ZTab+"Bonne réponse"+<>ZTab+"Réponse attendue"+<>ZTab+"Intitulé de la question"+<>ZTab+"Thème"+<>ZCR
  //Boucle ($Salé;1;$FT)
  //$Rapport:=$Rapport+Chaîne($TbIdRep{$Salé})+<>ZTab+$TbLibéllé{$Salé}+<>ZTab+Chaîne($TbBoolCochée{$Salé})+<>ZTab+Chaîne($TbBoolRepBonne{$Salé})
  //$Rapport:=$Rapport+<>ZTab+$TbListeRéponsesAttendues{$Salé}+<>ZTab+$TbIntituléQuestion{$Salé}+<>ZTab+$TbThemeConcerné{$Salé}+<>ZCR
  //Fin de boucle
  //FIXER TEXTE DANS CONTENEUR($Rapport)

  // Le HTML du bilan
$THTML:="<br /><br />"
$THTML:=$THTML+"         <div class="+<>ZGuil+"textebilan"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <b>Bilan de vos réponses au questionnaire</b>:<br />"+<>ZCR

If (Size of array:C274($TbThemeExistant)=0)  // pas de thème concerné : on se contente de la liste des réponses apportées
	$THTML:=$THTML+"     <div class="+<>ZGuil+"tablebilan"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"       <table>"+<>ZCR
	$THTML:=$THTML+"        <tr>"+<>ZCR
	$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"35%"+<>ZGuil+">Question</th>"+<>ZCR
	$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"25%"+<>ZGuil+">Votre réponse</th>"+<>ZCR
	$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"25%"+<>ZGuil+">La bonne réponse</th>"+<>ZCR
	$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"5%"+<>ZGuil+">Evaluation*</th>"+<>ZCR
	$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"5%"+<>ZGuil+">Revoir</th>"+<>ZCR
	$THTML:=$THTML+"        </tr>"+<>ZCR
	$FT:=Size of array:C274($TbIdRep)
	$PasBon:=0
	
	For ($Salé;1;$FT)
		$THTML:=$THTML+"        <tr class="+<>ZGuil+"tbbilanligne"+<>ZGuil+">"+<>ZCR
		  // Colonne la question
		
		
		$Pos:=Position:C15(".";$TbCodeQuestion{$Salé})
		$QuelleQuestion:="Question "+Substring:C12($TbCodeQuestion{$Salé};($Pos+1))+" : "+$TbIntituléQuestion{$Salé}
		$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil+" >"+$QuelleQuestion+"</td>"+<>ZCR
		
		  // Colonne votre réponse : devrait tenir compte des questions à réponses multiples
		$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil+" >"+$TbLibéllé{$Salé}+"</td>"+<>ZCR
		
		  // Colonne la ou les bonnes réponses
		$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil+">"+$TbListeRéponsesAttendues{$Salé}+"</td>"+<>ZCR
		
		  // Colonne évaluation
		$emoticon:=(Num:C11($TbBoolRepBonne{$Salé})*"&#128515;")+(Num:C11(Not:C34($TbBoolRepBonne{$Salé}))*"&#128545;")
		$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil
		$THTML:=$THTML+"><span class="+<>ZGuil+"emoticonbilan"+<>ZGuil
		$THTML:=$THTML+" title="+<>ZGuil+$TbMotif{$Salé}+<>ZGuil+">"+$emoticon+"</span></td>"+<>ZCR
		
		$emoticon:="&#128083;"
		$THTML:=$THTML+"          <td id="+<>ZGuil+"voirquestion"+$TbCodeQuestion{$Salé}+<>ZGuil+" class="+<>ZGuil+"tbbilanligne"+<>ZGuil
		$THTML:=$THTML+"><span class="+<>ZGuil+"emoticonbilan"+<>ZGuil
		$Pos:=Position:C15(".";$TbCodeQuestion{$Salé})
		$THTML:=$THTML+" title="+<>ZGuil+"Revoir la question "+Substring:C12($TbCodeQuestion{$Salé};($Pos+1))+<>ZGuil+">"+$emoticon+"</span></td>"+<>ZCR
		$THTML:=$THTML+"        </tr>"+<>ZCR
		
	End for 
	$THTML:=$THTML+"      </table>"+<>ZCR
	$THTML:=$THTML+"       <div class="+<>ZGuil+"textenews"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"       * Vous pouvez faire apparaitre le motif de l'évaluation en glissant la souris sur l'émoticon"+<>ZCR
	$THTML:=$THTML+"       </div>"+<>ZCR
	
Else   // des thèmes ont été assignés
	SORT ARRAY:C229($TbThemeExistant;>)
	$Domaine:=ZTableauVersTexte (->$TbThemeExistant;", ")
	$THTML:=$THTML+"            Le questionnaire a permis de tester vos connaissances dans les domaines suivants : "+$Domaine+"<br /><br />"
	
	SORT ARRAY:C229($TbThemeConcerné;$TbIdRep;$TbLibéllé;$TbBoolCochée;$TbBoolRepBonne;$TbListeRéponsesAttendues;$TbIntituléQuestion;$TbCodeQuestion;$TbMotif;>)
	$FT:=Size of array:C274($TbThemeConcerné)
	  // Evaluation de la performance par thème
	
	ARRAY TEXT:C222($TbObjectifsTheme;0)
	ARRAY LONGINT:C221($TbOccVraiTheme;0)
	ARRAY LONGINT:C221($TbOccFauxTheme;0)
	$TTb:=Size of array:C274($TbThemeConcerné)
	For ($Salé;1;$TTb)
		$L:=Find in array:C230($TbObjectifsTheme;$TbThemeConcerné{$Salé})
		If ($L<0)
			APPEND TO ARRAY:C911($TbObjectifsTheme;$TbThemeConcerné{$Salé})
			APPEND TO ARRAY:C911($TbOccVraiTheme;Num:C11($TbBoolRepBonne{$Salé}))
			APPEND TO ARRAY:C911($TbOccFauxTheme;Num:C11(Not:C34($TbBoolRepBonne{$Salé})))
		Else 
			$TbOccVraiTheme{$L}:=$TbOccVraiTheme{$L}+Num:C11($TbBoolRepBonne{$Salé})
			$TbOccFauxTheme{$L}:=$TbOccFauxTheme{$L}+Num:C11(Not:C34($TbBoolRepBonne{$Salé}))
		End if 
	End for 
	
	
	
	$Compteur:=1
	While ($Compteur<=$FT)
		$THTML:=$THTML+"     <div class="+<>ZGuil+"tablebilan"+<>ZGuil+">"+<>ZCR
		$L:=Find in array:C230($TbObjectifsTheme;$TbThemeConcerné{$Compteur})
		Case of 
			: ($TbOccFauxTheme{$L}=0)
				$s:=Num:C11($TbOccVraiTheme{$L}>1)*"s"
				$BilanTheme:=String:C10($TbOccVraiTheme{$L})+" bonne"+$s+" réponse"+$s+" et aucune erreur"
				
			: ($TbOccVraiTheme{$L}=0)
				$s:=Num:C11($TbOccFauxTheme{$L}>1)*"s"
				$BilanTheme:=String:C10($TbOccFauxTheme{$L})+" erreur"+$s+" et aucune bonne réponse"
				
			Else 
				$s:=Num:C11($TbOccVraiTheme{$L}>1)*"s"
				$BilanTheme:=String:C10($TbOccVraiTheme{$L})+" bonne"+$s+" réponse"+$s
				$s:=Num:C11($TbOccFauxTheme{$L}>1)*"s"
				$BilanTheme:=$BilanTheme+" et "+String:C10($TbOccFauxTheme{$L})+" erreur"+$s
		End case 
		
		$THTML:=$THTML+"       <b>Pour le thème "+<>ZGuil+$TbThemeConcerné{$Compteur}+<>ZGuil+"</b> : "+$BilanTheme+<>ZCR
		$THTML:=$THTML+"       <table>"+<>ZCR
		$THTML:=$THTML+"        <tr>"+<>ZCR
		$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"35%"+<>ZGuil+">Question</th>"+<>ZCR
		$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"25%"+<>ZGuil+">Votre réponse</th>"+<>ZCR
		$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"25%"+<>ZGuil+">La bonne réponse</th>"+<>ZCR
		$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"5%"+<>ZGuil+">Evaluation*</th>"+<>ZCR
		$THTML:=$THTML+"          <th class="+<>ZGuil+"tbbilanet"+<>ZGuil+" width="+<>ZGuil+"5%"+<>ZGuil+">Revoir</th>"+<>ZCR
		$THTML:=$THTML+"        </tr>"+<>ZCR
		$Theme:=$TbThemeConcerné{$Compteur}
		$OC:=True:C214
		While ($OC)
			$THTML:=$THTML+"        <tr class="+<>ZGuil+"tbbilanligne"+<>ZGuil+">"+<>ZCR
			  // Colonne la question
			$Pos:=Position:C15(".";$TbCodeQuestion{$Compteur})
			$QuelleQuestion:="Question "+Substring:C12($TbCodeQuestion{$Compteur};($Pos+1))+" : "+$TbIntituléQuestion{$Compteur}
			$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil+" >"+$QuelleQuestion+"</td>"+<>ZCR
			
			  // Colonne votre réponse : devrait tenir compte des questions à réponses multiples
			$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil+" >"+$TbLibéllé{$Compteur}+"</td>"+<>ZCR
			
			  // Colonne la ou les bonnes réponses
			$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil+">"+$TbListeRéponsesAttendues{$Compteur}+"</td>"+<>ZCR
			
			  // Colonne évaluation
			$emoticon:=(Num:C11($TbBoolRepBonne{$Compteur})*"&#128515;")+(Num:C11(Not:C34($TbBoolRepBonne{$Compteur}))*"&#128545;")
			$THTML:=$THTML+"          <td class="+<>ZGuil+"tbbilanligne"+<>ZGuil
			$THTML:=$THTML+"><span class="+<>ZGuil+"emoticonbilan"+<>ZGuil
			$THTML:=$THTML+" title="+<>ZGuil+$TbMotif{$Compteur}+<>ZGuil+">"+$emoticon+"</span></td>"+<>ZCR
			$Theme:=$TbThemeConcerné{$Compteur}
			
			  // Colonne Revoir la question
			$emoticon:="&#128083;"
			$THTML:=$THTML+"          <td id="+<>ZGuil+"voirquestion"+$TbCodeQuestion{$Compteur}+<>ZGuil+" class="+<>ZGuil+"tbbilanligne"+<>ZGuil
			$THTML:=$THTML+"><span class="+<>ZGuil+"emoticonbilan"+<>ZGuil
			$Pos:=Position:C15(".";$TbCodeQuestion{$Compteur})
			$THTML:=$THTML+" title="+<>ZGuil+"Revoir la question "+Substring:C12($TbCodeQuestion{$Compteur};($Pos+1))+<>ZGuil+">"+$emoticon+"</span></td>"+<>ZCR
			$THTML:=$THTML+"        </tr>"+<>ZCR
			
			$Compteur:=$Compteur+1
			If ($Compteur<=$FT)
				$OC:=($Theme=$TbThemeConcerné{$Compteur})
			Else 
				$OC:=False:C215
			End if 
		End while 
		$THTML:=$THTML+"      </table>"+<>ZCR
		$THTML:=$THTML+"       <div class="+<>ZGuil+"textenews"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"       * Vous pouvez faire apparaitre le motif de l'évaluation en glissant la souris sur l'émoticon"+<>ZCR
		$THTML:=$THTML+"       </div>"+<>ZCR
		$THTML:=$THTML+"<br /><br />"
	End while 
End if 

$THTML:=$THTML+"Bilan général : <br />"+<>ZCR
If (Size of array:C274($TbThemeConcerné)=0)
	$NbreReponsePossibles:=Size of array:C274($TbIdRep)
End if 

If ($NbreReponseFausses=0)
	$THTML:=$THTML+"Bravo, vous n'avez fait aucune erreur sur les "+String:C10($NbreReponsePossibles)+" réponses proposées"
Else 
	$s:=Num:C11($NbreReponseFausses>1)*"s"
	$THTML:=$THTML+"Vous avez fait "+String:C10($NbreReponseFausses)+" erreur"+$s+" sur les "+String:C10($NbreReponsePossibles)+" réponses proposées<br />"
	$THTML:=$THTML+"AsaDia contient un onglet "+<>ZGuil+"Textes"+<>ZGuil+" qui peut vous permettre de progresser."
End if 
$THTML:=$THTML+"</div>"
$THTML:=$THTML+"<br /><br />"

  // FIXER TEXTE DANS CONTENEUR($THTML)
$0:=$THTML
