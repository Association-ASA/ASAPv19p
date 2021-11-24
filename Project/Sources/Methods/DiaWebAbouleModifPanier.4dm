//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 26/08/18, 06:53:44
// ----------------------------------------------------
// Méthode : WebAbouleModifPanier
// Description
//
//
// Paramètre $1 = message Ajax type "paniervoir8071"
// où 8071 = num enregistrement de la [XDonnees] du panier
// ----------------------------------------------------

$Mess:=$1
$Langue:=$Mess[[Length:C16($Mess)]]
$NumEnrPanierA:=Substring:C12($Mess; 11)
$NumEnrPanierN:=Num:C11($NumEnrPanierA)
GOTO RECORD:C242([DiaData:45]; $NumEnrPanierN)
$NomPanier:=[DiaData:45]XNom:1
$Initiales:=[DiaData:45]XType:5
$Descriptif:=[DiaData:45]XTexteSup:8
$Login:=[DiaData:45]XAlpha:14

$THTML:=""
$THTML:=$THTML+"      <br /> <br /> <span class="+<>ZGuil+"panierconsigne"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte("Si vous désirez changer le descriptif"; $Langue)
$THTML:=$THTML+"      </span>"+<>ZCR
$THTML:=$THTML+"      <input id="+<>ZGuil+"NumEnrPanierA"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$NumEnrPanierA+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"        <br /><br />"+<>ZCR
$THTML:=$THTML+"      <label for="+<>ZGuil+"nompanier"+<>ZGuil+"><i>"+DiaWebTraduitTexte("Nom du panier"; $Langue)+"</i></label> "
$THTML:=$THTML+"      <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"nompanier"+<>ZGuil+" value="+<>ZGuil+$NomPanier+<>ZGuil
$THTML:=$THTML+" size="+<>ZGuil+"30"+<>ZGuil+" maxlength="+<>ZGuil+"30"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <br /><br />"+<>ZCR
$THTML:=$THTML+"      <label for="+<>ZGuil+"initcreateur"+<>ZGuil+"><i>"+DiaWebTraduitTexte("Initiales du créateur"; $Langue)+"</i></label> "
$THTML:=$THTML+"      <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"initcreateur"+<>ZGuil+" value="+<>ZGuil+$Initiales+<>ZGuil
$THTML:=$THTML+" size="+<>ZGuil+"10"+<>ZGuil+" maxlength="+<>ZGuil+"5"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"      <label for="+<>ZGuil+"companier"+<>ZGuil+"><i>"+DiaWebTraduitTexte("Description du panier"; $Langue)+"</i></label> "
$THTML:=$THTML+"<textarea name="+<>ZGuil+""+<>ZGuil+" id="+<>ZGuil+"companier"+<>ZGuil+" cols="+<>ZGuil+"55"+<>ZGuil+" rows="+<>ZGuil+"5"+<>ZGuil+">"+$Descriptif+"</textarea>"+<>ZCR
$THTML:=$THTML+"      <br /><br /><br /> "+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"
$THTML:=$THTML+"        <button  class="+<>ZGuil+"adtitre2e"+<>ZGuil+" id="+<>ZGuil+"paniersumit"+<>ZGuil+">"+DiaWebTraduitTexte("Modifier le descriptif"; $Langue)+"</button> "
$THTML:=$THTML+"        <button  class="+<>ZGuil+"adtitre3e"+<>ZGuil+" id="+<>ZGuil+"panierreset"+<>ZGuil+">"+DiaWebTraduitTexte("Ne PAS le modifier"; $Langue)+"</button><br/>"+<>ZCR
$THTML:=$THTML+"        <button  class="+<>ZGuil+"adtitre3e"+<>ZGuil+" id="+<>ZGuil+"paniertuer"+<>ZGuil+">"+DiaWebTraduitTexte("Supprimer le panier"; $Langue)+"</button> "+<>ZCR
$THTML:=$THTML+"      </p> "+<>ZCR

WEB SEND TEXT:C677($THTML)
// FIXER TEXTE DANS CONTENEUR($THTML)