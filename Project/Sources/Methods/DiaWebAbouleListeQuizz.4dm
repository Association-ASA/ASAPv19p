//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 24/05/19, 07:39:07
// ----------------------------------------------------
// Méthode : WebAbouleListeQuizz
// Description
// Méthode qui écrit le HTML des quizz et l'envoie
//  à la page Web
// ----------------------------------------------------

$Langue:="F"
// Contenu de la liste
QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]Auteur:2#""; *)
QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]QuizzGeneral:6=True:C214)
$Nre:=Records in selection:C76([QuizzQuestionnaires:35])
$BlancInsécable:=" "
$Langue:="F"
// Ecrivons le HTML
$THTML:=""
$Titre:="Quizz"
$THTML:=$Titre+"£P7£"
$NomPDF:="Quizz"+$Langue
$THTML:=$THTML+DiaWebCreationHTMLAide($Langue; 1; $NomPDF)+"<br /><br />"
$Titre:="Liste des questionnaires"
$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"+$Titre+"</p>"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR

$THTML:=$THTML+"         Pour lancer un questionnaire, cliquez sur le bouton Lancer"+<>ZCR
$THTML:=$THTML+"       <input id="+<>ZGuil+"nbtotal"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+String:C10($Nre)+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"       <input id="+<>ZGuil+"nbactuel"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+String:C10($Nre)+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"       </p>"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"listepanier"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+DiaWebCreationHTMLListeQuizz
$THTML:=$THTML+"      </div>"+<>ZCR
WEB SEND TEXT:C677($THTML)

// FIXER TEXTE DANS CONTENEUR($THTML)

