//%attributes = {}
  //xxDoa_methodExists (methodName_t) -> bool
  //retourne si une méthode de ce nom existe dans l'hôte
  //cf. xxDoa_formExists

C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_TEXT:C284($filtre_t)

$0:=False:C215  //pessimiste
If (Count parameters:C259>0)
	$filtre_t:=$1
	ARRAY TEXT:C222($methodName_at;0)
	METHOD GET NAMES:C1166($methodName_at;$filtre_t;*)  //*=host methods
	$0:=(Find in array:C230($methodName_at;$filtre_t)>0)
End if 
