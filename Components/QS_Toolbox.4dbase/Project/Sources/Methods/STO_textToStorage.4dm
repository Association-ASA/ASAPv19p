//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Méthode : ORDA_textToStorageShared
// ----------------------------------------------------
// Paramètres
// $1 = Attribut to create into Storage (Text)
// $2 = Value to save (Text)
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 12/07/18, 11:22:48
// Description
// example: Save any text information into Storage.text[$1]

C_TEXT:C284($1)
C_TEXT:C284($2)
C_OBJECT:C1216($Parameter)  // Goal: replace 'Parametre' variable

$Parameter:=Storage:C1525.text
Use ($Parameter)
	$Parameter[$1]:=$2
End use 