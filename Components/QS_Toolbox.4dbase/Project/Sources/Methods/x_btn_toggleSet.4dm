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
  // $2 <INT> : valeur du toogle
  // ----------------------------------------------------

C_POINTER:C301($ptrButton)
C_LONGINT:C283($value)
$ptrButton:=$1
$value:=$2

C_TEXT:C284($btnFormat)
C_LONGINT:C283($k)
If ($ptrButton=Null:C1517)
	TOOL_TraceIfNotCompiled 
	  //TRACE
Else 
	$btnFormat:=OBJECT Get format:C894($PtrButton->)
	$k:=Position:C15(".png";$btnFormat)
	  //OBJECT SET FORMAT($PtrButton->;Substring($btnFormat;1;$k-2)+String($Value)+Substring($btnFormat;$k))
	
	C_TEXT:C284($char)
	C_LONGINT:C283($nbDigits)
	$char:=Substring:C12($btnFormat;$k-2;1)  // Check if 0-9 digit on dizains
	$nbDigits:=Num:C11(($char>="0") & ($char<="9"))+1  // nb digits : 1 or 2
	OBJECT SET FORMAT:C236($PtrButton->;Substring:C12($btnFormat;1;$k-$nbDigits-1)+String:C10($Value)+Substring:C12($btnFormat;$k))
End if 


