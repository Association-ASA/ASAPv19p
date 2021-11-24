//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// {$1} : duration
// {$2} : process number
// ----------------------------------------------------
// Méthode : PROCESS_sleep
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 26/04/20, 08:23:37
// Paramètres

$duration:=1
$process:=Current process:C322

If (Count parameters:C259>=1)
	$duration:=$1
End if 

If (Count parameters:C259>=2)
	$process:=$2
End if 

DELAY PROCESS:C323($process; $duration)