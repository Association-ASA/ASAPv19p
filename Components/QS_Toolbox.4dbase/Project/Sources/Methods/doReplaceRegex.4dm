//%attributes = {"invisible":true}
  // PM: "doMatchRegex" (new LV 28.08.20, 15:54:44)
  // Uses js: function getReplaceRegex(regexPattern, srcTxt, replaceTxt, flags)
  // Last change: LV 28.08.20, 15:54:44

C_TEXT:C284($regexPattern;$1)
C_TEXT:C284($srcTxt;$2)
C_TEXT:C284($replaceTxt;$3)
C_OBJECT:C1216($signal;$4)
C_TEXT:C284($flags;$5)

$regexPattern:=$1
$srcTxt:=$2
$replaceTxt:=$3
$signal:=$4

If (Count parameters:C259>4)
	$flags:=$5
Else 
	$flags:=""
End if 

WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"getReplaceRegex";<>txtRegexReplaceResult;$regexPattern;$srcTxt;$replaceTxt;$flags)

$signal.trigger()  // work is finished

  // - EOF -