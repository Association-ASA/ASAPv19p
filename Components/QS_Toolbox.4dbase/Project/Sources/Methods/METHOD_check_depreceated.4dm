//%attributes = {"invisible":true,"preemptive":"capable","publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// $1 : Method to check
// $0 : Collection
// ----------------------------------------------------
// Méthode : METHOD_check_depreceated
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 23/09/19, 07:03:08
// Paramètres

// Keep only Deprecated commands
C_OBJECT:C1216($commandList)
C_TEXT:C284($path; $command; $1)
C_COLLECTION:C1488($coll; $method; $0)

ON ERR CALL:C155("Base_NoError")
$coll:=New collection:C1472
$path:=$1
//$method:=Storage.index[$path]
$method:=Storage:C1525.allMethods.query("name = :1"; $path)

If ($method#Null:C1517)
	For each ($commandList; $method)
		If ($commandList.commandUsed.length>0)
			For each ($command; $commandList.commandUsed)
				If ($command="_o_@")
					$coll.push($command)
				End if 
			End for each 
		End if 
	End for each 
End if 

$0:=$coll