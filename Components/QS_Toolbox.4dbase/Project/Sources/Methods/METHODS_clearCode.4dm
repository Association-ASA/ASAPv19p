//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // $1 : object
  // ----------------------------------------------------
  // Méthode : METHODS_clearCode
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 04/10/19, 08:15:15
  // Paramètres

C_OBJECT:C1216($1)
C_TEXT:C284($MethText)

$MethText:=$1.code
$1.nbComment:=METHOD_getCleanCode (->$MethText)
$1.clearCode:=$MethText