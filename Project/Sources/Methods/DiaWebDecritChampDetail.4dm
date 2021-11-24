//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 20/07/16, 09:35:21
// ----------------------------------------------------
// Méthode : WebDecritChampDetail
// Description
//  Permet de créer le HTML de la page Web
// d'un champ s'il existe
// Paramètres $1 = valeur du champ,
//  $2=intitulé en français du champ,
// $3=intitulé en anglais du champ,
// $4=vrai si français faux si anglais
// ----------------------------------------------------
C_TEXT:C284($2; $ValChamp; $3; $IntitleChamp; $THTML; $Texte; $0)
C_BOOLEAN:C305($4)
If ($4)  // en français
	$ValChamp:=$1
	$IntitleChamp:=$2
Else   // Gestion de l'anglais
	$ValChamp:=DiaWebTraduitTexte($1; "A")
	$IntitleChamp:=$3
End if 
If (Length:C16($ValChamp)>0)
	$THTML:="          <b>"+$2+"</b>: <br />"+<>ZCR
	$Texte:=Replace string:C233($ValChamp; <>ZCR2; <>ZCR)
	$THTML:=$THTML+"          "+Replace string:C233($Texte; <>ZCR; "<br />")
	$THTML:=$THTML+"          <br /><br />"
Else 
	$THTML:=""
End if 
$0:=$THTML