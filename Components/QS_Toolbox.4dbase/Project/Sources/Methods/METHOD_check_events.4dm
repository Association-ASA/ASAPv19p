//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// $1 : Method to check
// $0 : Collection
// ----------------------------------------------------
// Méthode : METHOD_check_events
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 23/09/19, 07:59:32
// Paramètres

#DECLARE($path : Text)->$coll : Collection

// Keep only Events
C_TEXT:C284($events; $language)
C_COLLECTION:C1488($coll; $found; $theEvent; $constants)
C_OBJECT:C1216($method)

ON ERR CALL:C155("Base_NoError")

$coll:=New collection:C1472
$language:=Config_getLanguage
$found:=Storage:C1525.allMethods.query("name = :1"; $path).copy()  // return a non-shared collection
$method:=$found[0]
//$method:=Storage.index[$path]
$constants:=Storage:C1525.constants.copy()

If ($method#Null:C1517)
	If ($method.constantToken.length>0)
		For each ($events; $method.constantToken)
			If ($events=":K2:@")
				$theEvent:=$constants.query("token =:1"; $events)
				$coll.push($theEvent[0][$language])
			End if 
		End for each 
	End if 
End if 
$coll:=$coll.distinct()