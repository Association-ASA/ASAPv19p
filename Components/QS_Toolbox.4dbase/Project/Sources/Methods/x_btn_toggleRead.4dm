//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Olivier GRIMBERT
  // Date et heure : 05/04/16, 15:45:54
  // ----------------------------------------------------
  // Méthode : ogX_btn_toogleRead
  // Description
  // 
  //
  // Paramètres
  // $1 <PTR> : sur bouton image
  // $0 <INT> : valeur du toogle
  // ----------------------------------------------------

C_POINTER:C301($ptrButton)
$ptrButton:=$1
C_LONGINT:C283($value;$k)

C_TEXT:C284($btnFormat)
If ($ptrButton=Null:C1517)
	TOOL_TraceIfNotCompiled 
	$value:=0
Else 
	$btnFormat:=OBJECT Get format:C894($PtrButton->)
	$k:=Position:C15(".png";$btnFormat)
	  //$value:=Num(Substring($btnFormat;$k-1;1))
	
	C_TEXT:C284($char)
	C_LONGINT:C283($nbDigits)
	$char:=Substring:C12($btnFormat;$k-2;1)  // Check if 0-9 digit on dizains
	$nbDigits:=Num:C11(($char>="0") & ($char<="9"))+1  // nb digits : 1 or 2
	$value:=Num:C11(Substring:C12($btnFormat;$k-$nbDigits;$nbDigits))
End if 
$0:=$value

