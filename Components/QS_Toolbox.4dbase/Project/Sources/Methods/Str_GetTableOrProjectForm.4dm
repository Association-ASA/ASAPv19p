//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 21:48:19
  // ----------------------------------------------------
  // Paramètres
  // $1 = table number, 0 if project form
  // $0 = Text
  // ----------------------------------------------------
  // Méthode : Str_GetTableOrProjectForm
  // Description
  //  

C_LONGINT:C283($1)
C_TEXT:C284($0)

If ($1>0)  // This is a table
	$0:="["+Table name:C256($1)+"]"
Else 
	$0:="{Project form}"
End if 