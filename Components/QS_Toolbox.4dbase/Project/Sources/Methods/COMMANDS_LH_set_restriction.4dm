//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 15/03/19, 21:33:37
  // Paramètres
  // ----------------------------------------------------
  // $1 : object of Command list
  // $2 : pointer on the List
  // $3 : pointer on the icon
  // $4 : text -> name of the criteria
  // ----------------------------------------------------
  // Méthode : COMMANDS_LH_set_restriction
  // Description

C_COLLECTION:C1488($c)
$c:=$1.restriction
$i:=$c.indexOf($4)
If ($i>=0)
	LH_add_Icon ($2;0;$3)
End if 