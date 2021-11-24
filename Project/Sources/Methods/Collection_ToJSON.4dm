//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// PM: "collectionToJson" (new LV 21.05.20, 09:03:40)
// $1 - C_COLLECTION - Collection to dump out as JSON
// $2 - C_TEXT - Name of the list for titles and filename (when empty than auto created)
// $3 - C_TEXT - Timelinetext (when empty than auto created))
// Dumps out a collection as JSON

C_COLLECTION:C1488($col; $1)
C_TEXT:C284($nameInfo; $2)
C_TEXT:C284($timeInfo; $3)
C_TEXT:C284($srcTxt)
C_COLLECTION:C1488($colKeys)

If (Count parameters:C259>0)
	$col:=$1.copy()
End if 

If (Count parameters:C259>1)
	$nameInfo:=$2
End if 

If (Count parameters:C259>2)  // $3 or automatic standard timeInfo
	$timeInfo:=$3
Else 
	$timeInfo:=String:C10(Current date:C33; System date long:K1:3)+" "+Lowercase:C14(String:C10(Current time:C178; HH MM AM PM:K7:5))
End if 

$colKeys:=New collection:C1472
If ($col.length>0)
	If (Value type:C1509($col[0])=Is object:K8:27)
		$colKeys:=OB Keys:C1719($col[0])
	End if 
End if 

$txtResult:=""
$srcTxt:=JSON Stringify:C1217(Collection_Extract($col; $colKeys; $colKeys); *)

LV_CreateOpenTxtDoc($srcTxt; $nameInfo; ".JSON")