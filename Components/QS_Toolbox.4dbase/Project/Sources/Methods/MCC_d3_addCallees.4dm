//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($1;$method)
C_COLLECTION:C1488($2;$subRef;$subRef2;$collName;$3;$meth;$data)
C_TEXT:C284($oneCall;$methodName;$4;$choice)

$method:=$1
$subRef:=$2
$collName:=$3
$choice:=$4

$methodName:=$method.name
$pos:=$collName.indexOf($methodName)

If ($pos=-1)  // not found
	$collName.push($methodName)
	$data:=Storage:C1525.allMethods
	
	Case of 
		: ($method[$choice].length>0)
			
			$subRef.push(New object:C1471("name";$methodName;"size";1;"stroke";"#01579B";"fill";"#B3E3F3";"children";New collection:C1472))
			$subRef2:=$subRef[$subRef.length-1].children
			
			For each ($oneCall;$method[$choice])
				If ($collName.indexOf($oneCall)<0)
					
					$meth:=$data.indices("name =:1";$oneCall)
					
					If ($meth.length=1)
						MCC_d3_addCallees ($data[$meth[0]];$subRef2;$collName;$choice)
					End if 
				End if 
			End for each 
			
		: ($method[$choice].length=0)
			$subRef.push(New object:C1471("name";$methodName;"size";1;"stroke";"#01579B";"fill";"#B3E3F3"))
			
	End case 
	
	
End if 