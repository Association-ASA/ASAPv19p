//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 20/01/16, 08:21:37
// ----------------------------------------------------
// Méthode : WebAfficheProposeLesions
// Description
// Reçoit et traite une requête AAX type
//  predictif + lettres tapées
// Paramètre $1 = requête AJAX 
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
$Ajax:=$1
$Ajax:="@"+Substring:C12($Ajax; 10)+"@"
QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=$Ajax)
SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1; $TbLes)
$Envoi:="["

$FT:=Size of array:C274($TbLes)
$T:=""
For ($Salé; 1; $FT)
	$T:=$T+","+$TbLes{$Salé}
End for 
$T:=Substring:C12($T; 2)
$Envoi:="["+$T+"]"
WEB SEND TEXT:C677($Envoi)
