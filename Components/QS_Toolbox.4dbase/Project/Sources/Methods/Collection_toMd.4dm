//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // PM: "collectionToMd"

C_COLLECTION:C1488($col;$1)
C_TEXT:C284($nameInfo;$2)
C_TEXT:C284($timeInfo;$3)

C_TEXT:C284($srcTxt)
C_TEXT:C284($srcTxtStart;$srcTxtEnd)
C_COLLECTION:C1488($colBodyRow;$colKeys)
C_TEXT:C284($headRowTxt;$bodyRowsTxt;$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$rowSeparator)

If (Count parameters:C259>0)
	$col:=$1.copy()
End if 

If (Count parameters:C259>1)
	$nameInfo:=$2
End if 

If (Count parameters:C259>2)  // $3 or automatic standard timeInfo
	$timeInfo:=$3
Else 
	$timeInfo:=String:C10(Current date:C33;System date long:K1:3)+" "+Lowercase:C14(String:C10(Current time:C178;HH MM AM PM:K7:5))
End if 
ON ERR CALL:C155("BASE_noERROR")

$srcTxtStart:=""
$srcTxtStart:=$srcTxtStart+Char:C90(Line feed:K15:40)
$srcTxtStart:=$srcTxtStart+"# "+$nameInfo+Char:C90(Line feed:K15:40)
$srcTxtStart:=$srcTxtStart+"*"+$timeInfo+"*"+Char:C90(Line feed:K15:40)
$srcTxtStart:=$srcTxtStart+Char:C90(Line feed:K15:40)

$srcTxtEnd:=""

$txtResult:=""

C_COLLECTION:C1488($colReplace)
$colReplace:=New collection:C1472
$colReplace.push(New object:C1471("from";"&";"to";"&amp;"))  // "&" must be first one in collection !!!
$colReplace.push(New object:C1471("from";"<";"to";"&lt;"))
$colReplace.push(New object:C1471("from";">";"to";"&gt;"))
$colReplace.push(New object:C1471("from";"\"";"to";"&quot;"))
$colReplace.push(New object:C1471("from";" ";"to";"&nbsp;"))
$colReplace.push(New object:C1471("from";"\t";"to";"&nbsp;"))
$colReplace.push(New object:C1471("from";"#";"to";"&num;"))
$colReplace.push(New object:C1471("from";"*";"to";"&#42;"))
$colReplace.push(New object:C1471("from";"|";"to";"&#124;"))
$colReplace.push(New object:C1471("from";"`";"to";"&grave;"))
$colReplace.push(New object:C1471("from";"-";"to";"&#45;"))
$colReplace.push(New object:C1471("from";"!";"to";"&#33;"))
$colReplace.push(New object:C1471("from";"[";"to";"&#91;"))
$colReplace.push(New object:C1471("from";"]";"to";"&#93;"))
$colReplace.push(New object:C1471("from";"\r\n";"to";"<br>"))
$colReplace.push(New object:C1471("from";"\r";"to";"<br>"))
$colReplace.push(New object:C1471("from";"\n";"to";"<br>"))

$headRowTxt:=""
$colKeys:=New collection:C1472
If ($col.length>0)
	If (Value type:C1509($col[0])=Is object:K8:27)
		$colKeys:=OB_keys ($col[0])
	End if 
End if 
If ($colKeys.length>0)
	$rowPrefix:=""
	$rowSuffix:="|"
	$cellPrefix:="| "
	$cellSuffix:=" "
	$cellSeparator:=""
	$rowSeparator:=Char:C90(Line feed:K15:40)
	$headRowTxt:=$rowPrefix+$cellPrefix+$colKeys.join($cellSuffix+$cellSeparator+$cellPrefix)+$cellSuffix+$rowSuffix+$rowSeparator+("| :---: "*$colKeys.length)+"|"+$rowSeparator
End if 

$rowPrefix:=""
$rowSuffix:="|"
$cellPrefix:="| "
$cellSuffix:=" "
$cellSeparator:=""
$rowSeparator:=Char:C90(Line feed:K15:40)
If ($colKeys.length>0)
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace;$colKeys)
Else 
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace)
End if 
$bodyRowsTxt:=$colBodyRow.join($rowSeparator)

$srcTxt:=$srcTxtStart+$headRowTxt+$bodyRowsTxt+$srcTxtEnd

LV_CreateOpenTxtDoc ($srcTxt;$nameInfo;".md")
