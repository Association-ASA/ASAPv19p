//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 22/04/18, 11:44:56
// ----------------------------------------------------
// action : ZLBModifierSelectionOrda
// Description
// action qui s'applique à toute modification de sélection
// dans le cadre d'une gestion LB Standard
// ----------------------------------------------------


$coll:=New collection:C1472
$coll.push(New object:C1471("titre"; "Tous"; "action"; "all"))
$coll.push(New object:C1471("titre"; "Fiches sélectionnées"; "action"; "selections"))
$coll.push(New object:C1471("titre"; "Fiches non sélectionnées"; "action"; "lesAutres"))
$coll.push(New object:C1471("titre"; "Ajouter à sélection"; "action"; "etendre"))
$coll.push(New object:C1471("titre"; "Recherche standard"; "action"; "cherche"))
$coll.push(New object:C1471("titre"; "Reprendre sélection"; "action"; "oups"))

var $menu : cs:C1710.interface
$menu:=cs:C1710.interface.new()
$es:=$menu.menu($coll)

//If ($es#Null) // OK
//If ($es#Is null) // KO
If (Not:C34(OB Is empty:C1297($es)))  // OK
	// $es : issu de la fonction menu de la classe interface
	orda_affLBpersonnes($es)
End if 

