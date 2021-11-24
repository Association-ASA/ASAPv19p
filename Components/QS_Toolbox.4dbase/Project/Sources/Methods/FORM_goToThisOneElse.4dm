//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // $1 : Page number to go
  // {$2} : Page number to return in case. 1 by default
  // ----------------------------------------------------
  // Méthode : page_goToThisOneElse
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : sieste68
  // Date et heure : 11/02/20, 11:31:36
  // Paramètres

C_LONGINT:C283($1)

$goToThisPage:=$1
$returnPage:=1

If (Count parameters:C259=2)
	C_LONGINT:C283($2)
	$returnPage:=$2
End if 

If (FORM Get current page:C276#$goToThisPage)
	FORM GOTO PAGE:C247($goToThisPage)
Else 
	FORM GOTO PAGE:C247($returnPage)
End if 