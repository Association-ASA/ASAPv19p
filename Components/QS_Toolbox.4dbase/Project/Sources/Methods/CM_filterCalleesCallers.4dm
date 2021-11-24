//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 22/02/19, 16:35:48
  // Paramètres
  // ----------------------------------------------------
  // $1 : Object (row)
  // $2 : collection of methods to use to reduce the list
  // ----------------------------------------------------
  // Méthode : CM_filterCalleesCallers
  // Description
  // 


C_OBJECT:C1216($1)
C_COLLECTION:C1488($2)

$1.result:=False:C215  // By default, not displayed

If ($2.countValues($1.value.name)>0)
	$1.result:=True:C214
End if 