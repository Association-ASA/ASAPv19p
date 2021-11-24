//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 20/04/19, 07:17:42
// ----------------------------------------------------
// Méthode : WebQuizzEcritPageDepart
// Description
//   Méthode exécutée sur réception dans Sur connexion Web
//  du message "creationquizz"+ Sigle de l'institution
// Paramètre : $1 = message reçu
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$Mess:=$1

$CGM:=($Mess="@_")

$SigleInstitution:=Substring:C12($Mess; 13+(Num:C11($Mess="@quizz@")))
If ($CGM)
	$SigleInstitution:=Substring:C12($SigleInstitution; 1; Length:C16($SigleInstitution)-1)
End if 
Case of 
	: ($SigleInstitution="vas")
		$NomInstitution:="VetAgro Sup"
		$InitialeInstitution:="M"
		$Thème:="Lésions du foie"
		
	: ($SigleInstitution="envn")
		$NomInstitution:="ONIRIS"
		$InitialeInstitution:="N"
		$Thème:="Lésions des séreuses"
		
	: ($SigleInstitution="envt")
		$NomInstitution:="ENVT"
		$InitialeInstitution:="T"
		$Thème:="Lésions des muscles et des noeuds lymphatiques"
		
	: ($SigleInstitution="ulg")
		$NomInstitution:="ULG"
		$InitialeInstitution:="L"
		$Thème:="Lésions parasitaires"
		
	: ($SigleInstitution="enva")
		$NomInstitution:="ENVA"
		$InitialeInstitution:="A"
		$Thème:="Lésions du rein"
		
	: ($SigleInstitution="asa")
		$NomInstitution:="ASA"
		$InitialeInstitution:="S"
		$Thème:="<br />ENVA : Lésions du rein, <br />ENVN : Lésions des séreuses, <br />ENVT : Lésions des muscles et des noeuds lymphatiques, "
		$Thème:=$Thème+"<br />ISVEK : Lésions du poumon et de la plèvre, <br />ULG : Lésions parasitaires <br />VetAgro Sup : Lésions du foie"
		
	: ($SigleInstitution="abattoir")
		$NomInstitution:="Abattoir"
		$InitialeInstitution:="B"
		$Thème:=""
		
	: ($SigleInstitution="isvek")  // Institut Des Sciences Vétérinaires El Khroub
		$NomInstitution:="Institut Des Sciences Vétérinaires El Khroub"
		$InitialeInstitution:="C"
		$Thème:="Lésions du poumon et de la plèvre"
	Else 
		// TRACE
End case 
$CDPDFCatalogue:=<>PermCheDosPdf+"Catalogue"+$SigleInstitution+".pdf"
If (Test path name:C476($CDPDFCatalogue)#Est un document:K24:1)
	QuizzImpCatalogue($SigleInstitution)
End if 
CREATE RECORD:C68([DiaData:45])
[DiaData:45]XType:5:="LoginConcepteur"
[DiaData:45]XDate:3:=Current date:C33
[DiaData:45]XHeure:13:=Current time:C178
[DiaData:45]XNom:1:=(Num:C11(Not:C34($CGM))*$NomInstitution)+(Num:C11($CGM)*"CGM")
[DiaData:45]XAlpha:14:="Page principale"
SAVE RECORD:C53([DiaData:45])

QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]Institution:4=$NomInstitution)
$FT:=Records in selection:C76([QuizzQuestionnaires:35])

$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR2
$THTML:=$THTML+"  <head>"+<>ZCR
$THTML:=$THTML+"    <title>Evaluation</title>"+<>ZCR
$THTML:=$THTML+"    <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/table.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-asadia.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/jquery-ui.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/multiple-select.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"    <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"styles/tooltip.css"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/evaluation.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+">"+<>ZCR
// le javascript de la base jQuery
$THTML:=$THTML+"    <script src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"    <script src="+<>ZGuil+"js/jquery-ui.min.js"+<>ZGuil+"></script>"+<>ZCR
// jQuery UI pour tips
$THTML:=$THTML+"    <script>"+<>ZCR
$THTML:=$THTML+"      $(function() {"+<>ZCR
$THTML:=$THTML+"        $( document ).tooltip();"+<>ZCR
$THTML:=$THTML+"      });"+<>ZCR
$THTML:=$THTML+"    </script>"+<>ZCR

$THTML:=$THTML+"  </head>"+<>ZCR2

$THTML:=$THTML+"  <body>"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"alerte"+<>ZGuil+"></div>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"header"+<>ZGuil+" align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR2
$THTML:=$THTML+"      <a href="+<>ZGuil+"index.shtml"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1008"+<>ZGuil+" > </img>"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$THTML:=$THTML+"      <br /><br />"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR2
$THTML:=$THTML+"    <div id="+<>ZGuil+"corps2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <br/><br/><br/>"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"titrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"
$THTML:=$THTML+"        Création de questionnaires d'évaluation<br>"+"Institution : "+$NomInstitution
$THTML:=$THTML+"      </p>"+<>ZCR
$THTML:=$THTML+"     <br/><br/>"+<>ZCR
$THTML:=$THTML+"     <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       La liste ci-dessous recense les questionnaires déjà existants.<br />"+<>ZCR
$THTML:=$THTML+"       Pour accéder à un questionnaire, cliquez sur le bouton "+<>ZGuil+"Voir"+<>ZGuil+" en face de son nom.<br />"+<>ZCR
If ($FT=0)
	$THTML:=$THTML+"       Comme vous n'en avez pas encore créé, la ligne "+<>ZGuil+"Premier questionnaire"+<>ZGuil+" vous permet de le faire.<br /><br />"+<>ZCR
Else 
	$THTML:=$THTML+"       Pour créer un nouveau questionnaire, cliquez sur le bouton "+<>ZGuil+"Ajouter un nouveau questionnaire"+<>ZGuil+".<br /><br />"+<>ZCR
End if 
If ($NomInstitution#"abattoir")
	If ($NomInstitution#"asa")
		$THTML:=$THTML+"       Lors de la réunion du 28 mai 2019, vous avez opté pour le thème <b>"+$Thème+"</b>.<br /><br />"+<>ZCR
	Else 
		$THTML:=$THTML+"       Lors de la réunion du 28 mai 2019, les institutions ont opté pour <b>"+$Thème+"</b>.<br /><br />"+<>ZCR
	End if 
End if 
$THTML:=$THTML+"     </p>"+<>ZCR
$THTML:=$THTML+"     <br/>"+<>ZCR
$THTML:=$THTML+"     <form name="+<>ZGuil+"form1"+<>ZGuil+" method="+<>ZGuil+"POST"+<>ZGuil+" action="+<>ZGuil+"/mw2QuizzEcritHTMLQuestionnaire"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"institution"+<>ZGuil+" name="+<>ZGuil+"institution"+<>ZGuil+" value="+<>ZGuil+[DiaData:45]XNom:1+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"       <p class="+<>ZGuil+"evaltitretableau"+<>ZGuil+">Liste des questionnaires <br />"
$THTML:=$THTML+"         <input class="+<>ZGuil+"titrepage"+<>ZGuil+" type="+<>ZGuil+"submit"+<>ZGuil
$THTML:=$THTML+" name="+<>ZGuil+"nouveau"+$SigleInstitution+<>ZGuil+" value="+<>ZGuil+"Ajouter un nouveau questionnaire"+<>ZGuil+" />       "
$THTML:=$THTML+"</p>"+<>ZCR
// recherche et affichage des questionnaires existants
If ($FT=0)
	CREATE RECORD:C68([QuizzQuestionnaires:35])
	[QuizzQuestionnaires:35]Institution:4:=$NomInstitution
	[QuizzQuestionnaires:35]Titre:3:="Premier questionnaire"
	SAVE RECORD:C53([QuizzQuestionnaires:35])
End if 
RELATE MANY:C262([QuizzQuestionnaires:35]ID:1)
If (Records in selection:C76([QuizzQuestions:34])=0)
	// une question
	CREATE RECORD:C68([QuizzQuestions:34])
	[QuizzQuestions:34]IDQuestionnaire:2:=[QuizzQuestionnaires:35]ID:1
	[QuizzQuestions:34]LibelQuestion:3:=""
	[QuizzQuestions:34]CodeQuestion:5:=String:C10([QuizzQuestionnaires:35]ID:1)+"."+"1"
	SAVE RECORD:C53([QuizzQuestions:34])
End if 
RELATE MANY:C262([QuizzQuestions:34]ID:1)
If (Records in selection:C76([QuizzReponses:33])=0)
	
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
	
	$FT:=1
End if 
For ($Salé; 1; $FT)
	$THTML:=$THTML+"       <p class="+<>ZGuil+"evallignetableau"+<>ZGuil+">"+[QuizzQuestionnaires:35]Titre:3+"  "
	$THTML:=$THTML+"         <input class="+<>ZGuil+"titrepage"+<>ZGuil+" type="+<>ZGuil+"submit"+<>ZGuil
	$THTML:=$THTML+" name="+<>ZGuil+"envoi"+String:C10([QuizzQuestionnaires:35]ID:1)+<>ZGuil+" value="+<>ZGuil+"Voir"+<>ZGuil+" />"
	$THTML:=$THTML+"       </p>"+<>ZCR
	NEXT RECORD:C51([QuizzQuestionnaires:35])
End for 

$THTML:=$THTML+"       <p class="+<>ZGuil+"evaltitretableau"+<>ZGuil+"><br />Photos pour les questionnaires   "
$THTML:=$THTML+"       </p>"+<>ZCR
QUERY:C277([DiaData:45]; [DiaData:45]XAlpha:14=$SigleInstitution; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XBool:9=False:C215; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="QuizzPhoto")
DISTINCT VALUES:C339([DiaData:45]XTexte:7; TbPUMListeEspece)
DISTINCT VALUES:C339([DiaData:45]XTexteSup:8; TbPUMListeLesion)
$THTML:=$THTML+QuizzListePhotosQuizz($SigleInstitution)
$THTML:=$THTML+"       <br /><br /><br />"+<>ZCR
// fin Modifié par : cgm (16/06/2020)
$THTML:=$THTML+"     </form><br /><br /><br />"+<>ZCR


$THTML:=$THTML+"   </div>"+<>ZCR
$THTML:=$THTML+"   <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <!--4dinclude pied.shtml-->"+<>ZCR
$THTML:=$THTML+"     </div>"+<>ZCR
$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/evaluation.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"  </body>"+<>ZCR2

$THTML:=$THTML+"</html>"+<>ZCR
WEB SEND TEXT:C677($THTML)
QuizzFabriqueTbGeneraux
ZAmnistieInternationale
