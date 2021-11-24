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
C_TEXT:C284($value_txt)

C_TEXT:C284($btnFormat)
If ($ptrButton=Null:C1517)
	TOOL_TraceIfNotCompiled 
	$value_txt:=""
Else 
	$btnFormat:=OBJECT Get format:C894($PtrButton->)
	$k1:=Position:C15("_";$btnFormat)
	$k2:=Position:C15(".";$btnFormat)
	If ($k1>0) & ($k2>0)
		$value_txt:=Substring:C12($btnFormat;$k1+1;$k2-$k1-1)
	End if 
End if 
$0:=$value_txt

