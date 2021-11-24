//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 05/01/17, 07:52:35
// ----------------------------------------------------
// Méthode : WebCreationHTMLDebutPage
// Description
// Permet d'écrire le html depuis la déclaration html5
//  jusque celle de la div id=Corps inclue
// Paramètres $1=langue , $2 = login  {$3} = titre de la page
// ----------------------------------------------------
C_TEXT:C284($Langue; $1; $Espace; $2; $Titre; $3)

$Langue:=$1
$Login:=$2
$Espace:=Num:C11($Langue="F")*" "
$Titre:=$3

$SigneGibier:=Num:C11(Gibier)*"G"
// Ad3TraducFabriqueTb
$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR2
$THTML:=$THTML+" <head>"+<>ZCR
// Le titre
If (Count parameters:C259=3)
	$THTML:=$THTML+"  <title>"+$Titre+"</title>"+<>ZCR
Else 
	$THTML:=$THTML+"  <title>AsaDia 3</title>"+<>ZCR
End if 
// La déclaration de codage
$THTML:=$THTML+"  <meta http-equiv="+<>ZGuil+"Content-Type"+<>ZGuil+" content="+<>ZGuil+"text/html; charset=UTF-8"+<>ZGuil+" />"+<>ZCR

// les styles chargés
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/style-asadia.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/table.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/jquery-ui.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/multiple-select.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"styles/tooltip.css"+<>ZGuil+">"+<>ZCR

// le javascript de la base jQuery
$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-ui.min.js"+<>ZGuil+"></script>"+<>ZCR
// jQuery UI pour tips
$THTML:=$THTML+"  <script>"+<>ZCR
$THTML:=$THTML+"    $(function() {"+<>ZCR
$THTML:=$THTML+"      $( document ).tooltip();"+<>ZCR
$THTML:=$THTML+"    });"+<>ZCR
$THTML:=$THTML+"  </script>"+<>ZCR
$THTML:=$THTML+" </head>"+<>ZCR2

$THTML:=$THTML+" <body>"+<>ZCR
$THTML:=$THTML+"  <input id="+<>ZGuil+"languecourante"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$Langue+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"header"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"  <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1024"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <br /><br />"+<>ZCR
$THTML:=$THTML+"  <br />"+<>ZCR
$THTML:=$THTML+"  <input id="+<>ZGuil+"mailvisiteur"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$Login+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <input id="+<>ZGuil+"typevisiteur"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$SigneGibier+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <input id="+<>ZGuil+"pageasadia"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+VarPageAsaDia+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <ul id="+<>ZGuil+"menubar"+<>ZGuil+">"+<>ZCR
Case of 
	: ($Langue="F")
		If (Gibier)
			$THTML:=$THTML+"    <li><a href="+<>ZGuil+"https://association.asa-spv.fr/"+<>ZGuil+">l'ASA</a></li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiagnoseF"+$SigneGibier+<>ZGuil+">Diagnose lésion</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxMotif"+$SigneGibier+<>ZGuil+">Motifs saisie</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxLesionF"+$SigneGibier+<>ZGuil+">Lésions</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiapoF"+$SigneGibier+<>ZGuil+">Photographies</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxOrganesSainsF"+$SigneGibier+<>ZGuil+">Organes sains</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxPaniersF"+<>ZGuil+">Paniers</a></li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxQuizz"+<>ZGuil+">Quiz</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxTextes"+<>ZGuil+">Textes</li>"+<>ZCR
		Else 
			$THTML:=$THTML+"    <li><a href="+<>ZGuil+"https://association.asa-spv.fr/"+<>ZGuil+">Site de l'ASA</a></li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiagnoseF"+$SigneGibier+<>ZGuil+">Rechercher une lésion</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxMotif"+$SigneGibier+<>ZGuil+">Motifs de saisie</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxLesionF"+$SigneGibier+<>ZGuil+">Liste des lésions</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiapoF"+$SigneGibier+<>ZGuil+">Liste des photographies</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxPaniersF"+<>ZGuil+">Paniers</a></li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxQuizz"+<>ZGuil+">Quiz</li>"+<>ZCR
			$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxTextes"+<>ZGuil+">Textes</li>"+<>ZCR
		End if 
		
	: ($Langue="A")
		$THTML:=$THTML+"    <li><a href="+<>ZGuil+"https://association.asa-spv.fr/"+<>ZGuil+">Site de l'ASA</a></li>"+<>ZCR
		$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiagnoseA"+<>ZGuil+">Find a lesion</li>"+<>ZCR
		$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxLesionA"+<>ZGuil+">List of lesions</li>"+<>ZCR
		$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiapoA"+<>ZGuil+">List of photos</li>"+<>ZCR
		
	: ($Langue="R")
		$THTML:=$THTML+"    <li><a href="+<>ZGuil+"https://association.asa-spv.fr/"+<>ZGuil+">Site de l'ASA</a></li>"+<>ZCR
		$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiagnoseR"+<>ZGuil+">"+DiaWebTraduitTexte("Reconnaître une lésion"; "R")+"</li>"+<>ZCR
		$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxLesionR"+<>ZGuil+">"+DiaWebTraduitTexte("Liste des lésions"; "R")+"</li>"+<>ZCR
		$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxDiapoR"+<>ZGuil+">"+DiaWebTraduitTexte("Liste des photos"; "R")+"</li>"+<>ZCR
		$THTML:=$THTML+"    <li id="+<>ZGuil+"AjaxPaniersR"+<>ZGuil+">"+DiaWebTraduitTexte("Paniers"; "R")+"</li>"+<>ZCR
		
End case 
$THTML:=$THTML+"  </ul>"+<>ZCR2
$THTML:=$THTML+"  </div>"+<>ZCR
$R:=(Num:C11($Langue="R")*"r")+(Num:C11($Langue#"R")*"p")
$THTML:=$THTML+"  <div id="+<>ZGuil+"corps"+<>ZGuil+" class="+<>ZGuil+"corps"+$R+<>ZGuil+">"+<>ZCR

$0:=$THTML
WebIndentation:=5*" "

