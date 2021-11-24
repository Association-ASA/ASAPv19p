If (VarCDWeb="")
	VarCDWeb:=Select folder:C670("Où se trouve le dossier Web d'AsaDia local ?")
End if 
$THTML:="<!DOCTYPE html>"+<>ZCR2
$THTML:=$THTML+" <head>"+<>ZCR
$THTML:=$THTML+"  <title>Bilan</title>"+<>ZCR
$THTML:=$THTML+"  <meta http-equiv="+<>ZGuil+"Content-Type"+<>ZGuil+" content="+<>ZGuil+"text/html; charset=UTF-8"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/style-asadia.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/evaluation.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/table.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/jquery-ui.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"  <link href="+<>ZGuil+"styles/multiple-select.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"  <link rel="+<>ZGuil+"stylesheet"+<>ZGuil+" href="+<>ZGuil+"styles/tooltip.css"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script>"+<>ZCR
//$THTML:=$THTML+"  <script src="+<>ZGuil+"js/jquery-ui.min.js"+<>ZGuil+"></script>"+<>ZCR
// $THTML:=$THTML+"  <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia.js"+<>ZGuil+"></script> <!--  jQuery AsaDia    -->"+<>ZCR
//$THTML:=$THTML+"  <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/evaluation.js"+<>ZGuil+"></script> <!-- jQuery du quizz    -->"+<>ZCR
$THTML:=$THTML+"  <script>"+<>ZCR
$THTML:=$THTML+"    $(function() {"+<>ZCR
$THTML:=$THTML+"      $( document ).tooltip();"+<>ZCR
$THTML:=$THTML+"    });"+<>ZCR
$THTML:=$THTML+"  </script>"+<>ZCR
$THTML:=$THTML+" </head>"+<>ZCR2

$THTML:=$THTML+" <body>"+<>ZCR
$THTML:=$THTML+"  <input id="+<>ZGuil+"languecourante"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil
$THTML:=$THTML+" value="+<>ZGuil+"F"+<>ZGuil+" />"+<>ZCR
//$THTML:=$THTML+"  <div id="+<>ZGuil+"headerquizz"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"    <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil
//$THTML:=$THTML+" width="+<>ZGuil+"1024"+<>ZGuil+" id="+<>ZGuil+"AjaxDiagnoseF"+<>ZGuil+" />"+<>ZCR
//  //$THTML:=$THTML+"    <br />Pour revenir à AsaDia, cliquez sur l'image ci-dessus<br /><br /><br />"+<>ZCR
//  //$THTML:=$THTML+"    <input id="+<>ZGuil+"quizzsuivi"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil
//  //$THTML:=$THTML+" value="+<>ZGuil+VarIdSuivi+<>ZGuil+" />"+<>ZCR
//$THTML:=$THTML+"  </div>"+<>ZCR2
$THTML:=$THTML+"  <div id="+<>ZGuil+"quizzcorps"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     Bilan du questionnaire "+<>ZGuil+[QuizzQuestionnaires:35]Titre:3+<>ZGuil+"<br />"
$THTML:=$THTML+"     proposé par "+[QuizzQuestionnaires:35]Auteur:2+"<br />"+<>ZCR
$IdSession:=PUMSuivi{PUMSuivi}
$Lim:=Length:C16($IdSession)-32
$THTML:=$THTML+"     répondu par "+Substring:C12($IdSession; 1; $lim)+" le "+String:C10([QuizzSuivi:32]DateDebut:3; 3)+" à "+String:C10([QuizzSuivi:32]HeureDebut:4)+<>ZCR
$THTML:=$THTML+"   </p>"+<>ZCR
RELATE MANY:C262([QuizzQuestionnaires:35]ID:1)  //Toutes les questions
QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32]; [QuizzSuivi:32]Argument:6; "ChaineAjax"; =; "rep@"; *)
QUERY BY ATTRIBUTE:C1331([QuizzSuivi:32];  | [QuizzSuivi:32]Argument:6; "ChaineAjax"; =; "mul@"; *)
QUERY:C277([QuizzSuivi:32];  & [QuizzSuivi:32]IdSessionVisiteur:9=$IdSession)
$THTML:=$THTML+QuizzBilanPerformanceTb
$THTML:=$THTML+"  </div>"+<>ZCR
//$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"    <!--4dinclude piedF.shtml-->"+<>ZCR
//$THTML:=$THTML+"   </div>"+<>ZCR
$THTML:=$THTML+" </body>"+<>ZCR
$THTML:=$THTML+"</html>"

$Nomshtml:="bilan"+Generate UUID:C1066+".shtml"
$CDFichier:=VarCDWeb+$Nomshtml
$Doc:=Create document:C266($CDFichier)
SEND PACKET:C103($Doc; $THTML)
CLOSE DOCUMENT:C267($Doc)
OPEN URL:C673($CDFichier)
QuizzPUMSuivi