//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 24/07/16, 10:03:18
// ----------------------------------------------------
// Méthode : WebAbouleListeDiapo
// Description
//  Méthode qui écrit le HTML de la liste des photos
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($Langue)
$Langue:=$1
$OnEcritTout:=$2
$listephoto:=DiaWebTraduitTexte("Liste des photos"; $Langue)
// le HTML
$THTML:=$listephoto+"£P5£"
If ($OnEcritTout)
	$THTML:=$THTML+DiaWebCreationHTMLDebutPage($Langue; VarLogin; $listephoto)+<>ZCR
End if 
$NomPDF:="Diapo"+$Langue
$THTML:=$THTML+DiaWebCreationHTMLAide($Langue; 1; $NomPDF)
$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"+$listephoto+"</p>"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR

$THTML:=$THTML+"        "+DiaWebTraduitTexte("Pour afficher le détail d'une photo"; $Langue)+"<br />"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte("Pour chercher les photos"; $Langue)
$THTML:=$THTML+"<input id="+<>ZGuil+"trouvephoto"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" />  <br />"
$THTML:=$THTML+"       <span class="+<>ZGuil+"textepetit"+<>ZGuil+">"+(55*" ")+DiaWebTraduitTexte("La recherche diapo se déclenche"; $Langue)+"</span><br />"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
If ($Langue#"F")
	QUERY:C277([Diapositives:40]; [Diapositives:40]NomLesion:4#"Ecoffrage"; *)
End if 
QUERY:C277([Diapositives:40];  & [Diapositives:40]NumOrdreDiapos:1>0; *)
If (Gibier)
	QUERY:C277([Diapositives:40];  & [Diapositives:40]NumOrdreDiapos:1>80000)  // on ne conserve que les gibiers
Else 
	QUERY:C277([Diapositives:40];  & [Diapositives:40]NumOrdreDiapos:1<80000)  // on enlève les gibiers
End if 
$FT:=String:C10(Records in selection:C76([Diapositives:40]))
$THTML:=$THTML+"      <input id="+<>ZGuil+"nbtotal"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$FT+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      <input id="+<>ZGuil+"nbactuel"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$FT+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"listephoto"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+DiaWebCreationHTMLListeDiapos($Langue)
$THTML:=$THTML+""+<>ZCR

$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"ledetailphoto"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      "+DiaWebTraduitTexte("Cliquer sur l'icône du détail photo"; $Langue)+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
// $THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia3.js"+<>ZGuil+"></script>"+<>ZCR

If ($OnEcritTout)
	LangueEnCours:=$Langue
	$THTML:=$THTML+<>ZCR+DiaWebCreationHTMLPiedPage(LangueEnCours)
End if 
$0:=$THTML
WEB SEND TEXT:C677($THTML)
// FIXER TEXTE DANS CONTENEUR($THTML)
ZAmnistieInternationale
