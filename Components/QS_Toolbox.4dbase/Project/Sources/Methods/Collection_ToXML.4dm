//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// PM: "collectionToXml" (new LV 20.05.20, 17:28:12)
// $1 - C_COLLECTION - Collection to dump out as XML
// $2 - C_TEXT - Name of the list for titles and filename (when empty than auto created)
// $3 - C_TEXT - Timelinetext (when empty than auto created)

C_COLLECTION:C1488($col; $1)
C_TEXT:C284($nameInfo; $2)
C_TEXT:C284($timeInfo; $3)

C_TEXT:C284($srcTxtStart; $srcTxtEnd)
C_COLLECTION:C1488($colBodyRow; $colKeys; $colKeysHead)
C_TEXT:C284($headRowTxt; $bodyRowsTxt; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $rowSeparator)

If (Count parameters:C259>0)
	$col:=$1.copy()
End if 

If (Count parameters:C259>1)
	$nameInfo:=$2
End if 

If (Count parameters:C259>2)  // $3 or automatic standard timeInfo
	$timeInfo:=$3
End if 
$timeInfo:=String:C10(Current date:C33; System date long:K1:3)+" "+Lowercase:C14(String:C10(Current time:C178; HH MM AM PM:K7:5))

C_TEXT:C284($lineBreak)
If (Is macOS:C1572)
	$lineBreak:=Char:C90(Line feed:K15:40)
Else 
	$lineBreak:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 

$srcTxtStart:=""
$srcTxtStart:=$srcTxtStart+"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<listroot>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<metainfo>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<listtitle>Collection: "+$nameInfo+"</listtitle>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<timeline>"+$timeInfo+"</timeline>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"</metainfo>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<list>"+$lineBreak

$srcTxtEnd:=""
$srcTxtEnd:=$srcTxtEnd+"</list>"+$lineBreak
$srcTxtEnd:=$srcTxtEnd+"</listroot>"

$txtResult:=""

C_COLLECTION:C1488($colReplace)
$colReplace:=New collection:C1472
$colReplace.push(New object:C1471("from"; "&"; "to"; "&amp;"))  // "&" must be first one in collection !!!
$colReplace.push(New object:C1471("from"; "<"; "to"; "&lt;"))
$colReplace.push(New object:C1471("from"; ">"; "to"; "&gt;"))
$colReplace.push(New object:C1471("from"; "\""; "to"; "&quot;"))
$colReplace.push(New object:C1471("from"; "\t"; "to"; " "))
$colReplace.push(New object:C1471("from"; "\r\n"; "to"; " "))
$colReplace.push(New object:C1471("from"; "\r"; "to"; " "))
$colReplace.push(New object:C1471("from"; "\n"; "to"; " "))

$headRowTxt:=""
If (Value type:C1509($col[0])=Is object:K8:27)
	$colKeys:=OB_keys($col[0])
End if 
//$colKeysHead:=yColKeysCollectionTo ($colKeys;True)  // Get active items titles
$colKeysHead:=$colKeys.copy()

$bodyRowsTxt:=""
//$colKeys:=yColKeysCollectionTo ($colKeys;False)  // Get active items keys
$rowPrefix:="<item>"+$lineBreak
$rowSuffix:="</item>"+$lineBreak
$cellPrefix:="<itemprop key=\"###+keytitle+###\">"
$cellSuffix:="</itemprop>"+$lineBreak
$cellSeparator:=""
$rowSeparator:=""

If ($colKeys.length>0)
	$colBodyRow:=$col.map("colMapJoin"; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $colReplace; $colKeys; $colKeysHead)
Else 
	$colBodyRow:=$col.map("colMapJoin"; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $colReplace)
End if 
$bodyRowsTxt:=$colBodyRow.join($rowSeparator)

$srcTxt:=$srcTxtStart+$headRowTxt+$bodyRowsTxt+$srcTxtEnd
LV_CreateOpenTxtDoc($srcTxt; $nameInfo; ".xml")
