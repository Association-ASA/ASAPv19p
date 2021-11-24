//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // $1 : collection
  // $0 : text
  // ----------------------------------------------------
  // Méthode : TOOLS_collectionToText
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 22/11/19, 10:58:44
  // Paramètres

C_TEXT:C284($0)
C_COLLECTION:C1488($1)
C_OBJECT:C1216($varObject)

If (Count parameters:C259=1)
	If ($1#Null:C1517)
		$varObject:=New object:C1471("collection";$1)
		$0:=JSON Stringify array:C1228($varObject.collection)
	End if 
End if 