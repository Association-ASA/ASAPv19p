//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 20/06/18, 09:03:38
// ----------------------------------------------------
// Paramètres
// $1 = Pointer on the text to check
// ----------------------------------------------------
// Méthode : TOOL_strimCharacters
// Description
// Transform PathName of Method (database, all objects...) on  a valid pathname to be saved on disk
// Remove characters forbidden by filesystems

ASSERT:C1129(Value type:C1509($1)=Is pointer:K8:14; "$1 must be a pointer on a text")
C_TEXT:C284($Path)

$Path:=$1->

If (Position:C15("%3C"; $Path)>0)
	$Path:=Replace string:C233($Path; "%3C"; "Diamond_")  //  ">"
	$Path:=Replace string:C233($Path; "%3E"; "")  // "<"
End if 

$Path:=Replace string:C233($Path; "/"; "_"; *)
$Path:=Replace string:C233($Path; "{"; ""; *)
$Path:=Replace string:C233($Path; "}"; ""; *)
$Path:=Replace string:C233($Path; "["; ""; *)
$Path:=Replace string:C233($Path; "]"; ""; *)
$Path:=Replace string:C233($Path; ":"; "."; *)

$1->:=$Path