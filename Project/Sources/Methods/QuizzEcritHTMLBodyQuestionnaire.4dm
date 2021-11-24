//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/03/19, 07:47:18
  // ----------------------------------------------------
  // Méthode : QuizzEcritHTMLBodyQuestionnaire
  // Description
  //   Méthode qui écrit le HTML du questionnaire
  // à partir de l'espace création
  // Paramètre : $1 = [QuizzQuestionnaires]ID
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$Fumé;$TT;$ModeEVal)
$IDQuestionnaireN:=$1
$IDQuestionnaireA:=String:C10($IDQuestionnaireN)
QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=$IDQuestionnaireN)
$THTML:=""
$THTML:=$THTML+"  <div id="+<>ZGuil+"headerquizz"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"   <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"
$THTML:=$THTML+<>ZGuil+" width="+<>ZGuil+"1024"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"   <input id="+<>ZGuil+"quizzsuivi"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil
$THTML:=$THTML+" value="+<>ZGuil+[QuizzQuestionnaires:35]Institution:4+Generate UUID:C1066+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"   <br /><br />"+<>ZCR2
  // l'institution
$THTML:=$THTML+"   <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       Institution : "+[QuizzQuestionnaires:35]Institution:4+"<br />"+<>ZCR
$THTML:=$THTML+"       Titre de l'évaluation : "+<>ZCR
$THTML:=$THTML+"       <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"ET"+$IDQuestionnaireA+<>ZGuil
$THTML:=$THTML+" size="+<>ZGuil+"80px"+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"textebanalgrand champquizz"+<>ZGuil
$THTML:=$THTML+" value="+<>ZGuil+[QuizzQuestionnaires:35]Titre:3+<>ZGuil+"><br />"+<>ZCR
  // l'auteur
$THTML:=$THTML+"       Auteur : "
$THTML:=$THTML+"       <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"EA"+$IDQuestionnaireA+<>ZGuil
$THTML:=$THTML+" size="+<>ZGuil+"50px"+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"textebanalgrand champquizz"+<>ZGuil
$THTML:=$THTML+" value="+<>ZGuil+[QuizzQuestionnaires:35]Auteur:2+<>ZGuil+"><br />"+<>ZCR
$THTML:=$THTML+"   </p>"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR2

$THTML:=$THTML+"  <div id="+<>ZGuil+"alerte"+<>ZGuil+"></div>"+<>ZCR

$THTML:=$THTML+"  <div id="+<>ZGuil+"corpscdf"+<>ZGuil+">"+<>ZCR

$THTML:=$THTML+"    <div id="+<>ZGuil+"dialog"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR  // fin de la div du dialogue de suppression
$THTML:=$THTML+"     <div id="+<>ZGuil+"cdf"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR  // début de la div du chemin de fer
$THTML:=$THTML+QuizzEcritHTMLCdF 
$THTML:=$THTML+"     </div>"+<>ZCR  // fin de la div du chemin de fer
$THTML:=$THTML+"  </div>"+<>ZCR  // fin  la div du corps du cdf
$THTML:=$THTML+"   <br /><br /><br />"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"   Site officiel de l'association Animal - Société - Aliment (ASA) <br> Adresse : Bâtiment Jean GIRARD - Ecole Nationale Vétérinaire d'Alfort -"+<>ZCR
$THTML:=$THTML+"   7 avenue du Général de Gaulle - 94704 Maisons-Alfort Cedex &nbsp;&nbsp;&nbsp;FRANCE<br>"+<>ZCR
$THTML:=$THTML+"   Téléphone : <b>+ 33 (0)1 56 29 36 30</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax : <b>+ 33 (0)9 61 24 33 81</b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+<>ZCR
$THTML:=$THTML+"   e-mail : <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+"><b>asa-spv@wanadoo.fr</b></a> <br>"+<>ZCR
$THTML:=$THTML+"   <em>Pour signaler un problème, cliquez sur le lien suivant "+<>ZCR
$THTML:=$THTML+"   <a href="+<>ZGuil+"mailto:cegeheme@wanadoo.fr"+<>ZGuil+"> écrire au webmaster</a></em>"+<>ZCR
$THTML:=$THTML+"   <br /><br />"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+"  <script src="+<>ZGuil+"js/evaluation.js"+<>ZGuil+"></script>"+<>ZCR

WEB SEND TEXT:C677($THTML)
  //  FIXER TEXTE DANS CONTENEUR($THTML)
ZAmnistieInternationale 