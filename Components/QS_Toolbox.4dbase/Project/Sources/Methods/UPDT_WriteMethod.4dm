//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 19/11/17, 19:38:36
  // ----------------------------------------------------
  // Méthode : UPDT_WriteMethod
  // Description
  //  UPDT_WriteMethod(MethodeName;Code)
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$code;$meth;$MethodeName)

ASSERT:C1129(Count parameters:C259=2;"Need 2 parameter")
ASSERT:C1129(Type:C295($1)=Is text:K8:3;"$1 must be a TEXT")
ASSERT:C1129(Type:C295($2)=Is text:K8:3;"$2 must be a TEXT")

$MethodeName:=$1
$code:=$2

STO_textToStorage ("onError";$MethodeName)

$meth:=Method called on error:C704
ON ERR CALL:C155("BASE_noERROR")
METHOD SET CODE:C1194($MethodeName;$code;*)
ON ERR CALL:C155($meth)
STO_textToStorage ("onError";"")
