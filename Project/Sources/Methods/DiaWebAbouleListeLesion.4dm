//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 16/07/16, 16:52:54
  // ----------------------------------------------------
  // Méthode : WebAbouleListeLesion
  // Description
  // Permet au site Web de construire
  // la page des lésions en français
  // $1 vrai si français et Faux sinon  $2=Vrai si page AJAX et Faux si changement de langue
  // ----------------------------------------------------
C_TEXT:C284($1;$Langue;$NomPDF;$THTML)
C_BOOLEAN:C305($2)
$Langue:=$1
$Ajax:=$2

$listelesion:=DiaWebTraduitTexte ("Liste des lésions";$Langue)
  // le HTML
$THTML:=$listelesion+"£P4£"
$NomPDF:="Lésion"+$Langue
$THTML:=$THTML+DiaWebCreationHTMLAide ($Langue;1;"Lésion")
  // $Methode:=(Num($french)*"mw2WebListeLesionA")+(Num(Non($french))*"mw2WebListeLesionF")
  //$THTML:=$THTML+"     <form method="+<>ZGuil+"post"+<>ZGuil+" action="+<>ZGuil+$Methode+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"        <input id="+<>ZGuil+"flagA"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+" type="+<>ZGuil+"image"+<>ZGuil
  //$A:=Num(Non($french))*"A"
  //$AF:=(Num($french)*"A")+(Num(Non($french))*"F")
  //$THTML:=$THTML+" src="+<>ZGuil+"images/Drapeau"+$AF+".gif"+<>ZGuil+" alt="+<>ZGuil+$TitreDrapeau+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"        <input name="+<>ZGuil+"loginasadia"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+VarLogin+<>ZGuil+" />"+<>ZCR
  //$THTML:=$THTML+"      </form> "+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"+$listelesion+"</p>"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte ("Pour afficher le détail d'une lésion";$Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte ("Pour chercher les lésions";$Langue)
$THTML:=$THTML+"<input id="+<>ZGuil+"cherchelesion"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" />  <br />"
$THTML:=$THTML+"       <span class="+<>ZGuil+"textepetit"+<>ZGuil+">"+(55*" ")+DiaWebTraduitTexte ("La recherche lésion se déclenche";$Langue)+"</span><br />"+<>ZCR

  //Si ($french)
  //$THTML:=$THTML+"        Pour afficher le détail d'une lésion, cliquez sur l'image du détail de la ligne correspondante<br />"+<>ZCR
  //$THTML:=$THTML+"      Pour chercher les lésions qui contiennent une chaine de caractère*, entrez-la dans le champ suivant : "
  //$THTML:=$THTML+"<input id="+<>ZGuil+"cherchelesion"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" />  <br />"
  //$THTML:=$THTML+"       <span class="+<>ZGuil+"textepetit"+<>ZGuil+">"+(55*" ")+"* La recherche se déclenche au troisième caractère entré et porte sur le nom de la lésion, la fiche réflexe et la description de la lésion.</span><br />"+<>ZCR
  //Sinon
  //$THTML:=$THTML+"        To view the details of a lesion, click the image of the detail of the corresponding line<br />"+<>ZCR
  //$THTML:=$THTML+"        To search the lesions that containing a string *, enter it in the following field: "
  //$THTML:=$THTML+"<input id="+<>ZGuil+"cherchelesion"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" />  <br />"
  //$THTML:=$THTML+"       <span class="+<>ZGuil+"textepetit"+<>ZGuil+">"+(25*" ")+"* The research, starting after the third character entered, focuses on the name of the lesion, what do you do and description of the lesion.</span><br />"+<>ZCR
  //Fin de si
$THTML:=$THTML+"      </p>"+<>ZCR
If (Gibier)
	QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1>80000)
	RELATE ONE SELECTION:C349([Diapositives:40];[DiaLesions:44])
Else 
	ALL RECORDS:C47([DiaLesions:44])
End if 
$FT:=String:C10(Records in selection:C76([DiaLesions:44]))
$THTML:=$THTML+"      <input id="+<>ZGuil+"nbtotal"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$FT+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      <input id="+<>ZGuil+"nbactuel"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$FT+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"listelesion"+<>ZGuil+">"+<>ZCR
  //Si (Gibier)
$THTML:=$THTML+DiaWebCreationHTMLListeLesions ($Langue;True:C214)
  //Sinon 
  //$THTML:=$THTML+DiaWebCreationHTMLListeLesions ($Langue)
  //Fin de si 
$THTML:=$THTML+"      </div>"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"ledetaillesion"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte ("Cliquer sur l'icône du détail lésion";$Langue)+<>ZCR

  //Si ($french)
  //$THTML:=$THTML+"        Cliquer sur l'icône du détail pour obtenir le contenu de la lésion."+<>ZCR
  //Sinon
  //$THTML:=$THTML+"        Click the icon detail of lesion you want to display the content."+<>ZCR
  //Fin de si
$THTML:=$THTML+"      </div>"+<>ZCR
  // $THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia.js"+<>ZGuil+"></script>"+<>ZCR

If ($Ajax)
	WEB SEND TEXT:C677($THTML)
Else 
	$0:=$THTML
End if 
ZAmnistieInternationale 
  //  FIXER TEXTE DANS CONTENEUR($THTML)
