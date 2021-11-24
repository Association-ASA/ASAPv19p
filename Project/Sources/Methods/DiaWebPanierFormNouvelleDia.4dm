//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 07/12/17, 07:48:15
// ----------------------------------------------------
// Méthode : WebPanierFormNouvelleDia
// Description
// Création du HTML lié à l'attribution d'une diapo
//  à un panier
// Paramètre $1=message Ajax  $2=login  $3=langage
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$Rang:=$1
$Login:=$2
$Langue:=$3
$THTML:=""
$THTML:=$THTML+"      <span class="+<>ZGuil+"panierconsigne"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte("Pour ajouter cette photo à un panier"; $Langue)
QUERY:C277([DiaData:45]; [DiaData:45]XAlpha:14=$Login; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XEntier:2=1951; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XBool:9=False:C215)
SELECTION TO ARRAY:C260([DiaData:45]XNom:1; $TbNomPaniers; [DiaData:45]XType:5; $TbInitialesPaniers)
LONGINT ARRAY FROM SELECTION:C647([DiaData:45]; $TbNumEnrPaniers)
$FT:=Size of array:C274($TbNomPaniers)
If ($FT>0)
	$THTML:=$THTML+", "+DiaWebTraduitTexte("soit en choisissant dans la liste"; $Langue)+<>ZCR
End if 
$THTML:=$THTML+"."
$THTML:=$THTML+"        <br />"+<>ZCR
$THTML:=$THTML+"        "+DiaWebTraduitTexte("Précisez les initiales du créateur"; $Langue)+<>ZCR
$THTML:=$THTML+"      </span>"+<>ZCR
$THTML:=$THTML+"      <input id="+<>ZGuil+"numdiapopanier"+$Rang+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+NumImageA+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"        <br /><br />"+<>ZCR
$THTML:=$THTML+"      <label for="+<>ZGuil+"nompanier"+$Rang+<>ZGuil+">"+DiaWebTraduitTexte("Nom du panier"; $Langue)+"</label> "
$THTML:=$THTML+"<input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"nompanier"+$Rang+<>ZGuil+" size="+<>ZGuil+"30"+<>ZGuil+" maxlength="+<>ZGuil+"30"+<>ZGuil+">"+<>ZCR
If ($FT>0)
	$THTML:=$THTML+"      <select id="+<>ZGuil+"pumpanier"+$Rang+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        <option value="+<>ZGuil+"rien"+<>ZGuil+">"+DiaWebTraduitTexte("Sélectionnez un panier"; $Langue)+"</option>"+<>ZCR
	For ($Salé; 1; $FT)
		$Initialecourante:=$TbInitialesPaniers{$Salé}
		$Qui:=(Num:C11($Initialecourante="")*("("+DiaWebTraduitTexte("tous"; $Langue)+")"))+(Num:C11($Initialecourante#"")*(" ("+$Initialecourante+")"))
		$THTML:=$THTML+"        <option value="+<>ZGuil+String:C10($TbNumEnrPaniers{$Salé})+<>ZGuil+">"+$TbNomPaniers{$Salé}+$Qui+"</option>"+<>ZCR
	End for 
	$THTML:=$THTML+"      </select>"+<>ZCR
End if 
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"      <label for="+<>ZGuil+"initcreateur"+$Rang+<>ZGuil+">"+DiaWebTraduitTexte("Initiales du créateur"; $Langue)+"</label> "
$THTML:=$THTML+"<input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"initcreateur"+$Rang+<>ZGuil+" size="+<>ZGuil+"10"+<>ZGuil+" maxlength="+<>ZGuil+"5"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"      <label for="+<>ZGuil+"companier"+$Rang+<>ZGuil+">"+DiaWebTraduitTexte("Description du panier"; $Langue)+"</label> "
$THTML:=$THTML+"<textarea name="+<>ZGuil+""+<>ZGuil+" id="+<>ZGuil+"companier"+$Rang+<>ZGuil+" cols="+<>ZGuil+"60"+<>ZGuil+" rows="+<>ZGuil+"5"+<>ZGuil+"></textarea>"+<>ZCR
$THTML:=$THTML+"      <br /> "+<>ZCR
$THTML:=$THTML+""+<>ZCR

$THTML:=$THTML+"      <button  class="+<>ZGuil+"adtitre2e"+<>ZGuil+" id="+<>ZGuil+"paniersumit"+$Rang+<>ZGuil+">"+DiaWebTraduitTexte("Ajouter au panier"; $Langue)+"</button> "
$THTML:=$THTML+"<button  class="+<>ZGuil+"adtitre3e"+<>ZGuil+" id="+<>ZGuil+"panierreset"+$Rang+NumImageA+<>ZGuil+">"+DiaWebTraduitTexte("Ne PAS ajouter au panier"; $Langue)+"</button> "+<>ZCR

$0:=$THTML
