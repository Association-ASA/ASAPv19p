//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 01/08/2020 22:34
  // Paramètres
  // ----------------------------------------------------
  // $1 : object of Command list
  // $2 : collection Command ID with restriction
  // $3 : text -> name of the criteria
  // 
  // ----------------------------------------------------
  // Méthode : COMMANDS_set_restriction
  // Description

C_LONGINT:C283($i)

$i:=$2.indexOf(Num:C11($1.token))
If ($i>=0)
	
	$i:=$1.restriction.indexOf($3)
	If ($i<0)
		$1.restriction.push($3)
	End if 
End if 