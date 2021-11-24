//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 04/06/20, 11:51:02
  // ----------------------------------------------------
  // Méthode : MCC_tidy_addCallees
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_OBJECT:C1216($1;$method)
C_COLLECTION:C1488($2;$collName;$meth;$data)
C_TEXT:C284($onePath;$3;$oneCall;$methodName;$choice;$4)

$method:=$1
$collName:=$2
$onePath:=$3
$choice:=$4

$methodName:=$method.name
  //$root:=$onePath+"."+$methodName
$pos:=$collName.indexOf($onePath+"."+$methodName)

If ($pos=-1)  // not found
	$collName.push($onePath+"."+$methodName)
	$data:=Storage:C1525.allMethods
	
	If ($method[$choice].length>0)
		
		For each ($oneCall;$method[$choice])
			
			$meth:=$data.indices("name =:1";$oneCall)
			$pos2:=$collName.indexOf($onePath+"."+$oneCall)
			
			If ($pos2=-1)  // not found
				MCC_tidy_addCallees ($data[$meth[0]];$collName;$onePath;$choice)
			End if 
		End for each 
	End if 
End if 