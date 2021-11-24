//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
#DECLARE($ent : Object)

var $ent2 : Object
var $clearCode; $methodName; $oneCall : Text
var $colCallees : Collection

$methodName:=$ent.name
$clearCode:=$ent.clearCode  // Get the reference, not a deep copy ;-)
/*
Regex for only one name:
(?<!(\$)|(<>))\b(yColToAttrCreate)\b

Regex with a list of two names:
(?<!(\$)|(<>))\b((yColToAttrCreate)|(collectionToCsv))\b
*/

$case:=2
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "X: "+$methodName)

Case of 
	: ($case=1)  // By default --> Best results
		$criteria:=Storage:C1525.text.PMlist
		$colCallees:=LV_RegexMatchG($clearCode; $criteria).distinct()
		
	: ($case=2)  // Worst case --> worst results
		$add:=False:C215
		$data:=Storage:C1525.allMethods
		
		For each ($ent2; $data)
			
			If (Position:C15($methodName+" "; $ent2.clearCode)>0)
				$add:=True:C214
			Else 
				If (Position:C15("\""+$methodName+"\""; $ent2.clearCode)>0)
					$add:=True:C214
				End if 
			End if 
			
			If ($add)
				Use ($data)
					$ent2.callers.push($methodName)
					If (OB Is empty:C1297($ent)=False:C215)
						$ent.callees.push($ent2.name)
					End if 
				End use 
				
				$add:=False:C215
			End if 
			
		End for each 
		
		
	: ($case=3)  // Intermediate case
		$colCallees:=New collection:C1472
		$pass:=False:C215
		
		For each ($ent2; $data) While (Not:C34($pass))
			Case of 
				: (Position:C15($methodName+" "; $ent.code)>0)
					$colCallees.push($methodName)
					$pass:=True:C214
				: (Position:C15("\""+$methodName+"\""; $ent.code)>0)
					$colCallees.push($methodName)
					$pass:=True:C214
			End case 
		End for each 
		
	: ($case=4)
		$param:=New collection:C1472
		$param.push("@"+$methodName+" @")
		$param.push("@"+$methodName+";@")
		$param.push("@"+$methodName+"(@")
		$param.push("@"+$methodName+")@")
		$param.push("@"+$methodName+"\"@")
		$param.push("@"+$methodName+"\n@")
		$param.push("@"+$methodName+"\r@")
		
		$subData:=Storage:C1525.allMethods.query("clearCode IN :1"; $param)
		
		Use (Storage:C1525.allMethods)
			For each ($ent2; $subData)
				$ent2.callers.push($methodName)
				If (OB Is empty:C1297($ent)=False:C215)
					$ent.callees.push($ent2.name)
				End if 
			End for each 
		End use 
		
End case 

If (Count parameters:C259=2)
	var $2 : Object
	signal_addResult($2; Current method name:C684)
End if 
