//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 28/02/16, 11:20:07
// ----------------------------------------------------
// Méthode : HTML_escapeCharacters
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($text; $1; $0)

$text:=$1

$text:=Replace string:C233($text; "ä"; "&auml;"; *)
$text:=Replace string:C233($text; "ö"; "&ouml;"; *)
$text:=Replace string:C233($text; "ü"; "&uuml;"; *)
$text:=Replace string:C233($text; "Ä"; "&Auml;"; *)
$text:=Replace string:C233($text; "Ö"; "&Ouml;"; *)
$text:=Replace string:C233($text; "Ü"; "&Uuml;"; *)

$text:=Replace string:C233($text; "&"; "&amp;"; *)
$text:=Replace string:C233($text; "\""; "&quot;"; *)
$text:=Replace string:C233($text; "'"; "&#039;"; *)

$text:=Replace string:C233($text; "<"; "&lt;"; *)
$text:=Replace string:C233($text; ">"; "&gt;"; *)
$text:=Replace string:C233($text; "\n\r"; "<br/>"; *)
$text:=Replace string:C233($text; "\r\n"; "<br/>"; *)
$text:=Replace string:C233($text; "\n"; "<br/>"; *)
$text:=Replace string:C233($text; "\r"; "<br/>"; *)
$text:=Replace string:C233($text; "\t"; "&nbsp;"*4; *)

$0:=$text
