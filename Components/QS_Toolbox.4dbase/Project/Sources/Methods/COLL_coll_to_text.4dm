//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : KB
  // Date et heure : 12/05/19, 22:14:52
  // Paramètres
  // ----------------------------------------------------
  // $1 : Collection to get as text
  // $0 : text representing the collection passed on $1
  // ----------------------------------------------------
  // Méthode : COLL_coll_to_text
  // Description
  // Description: Method returns a string form of collection without surrounding brackets
  // Parameters: $1 (Collection) - target collection 
  // https://kb.4d.com/assetid=78249

C_COLLECTION:C1488($1)
C_TEXT:C284($0;$json_t)
$json_t:=JSON Stringify:C1217($1)
$json_t:=Delete string:C232($json_t;0;1)
$0:=Delete string:C232($json_t;Length:C16($json_t);1)