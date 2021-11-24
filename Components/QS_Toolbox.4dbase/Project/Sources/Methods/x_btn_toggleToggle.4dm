//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Olivier GRIMBERT
  // Date et heure : 05/04/16, 15:51:05
  // ----------------------------------------------------
  // Méthode : ogX_btn_toogleToogle
  // Description
  // 
  //
  // Paramètres
  // $1 <PTR> : sur bouton image
  // $2 <INT> : modulo du toogle
  // $0 <INT> : valeur du toogle
  // ----------------------------------------------------


C_POINTER:C301($ptrButton)
C_LONGINT:C283($modulo)
$ptrButton:=$1
$modulo:=$2

  //C_TEXT($btnFormat)
  //C_LONGINT($k;$value)
  //$btnFormat:=OBJECT Get format($PtrButton->)
  //$k:=Position(".png";$btnFormat)
  //$value:=Num(Substring($btnFormat;$k-1;1))
  //$value:=($value+1)%$modulo
  //OBJECT SET FORMAT($PtrButton->;Substring($btnFormat;1;$k-2)+String($Value)+Substring($btnFormat;$k))

C_LONGINT:C283($value)
$value:=x_btn_toggleRead ($ptrButton)
$value:=($value+1)%$modulo
x_btn_toggleSet ($ptrButton;$value)

$0:=$value

