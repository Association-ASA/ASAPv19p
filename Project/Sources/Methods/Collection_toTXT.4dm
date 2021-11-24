//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"lang":"fr"}
// PM: "collectionToTxt"

C_COLLECTION:C1488($col; $1)
C_TEXT:C284($nameInfo; $2)
C_TEXT:C284($timeInfo; $3)

C_TEXT:C284($srcTxt)
C_TEXT:C284($srcTxtStart; $srcTxtEnd)
C_COLLECTION:C1488($colBodyRow; $colKeys)
C_TEXT:C284($headRowTxt; $bodyRowsTxt; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $rowSeparator)

If (Count parameters:C259>0)
	$col:=$1.copy()
End if 

If (Count parameters:C259>1)
	$nameInfo:=$2
End if 

If (Count parameters:C259>2)  // $3 or automatic standard timeInfo
	$timeInfo:=$3
Else 
	$timeInfo:=String:C10(Current date:C33; Système date long:K1:3)+" "+Lowercase:C14(String:C10(Current time:C178; h mn Matin Après Midi:K7:5))
End if 

ON ERR CALL:C155("BASE_noERROR")
C_TEXT:C284($lineBreak)
If (Is macOS:C1572)
	$lineBreak:=Char:C90(Retour à la ligne:K15:40)
Else 
	$lineBreak:=Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40)
End if 

$srcTxtStart:=""
If (False:C215)  // ...set it to true if a title is wished...
	$srcTxtStart:=$srcTxtStart+$nameInfo+$lineBreak
	$srcTxtStart:=$srcTxtStart+$timeInfo+$lineBreak
	$srcTxtStart:=$srcTxtStart+$lineBreak
End if 

$srcTxtEnd:=""
$txtResult:=""

C_COLLECTION:C1488($colReplace)
$colReplace:=New collection:C1472
$colReplace.push(New object:C1471("from"; "\""; "to"; "'"))
$colReplace.push(New object:C1471("from"; "\t"; "to"; " "))
$colReplace.push(New object:C1471("from"; "\r\n"; "to"; " "))
$colReplace.push(New object:C1471("from"; "\r"; "to"; " "))
$colReplace.push(New object:C1471("from"; "\n"; "to"; " "))

$headRowTxt:=""
$colKeys:=New collection:C1472
If ($col.length>0)
	If (Value type:C1509($col[0])=Est un objet:K8:27)
		$colKeys:=OB Keys:C1719($col[0])
	End if 
End if 

If ($colKeys.length>0)
	$rowPrefix:=""
	$rowSuffix:=""
	$cellPrefix:="\""
	$cellSuffix:="\""
	$cellSeparator:=Char:C90(Tabulation:K15:37)
	$rowSeparator:=$lineBreak
	$headRowTxt:=$rowPrefix+$cellPrefix+$colKeys.join($cellSuffix+$cellSeparator+$cellPrefix)+$cellSuffix+$rowSuffix+$rowSeparator
End if 

$rowPrefix:=""
$rowSuffix:=""
$cellPrefix:="\""
$cellSuffix:="\""
$cellSeparator:=Char:C90(Tabulation:K15:37)
$rowSeparator:=$lineBreak
If ($colKeys.length>0)
	$colBodyRow:=$col.map("colMapJoin"; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $colReplace; $colKeys)
Else 
	$colBodyRow:=$col.map("colMapJoin"; $rowPrefix; $rowSuffix; $cellPrefix; $cellSuffix; $cellSeparator; $colReplace)
End if 
$bodyRowsTxt:=$colBodyRow.join($rowSeparator)

$srcTxt:=$srcTxtStart+$headRowTxt+$bodyRowsTxt+$srcTxtEnd

LV_CreateOpenTxtDoc($srcTxt; $nameInfo; ".txt")
