//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// PM: "collection_ToHtml" (new LV 19.05.20, 10:07:41)
// $1 - C_COLLECTION - Collection to dump out as HTML-Table
// $2 - C_TEXT - Name of the list for titles and filename (when empty than auto created)
// $3 - C_TEXT - Timelinetext (when empty than auto created)

C_TEXT:C284($srcTxt)
C_COLLECTION:C1488($col; $1)
C_TEXT:C284($nameInfo; $2)
C_TEXT:C284($timeInfo; $3)
C_TEXT:C284($srcTxtStart; $srcTxtEnd)
C_COLLECTION:C1488($colBodyRow; $colKeys)
C_TEXT:C284($headRowTxt; $bodyRowsTxt; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $rowSeparator)
ON ERR CALL:C155("BASE_noERROR")

If (Count parameters:C259>0)
	$col:=$1.copy()
End if 

If (Count parameters:C259>1)
	$nameInfo:=$2
Else 
	$nameInfo:="export_"+Replace string:C233(String:C10(Current date:C33); "/"; "_")
End if 

If (Count parameters:C259>2)  // $3 or automatic standard timeInfo
	$timeInfo:=$3
Else 
	$timeInfo:=String:C10(Current date:C33; System date long:K1:3)+" "+Lowercase:C14(String:C10(Current time:C178; HH MM AM PM:K7:5))
End if 


$srcTxtStart:=""
$srcTxtStart:=$srcTxtStart+"<!DOCTYPE html>"
$srcTxtStart:=$srcTxtStart+"<html>"
$srcTxtStart:=$srcTxtStart+"<head>"
$srcTxtStart:=$srcTxtStart+"<meta charset=\"UTF-8\">"
$srcTxtStart:=$srcTxtStart+"<title>Collection: "+$nameInfo+"</title>"
$srcTxtStart:=$srcTxtStart+"<style type=\"text/css\">"

If (True:C214)  // styleTheme-1
	$srcTxtStart:=$srcTxtStart+"html, body, table {width: auto !important; margin: 0; padding: 0; color: #000; font-family: Tahoma, Verdana, Helvetica, Arial, sans-serif; font-size: 12px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML {background-color: #f6f6f6;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header {position: fixed; width: 100%; box-shadow: 1px 0px 5px rgb(0, 0, 20); border: 0px; background: rgba(0, 0, 139, 0.7); color: white; padding: 0; margin: 0; font-size: 16px; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header > .headerContent {padding: 10px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header .timeLine {font-size: 10px; color: lightgrey;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .content {width: auto !important; height: calc(100vh - 60px) !important; overflow: auto !important; overflow: visible !important; padding: 0; margin: 0; padding-top: 60px;}"
	$srcTxtStart:=$srcTxtStart+".collectionHeadLine > th {background-color: rgb(51, 151, 129); color: white; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine {background-color: #dfdfdf;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine:nth-child(even){background-color: #f2f2f2}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > thead {overflow: overlay !important;}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > thead > tr > th {position: sticky !important; top: 60px !important; background-color: rgba(51, 151, 129, 0.67) !important; padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > tbody > tr > td {padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	
Else   // styleTheme-2
	$srcTxtStart:=$srcTxtStart+"html,body,table {width: auto !important; margin: 0; padding: 0; color: #000; font-family: Tahoma, Verdana, Helvetica, Arial, sans-serif; font-size: 12px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML {background-color: #f6f6f6;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header {position: fixed; width: 100%; box-shadow: 1px 0px 5px rgb(0, 0, 20); top: 0; left: 0; border: 0px; background: rgba(0, 0, 139, 0.7); color: white; padding: 0; font-size: 16px; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header > .headerContent {padding: 10px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header .timeLine {font-size: 10px; color: lightgrey;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .content {width: auto !important; overflow: overlay; padding: 10px; margin-top: 60px;}"
	$srcTxtStart:=$srcTxtStart+".collectionHeadLine > th {background-color: rgb(51, 151, 129); color: white; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine {background-color: #dfdfdf;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine:nth-child(even){background-color: #f2f2f2}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > thead > tr > th {padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > tbody > tr > td {padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	
End if 

$srcTxtStart:=$srcTxtStart+"</style>"
$srcTxtStart:=$srcTxtStart+"</head>"
$srcTxtStart:=$srcTxtStart+"<body class=\"collectionToHTML\">"
$srcTxtStart:=$srcTxtStart+"<div class=\"header\"><div class=\"headerContent\">Collection: "+$nameInfo+"<br><i class=\"timeLine\">"+$timeInfo+"</i><br></div></div>"
$srcTxtStart:=$srcTxtStart+"<div class=\"content\">"
$srcTxtStart:=$srcTxtStart+"<table class=\"collectionTable\">"

$srcTxtEnd:=""
$srcTxtEnd:=$srcTxtEnd+"</tbody>"
$srcTxtEnd:=$srcTxtEnd+"</table>"
$srcTxtEnd:=$srcTxtEnd+"</div>"
$srcTxtEnd:=$srcTxtEnd+"</body>"
$srcTxtEnd:=$srcTxtEnd+"</html>"

$txtResult:=""

C_COLLECTION:C1488($colReplace)
$colReplace:=New collection:C1472
$colReplace.push(New object:C1471("from"; "&"; "to"; "&amp;"))  // "&" must be first one in collection !!!
$colReplace.push(New object:C1471("from"; "<"; "to"; "&lt;"))
$colReplace.push(New object:C1471("from"; ">"; "to"; "&gt;"))
$colReplace.push(New object:C1471("from"; "\""; "to"; "&quot;"))
$colReplace.push(New object:C1471("from"; " "; "to"; "&nbsp;"))
$colReplace.push(New object:C1471("from"; "\t"; "to"; "&nbsp;"))
$colReplace.push(New object:C1471("from"; "\r\n"; "to"; "<br>"))
$colReplace.push(New object:C1471("from"; "\r"; "to"; "<br>"))
$colReplace.push(New object:C1471("from"; "\n"; "to"; "<br>"))

$headRowTxt:=""
$colKeys:=New collection:C1472
If ($col.length>0)
	If (Value type:C1509($col[0])=Is object:K8:27)
		$colKeys:=OB Keys:C1719($col[0])
	End if 
End if 

If ($colKeys.length>0)
	$rowPrefix:="<tr class=\"collectionHeadLine\">"
	$rowSuffix:="</tr>"
	$cellPrefix:="<th>"
	$cellSuffix:="</th>"
	$cellSeparator:=""
	$rowSeparator:=""
	$headRowTxt:=$rowPrefix+$cellPrefix+$colKeys.join($cellSuffix+$cellSeparator+$cellPrefix)+$cellSuffix+$rowSuffix+$rowSeparator
End if 

If ($headRowTxt="")
	$headRowTxt:="<tbody>"
End if 

$bodyRowsTxt:=""
$rowPrefix:="<tr class=\"collectionLine\">"
$rowSuffix:="</tr>"
$cellPrefix:="<td>"
$cellSuffix:="</td>"
$cellSeparator:=""
$rowSeparator:=""

If ($colKeys.length>0)
	$colBodyRow:=$col.map("colMapJoin"; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $colReplace; $colKeys)
Else 
	$colBodyRow:=$col.map("colMapJoin"; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $colReplace)
End if 

$bodyRowsTxt:=$colBodyRow.join($rowSeparator)
$srcTxt:=$srcTxtStart+$headRowTxt+$bodyRowsTxt+$srcTxtEnd

LV_CreateOpenTxtDoc($srcTxt; $nameInfo; ".html")
