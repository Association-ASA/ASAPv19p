//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 20/02/18, 16:13:08
// ----------------------------------------------------
// Méthode : FILE_GetRessourceApplication
// Description
C_TEXT:C284($0)
C_TEXT:C284($path; $substring)
$path:=Path to object:C1547(Application file:C491).parentFolder

If (Is macOS:C1572)
	$substring:=Path to object:C1547(Application file:C491).name+Path to object:C1547(Application file:C491).extension+Replace string:C233("/Contents/Resources/"; "/"; Folder separator:K24:12)
Else 
	$substring:=Replace string:C233("Resources/"; "/"; Folder separator:K24:12)
End if 

$0:=$path+$substring