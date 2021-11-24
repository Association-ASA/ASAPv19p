//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 21/03/19, 07:47:18
  // ----------------------------------------------------
  // Méthode : QuizzEcritHTMLQuestionnaire
  // Description
  //   Méthode qui écrit le HTML du questionnaire
  // à partir de l'espace création
  // Paramètre : $1 = code de la question
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$Fumé;$TT;$ModeEVal)
ZAmnistieInternationale 
ARRAY TEXT:C222($TbNoms;0)
ARRAY TEXT:C222($TbValeurs;0)
WEB GET VARIABLES:C683($TbNoms;$TbValeurs)
  // détermination des photos supplémentaires préalablement sélectionnées (TbNoms="OK")
$L:=Find in array:C230($TbNoms;"OK")
ARRAY TEXT:C222($TbIDPhoto;0)
If ($L>0)
	While ($L>0)
		APPEND TO ARRAY:C911($TbIDPhoto;$TbValeurs{$l})
		$L:=Find in array:C230($TbNoms;"OK";($L+1))
	End while 
End if 

$NomInstitution:=DiaWebExtraitValeurTbParNom ("institution";->$TbNoms;->$TbValeurs)
$L:=Find in array:C230($TbNoms;"envoi@")
If ($L>0)  // demande à voir un questionnaire existant
	$IDQuestionnaireN:=Num:C11($TbNoms{$L})  // Suppression de 'Envoi' et numérisation du reste
	$IDQuestionnaireA:=String:C10($IDQuestionnaireN)  // Suppression de 'Envoi' et numérisation du reste
	QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=$IDQuestionnaireN)
Else 
	CREATE RECORD:C68([QuizzQuestionnaires:35])
	[QuizzQuestionnaires:35]Institution:4:=$NomInstitution
	[QuizzQuestionnaires:35]Titre:3:="Nouveau questionnaire"
	SAVE RECORD:C53([QuizzQuestionnaires:35])
	  // une question
	CREATE RECORD:C68([QuizzQuestions:34])
	[QuizzQuestions:34]IDQuestionnaire:2:=[QuizzQuestionnaires:35]ID:1
	[QuizzQuestions:34]LibelQuestion:3:=""
	[QuizzQuestions:34]CodeQuestion:5:=String:C10([QuizzQuestionnaires:35]ID:1)+"."+"1"
	SAVE RECORD:C53([QuizzQuestions:34])
	  // deux réponses
	CREATE RECORD:C68([QuizzReponses:33])
	[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
	[QuizzReponses:33]LibelReponse:3:=""
	[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".1"
	SAVE RECORD:C53([QuizzReponses:33])
	
	CREATE RECORD:C68([QuizzReponses:33])
	[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
	[QuizzReponses:33]LibelReponse:3:=""
	[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".2"
	SAVE RECORD:C53([QuizzReponses:33])
	
	$IDQuestionnaireN:=[QuizzQuestionnaires:35]ID:1
	$IDQuestionnaireA:=String:C10($IDQuestionnaireN)
End if 
$TypeLogin:=(Num:C11($l>0)*"Reprise ")+(Num:C11($l<0)*"Création ")
CREATE RECORD:C68([DiaData:45])
[DiaData:45]XType:5:="LoginConcepteur"
[DiaData:45]XDate:3:=Current date:C33
[DiaData:45]XHeure:13:=Current time:C178
[DiaData:45]XNom:1:=$NomInstitution
[DiaData:45]XAlpha:14:=$TypeLogin+" questionnaire n°"+String:C10([QuizzQuestionnaires:35]ID:1)+" ("+[QuizzQuestionnaires:35]Titre:3+")"
SAVE RECORD:C53([DiaData:45])
If ([QuizzQuestionnaires:35]DateCreation:7=!00-00-00!)
	ZVerrouAttendre (->[QuizzQuestionnaires:35])
	[QuizzQuestionnaires:35]DateCreation:7:=Current date:C33
	SAVE RECORD:C53([QuizzQuestionnaires:35])
	ZAmnistiePartielle (->[QuizzQuestionnaires:35];True:C214)
End if 

$THTML:="<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+" <head>"+<>ZCR
$THTML:=$THTML+"  <title>AsaDia 3</title>"+<>ZCR
$THTML:=$THTML+"  <meta http-equiv="+<>ZGuil+"Content-Type"+<>ZGuil+" content="+<>ZGuil+"text/html; charset=UTF-8"+<>ZGuil+" />"+<>ZCR
  // $THTML:=$THTML+"  <link href="+<>ZGuil+"styles/style-asa.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
  // $THTML:=$THTML+"  <link href="+<>ZGuil+"styles/style-asadia.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/evaluation.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-ui.min.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"styles/tooltip.css"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <script>"+<>ZCR
$THTML:=$THTML+"    $(function() {"+<>ZCR
$THTML:=$THTML+"      $( document ).tooltip();"+<>ZCR
$THTML:=$THTML+"    });"+<>ZCR
$THTML:=$THTML+"  </script>"+<>ZCR
$THTML:=$THTML+" </head>"+<>ZCR2

$THTML:=$THTML+" <body>"+<>ZCR
If (Size of array:C274($TbIDPhoto)>0)
	$THTML:=$THTML+"  <div id="+<>ZGuil+"photossup"+<>ZGuil+" class="+<>ZGuil+"quizzphotosupmultiple"+<>ZGuil+">"+<>ZCR
	QUERY WITH ARRAY:C644([DiaData:45]ID:12;$TbIDPhoto)
	SELECTION TO ARRAY:C260([DiaData:45]XEntier:2;$TbRangN\
		;[DiaData:45]XTexte:7;$TbEspèce\
		;[DiaData:45]XTexteSup:8;$TbLésion\
		;[DiaData:45]XAlpha:14;$TbInstitution)
	$SFT:=Size of array:C274($TbIDPhoto)
	For ($Fumé;1;$SFT)
		$NumPhotosSup:=$TbInstitution{$Fumé}+String:C10($TbRangN{$Fumé})
		$THTML:=$THTML+"         <div class="+<>ZGuil+"comphotor"+<>ZGuil+">"+<>ZCR
		$NumPhotoA:="Q"+$TbInstitution{$Fumé}+String:C10($TbRangN{$Fumé};"00000")
		$THTML:=$THTML+"          <img src="+<>ZGuil+"PhotosAsaDia/"+$NumPhotoA+"i.jpg"+<>ZGuil\
			+" alt="+<>ZGuil+"Photo n°"+$NumPhotosSup+<>ZGuil\
			+" title="+<>ZGuil+"Photo n°"+$NumPhotosSup+<>ZGuil\
			+" width="+<>ZGuil+"180px"+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil+" />"+<>ZCR
		$THTML:=$THTML+"          <p class="+<>ZGuil+"petittextel"+<>ZGuil+">"+<>ZCR
		$ComPhotosSup:=$NumPhotosSup+" :<br />"+<>ZCR
		Case of 
			: ($TbLésion{$Fumé}#"") & ($TbEspèce{$Fumé}#"")
				$ComPhotosSup:=$ComPhotosSup+$TbLésion{$Fumé}+" sur "+$TbEspèce{$Fumé}
			: ($TbLésion{$Fumé}#"") & ($TbEspèce{$Fumé}="")
				$ComPhotosSup:=$ComPhotosSup+$TbLésion{$Fumé}
			: ($TbLésion{$Fumé}="") & ($TbEspèce{$Fumé}#"")
				$ComPhotosSup:=$ComPhotosSup+$TbEspèce{$Fumé}
		End case 
		$THTML:=$THTML+"           "+$ComPhotosSup+<>ZCR
		$THTML:=$THTML+"          </p>"+<>ZCR
		$THTML:=$THTML+"         </div>"+<>ZCR
	End for 
	$THTML:=$THTML+"  </div>"+<>ZCR
End if 
If (Size of array:C274($TbIDPhoto)=0)
	$THTML:=$THTML+"  <div id="+<>ZGuil+"headerquizz"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"   <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1024"+<>ZGuil+" />"+<>ZCR
Else 
	$THTML:=$THTML+"  <div id="+<>ZGuil+"headerquizzphoto"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
End if 
$THTML:=$THTML+"   <input id="+<>ZGuil+"quizzsuivi"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+[QuizzQuestionnaires:35]Institution:4+Generate UUID:C1066+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"   <br /><br />"+<>ZCR2
  // l'institution
$THTML:=$THTML+"   <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       Institution : "+[QuizzQuestionnaires:35]Institution:4+"<br />"+<>ZCR
$THTML:=$THTML+"       Titre de l'évaluation : "+<>ZCR
$THTML:=$THTML+"       <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"ET"+$IDQuestionnaireA+<>ZGuil+" size="+<>ZGuil+"80px"+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"textebanalgrand champlistephotossup"+<>ZGuil+" value="+<>ZGuil+[QuizzQuestionnaires:35]Titre:3+<>ZGuil+"><br />"+<>ZCR
  // l'auteur
$THTML:=$THTML+"       Auteur : "
$THTML:=$THTML+"       <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"EA"+$IDQuestionnaireA+<>ZGuil+" size="+<>ZGuil+"50px"+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"textebanalgrand champlistephotossup"+<>ZGuil+" value="+<>ZGuil+[QuizzQuestionnaires:35]Auteur:2+<>ZGuil+"><br />"+<>ZCR
$THTML:=$THTML+"   </p>"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR2

$THTML:=$THTML+"  <div id="+<>ZGuil+"alerte"+<>ZGuil+"></div>"+<>ZCR

$THTML:=$THTML+"  <div id="+<>ZGuil+"corpscdf"+<>ZGuil+">"+<>ZCR

  //$THTML:=$THTML+"    <div id="+<>ZGuil+"dialog"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"    </div>"+<>ZCR  // fin de la div du dialogue de suppression


  // Le html du chemin de fer
$THTML:=$THTML+"     <div id="+<>ZGuil+"cdf"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR  // début de la div du chemin de fer
$THTML:=$THTML+QuizzEcritHTMLCdF 
$THTML:=$THTML+"     </div>"+<>ZCR  // fin de la div du chemin de fer
$THTML:=$THTML+"  </div>"+<>ZCR  // fin  la div du corps du cdf
$THTML:=$THTML+"   <br /><br /><br />"+<>ZCR
If (False:C215)
	$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"   Site officiel de l'association Animal - Société - Aliment (ASA) <br> Adresse : Bâtiment Jean GIRARD - Ecole Nationale Vétérinaire d'Alfort -"+<>ZCR
	$THTML:=$THTML+"   7 avenue du Général de Gaulle - 94704 Maisons-Alfort Cedex &nbsp;&nbsp;&nbsp;FRANCE<br>"+<>ZCR
	$THTML:=$THTML+"   Téléphone : <b>+ 33 (0)1 56 29 36 30</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax : <b>+ 33 (0)9 61 24 33 81</b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+<>ZCR
	$THTML:=$THTML+"   e-mail : <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+"><b>asa-spv@wanadoo.fr</b></a> <br>"+<>ZCR
	$THTML:=$THTML+"   <em>Pour signaler un problème, cliquez sur le lien suivant "+<>ZCR
	$THTML:=$THTML+"   <a href="+<>ZGuil+"mailto:cegeheme@wanadoo.fr"+<>ZGuil+"> écrire au webmaster</a></em>"+<>ZCR
	$THTML:=$THTML+"   <br /><br />"+<>ZCR
	$THTML:=$THTML+"  </div>"+<>ZCR
	$THTML:=$THTML+"  "+<>ZCR
End if 
$THTML:=$THTML+"  <script src="+<>ZGuil+"js/evaluation.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+" </body>"+<>ZCR
$THTML:=$THTML+"</html>"+<>ZCR
WEB SEND TEXT:C677($THTML)
SET TEXT TO PASTEBOARD:C523($THTML)
ZAmnistieInternationale 