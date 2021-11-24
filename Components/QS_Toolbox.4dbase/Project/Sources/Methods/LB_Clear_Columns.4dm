//%attributes = {"invisible":true,"shared":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Méthode : LB_Clear_Columns
  // ----------------------------------------------------
  // Paramètres
  // $1 = $ListBoxName
  // {$2} = number of colou 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 28/06/18, 11:02:29
  // Description
  //  


C_TEXT:C284($1;$ListBoxName)
C_LONGINT:C283($2;$Start)
C_LONGINT:C283($3;$Number)

ASSERT:C1129(Count parameters:C259>=1;"Need, at least the listbox name")

$ListBoxName:=$1
$Start:=1
$Number:=LISTBOX Get number of columns:C831(*;$ListBoxName)

If (Count parameters:C259>1)
	$Start:=$2
End if 

If (Count parameters:C259>2)
	$Number:=$3
End if 

LISTBOX DELETE COLUMN:C830(*;$ListBoxName;$start;$Number)