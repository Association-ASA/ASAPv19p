//%attributes = {"invisible":true}
// PM: "getMatchRegex" (new LV 28.08.20, 13:15:11)
// $0 - C_COLLECTION - match regex result
// $1 - C_TEXT - regexPattern
// $2 - C_TEXT - srcTxt
// $3 - C_TEXT - flags
// Get the result collection of execute javascript: text.match(regex)
// Uses js: function getMatchRegex(myRegExPattern, mySrcTxt, flags)
// Last change: LV 28.08.20, 13:15:11

C_COLLECTION:C1488(<>colRegexMatchResult; $0)
C_TEXT:C284($regexPattern; $1)
C_TEXT:C284($srcTxt; $2)
C_TEXT:C284($flags; $3)

C_OBJECT:C1216($signal)
C_BOOLEAN:C305($signaled)
C_LONGINT:C283($winRef)

$regexPattern:=$1
$srcTxt:=$2
$winRef:=Storage:C1525.windows["_webParseForm"]

If (Count parameters:C259>2)
	$flags:=$3
Else 
	$flags:=""
End if 

<>colRegexMatchResult:=New collection:C1472

If ($winRef#0)
	$signal:=New signal:C1641
	CALL FORM:C1391($winRef; "doMatchRegex"; $regexPattern; $srcTxt; $signal; $flags)
	$signaled:=$signal.wait(5)
End if 

$0:=<>colRegexMatchResult

// - EOF -