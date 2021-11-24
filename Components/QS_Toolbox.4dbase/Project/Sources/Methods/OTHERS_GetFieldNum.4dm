//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 19/05/16, 08:31:09
  // ----------------------------------------------------
  // méthode : OTHERS_GetFieldNum
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_POINTER:C301($2)
C_LONGINT:C283($0;$1;$Table)
C_LONGINT:C283($N)

$Table:=$1
$pos:=Position:C15("]";$2->)
$Field:=Substring:C12($2->;$pos+1)

For ($N;1;Get last field number:C255(Table:C252($table)))  // on connait déjà la table
	If (Is field number valid:C1000($table;$N))
		If (Field name:C257($Table;$n)=$Field)
			$0:=$N
			$N:=Get last field number:C255(Table:C252($table))
		End if 
	End if 
End for 
