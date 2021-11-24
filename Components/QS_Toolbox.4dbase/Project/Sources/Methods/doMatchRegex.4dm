//%attributes = {"invisible":true}
  // PM: "doMatchRegex" (new LV 28.08.20, 15:54:44)
  // Uses js: function getMatchRegex(myRegExPattern, mySrcTxt, flags)
  // Last change: LV 28.08.20, 15:54:44

C_TEXT:C284($regexPattern;$1)
C_TEXT:C284($srcTxt;$2)
C_OBJECT:C1216($signal;$3)
C_TEXT:C284($flags;$4)

$regexPattern:=$1
$srcTxt:=$2
$signal:=$3

If (Count parameters:C259>3)
	$flags:=$4
Else 
	$flags:=""
End if 

WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"getMatchRegex";<>colRegexMatchResult;$regexPattern;$srcTxt;$flags)

$signal.trigger()  // work is finished

  // - EOF -