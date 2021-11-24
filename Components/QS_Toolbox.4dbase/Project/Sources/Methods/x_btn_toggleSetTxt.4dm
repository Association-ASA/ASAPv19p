//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Olivier GRIMBERT
  // Date et heure : 05/04/16, 15:48:59
  // ----------------------------------------------------
  // Méthode : ogX_btn_toogleSet
  // Description
  // 
  //
  // Paramètres
  // $1 <PTR> : sur bouton image
  // $2 <TXT> : valeur du toogle entre "_" et "."
  // ----------------------------------------------------

C_POINTER:C301($ptrButton)
C_TEXT:C284($value)
$ptrButton:=$1
$value:=$2

C_TEXT:C284($btnFormat)
C_LONGINT:C283($k1;$k2)
$btnFormat:=OBJECT Get format:C894($PtrButton->)
$k1:=Position:C15("_";$btnFormat)
$k2:=Position:C15(".";$btnFormat)
If ($k1>0) & ($k2>0)
	OBJECT SET FORMAT:C236($PtrButton->;Substring:C12($btnFormat;1;$k1)+$Value+Substring:C12($btnFormat;$k2))
End if 

