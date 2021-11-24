//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($1;$method)
C_COLLECTION:C1488($2;$subRef;$collName;$pos;$data)
C_TEXT:C284($oneCall;$choice;$3)
$method:=$1
$collName:=$2
$choice:=$3

$methodName:=$method.name
$methodPath:=$method.path

$name:=$methodPath+"."+$methodName
$name:=Replace string:C233($name;"/";".")

$pos:=$collName.indices("name =:1";$name)

If ($pos.length=0)  // not found
	
	$subRef:=New collection:C1472
	$collName.push(New object:C1471("name";$name;"size";$method.timestamp;"imports";$subRef))
	$data:=Storage:C1525.allMethods
	
	Case of 
		: ($method[$choice].length>0)
			
			For each ($oneCall;$method[$choice])
				$pos:=$data.indices("name =:1";$oneCall)
				If ($pos#Null:C1517)
					MCC_d3_addCalleesBundling ($data[$pos[0]];$collName;$choice)
				End if 
				$subRef.push("Path project method."+$oneCall)
			End for each 
			
	End case 
End if 