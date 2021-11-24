//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 19/05/16, 08:26:20
  // ----------------------------------------------------
  // méthode : OTHERS_GetTableNum
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($Table)
C_LONGINT:C283($0)
C_LONGINT:C283($N)

$pos:=Position:C15("]";$1->)
$Table:=Substring:C12($1->;2;$pos-2)

For ($N;1;Get last table number:C254)
	If (Is table number valid:C999($n))
		If (Table name:C256($n)=$Table)
			$0:=$n
			$n:=Get last table number:C254
		End if 
	End if 
End for 
