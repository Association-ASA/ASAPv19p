//%attributes = {"invisible":true}
  // PM: "getReplaceRegex" (new LV 28.08.20, 13:15:11)
  // $0 - C_TEXT - resultText with replaced text parts which matches the pattern
  // $1 - C_TEXT - regexPattern
  // $2 - C_TEXT - srcTxt
  // $3 - C_TEXT - $replaceTxt
  // $4 - C_TEXT - flags - Optional | Use all flags which are in js-regex allowed /pattern/flags[gim]
  // Get the result text of execute javascript: text.replace(regex, replaceText)
  // Uses js: function getReplaceRegex(regexPattern, srcTxt, replaceTxt, flags)
  // Last change: LV 28.08.20, 13:15:11

C_TEXT:C284(<>txtRegexReplaceResult;$0)
C_TEXT:C284($regexPattern;$1)
C_TEXT:C284($srcTxt;$2)
C_TEXT:C284($replaceTxt;$3)
C_TEXT:C284($flags;$4)

C_OBJECT:C1216($signal)
C_BOOLEAN:C305($signaled)
C_LONGINT:C283($winRef)

$regexPattern:=$1
$srcTxt:=$2
$replaceTxt:=$3
$winRef:=Storage:C1525.windows["_webParseForm"]

If (Count parameters:C259>3)
	$flags:=$4
Else 
	$flags:=""
End if 

<>txtRegexReplaceResult:=""

If ($winRef#0)
	$signal:=New signal:C1641
	CALL FORM:C1391($winRef;"doReplaceRegex";$regexPattern;$srcTxt;$replaceTxt;$signal;$flags)
	$signaled:=$signal.wait(5)
End if 

$0:=<>txtRegexReplaceResult

  // - EOF -