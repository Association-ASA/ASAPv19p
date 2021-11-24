//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 28/08/18, 10:12:59
  // ----------------------------------------------------
  // Méthode : WebPanierEnvoiAffiche
  // Description
  // 
  //
  // Paramètre $1 = chaine AJAX de type "panierenvoyer5014"
  //                OÙ 5014 = Numéro enregistrement([XDonnees])
  // ----------------------------------------------------

$Mess:=$1
$Langue:=$Mess[[Length:C16($Mess)]]
$NumEnrPanierN:=Num:C11($Mess)
$NumEnrPanierA:=String:C10($NumEnrPanierN)
GOTO RECORD:C242([DiaData:45];$NumEnrPanierN)

$THTML:=""
$THTML:=$THTML+"      <br /> <br /> <span class="+<>ZGuil+"panierconsigne"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte ("Pour envoyer le panier";$Langue)+" "+<>ZGuil+[DiaData:45]XNom:1+<>ZGuil
$THTML:=$THTML+DiaWebTraduitTexte ("à d'autres utilisateurs d'AsaDia";$Langue)+".<br />"
$THTML:=$THTML+"        "+DiaWebTraduitTexte ("Si vous mettez votre propre adresse mail";$Langue)
$THTML:=$THTML+"      </span>"+<>ZCR
$THTML:=$THTML+"      <input id="+<>ZGuil+"NumEnrPanierA"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$NumEnrPanierA+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"        <br /><br />"+<>ZCR
$THTML:=$THTML+"      <label for="+<>ZGuil+"login"+<>ZGuil+"><i>"+DiaWebTraduitTexte ("Login AsaDia";$Langue)+"</i></label> <br />"+<>ZCR
If (False:C215)
	$THTML:=$THTML+"      <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"login"+<>ZGuil+" value="+<>ZGuil+""+<>ZGuil
	$THTML:=$THTML+" size="+<>ZGuil+"70"+<>ZGuil+" maxlength="+<>ZGuil+"150"+<>ZGuil+">"+<>ZCR
Else 
	$THTML:=$THTML+"      <textarea name="+<>ZGuil+"login"+<>ZGuil+" id="+<>ZGuil+"login"+<>ZGuil+" cols="+<>ZGuil+"50"+<>ZGuil+" rows="+<>ZGuil+"8"+<>ZGuil+"></textarea>"
End if 
$THTML:=$THTML+"      <div class="+<>ZGuil+"erreur"+<>ZGuil+" id="+<>ZGuil+"paniererreur"+<>ZGuil+"></div>"
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"
$THTML:=$THTML+"        <button  class="+<>ZGuil+"adtitre2e"+<>ZGuil+" id="+<>ZGuil+"panierenvoisumit"+<>ZGuil+">"+DiaWebTraduitTexte ("Envoyer le panier";$Langue)+"</button> "
$THTML:=$THTML+"        <button  class="+<>ZGuil+"adtitre3e"+<>ZGuil+" id="+<>ZGuil+"panierenvoireset"+<>ZGuil+">"+DiaWebTraduitTexte ("Ne PAS l'envoyer";$Langue)+"</button> "
WEB SEND TEXT:C677($THTML)
