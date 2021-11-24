//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// $1 : object (signal)
// $2: $customMessage (texte)
// ----------------------------------------------------
// Méthode : signal_addResult
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 20/05/20, 22:30:15
// Paramètres

C_OBJECT:C1216($1; $signal; $resultat)
C_COLLECTION:C1488($messages)
C_LONGINT:C283($maxExpected)
C_TEXT:C284($customMessage; $2)

$signal:=$1
$customMessage:=$2
$maxExpected:=$signal.nbResult

$resultat:=New shared object:C1526()
$messages:=New shared collection:C1527()

$signal.resultats.push($resultat)
Use ($messages)
	$messages.push($customMessage)
End use 

Use ($resultat)
	$resultat.statut:=True:C214
	$resultat.message:=$messages
End use 

If ($signal.resultats.length=$maxExpected)
	$signal.trigger()
	PROCESS_sleep
	KILL WORKER:C1390
End if 