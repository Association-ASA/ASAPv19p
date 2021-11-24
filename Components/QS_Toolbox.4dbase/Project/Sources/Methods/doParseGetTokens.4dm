//%attributes = {"invisible":true}
  // PM: "doParseGetTokens" (new LV 25.08.20, 15:54:44)
  // Last change: LV 25.08.20, 15:54:44

C_TEXT:C284($src4Dcode;$1)
C_OBJECT:C1216($signal;$2)
C_COLLECTION:C1488($colFilterTypes;$3)

$src4Dcode:=$1
$signal:=$2

If (Count parameters:C259>2)
	$colFilterTypes:=$3
Else 
	$colFilterTypes:=New collection:C1472
End if 

WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"parseGetTokens";<>colParseResult;$src4Dcode;$colFilterTypes)

$signal.trigger()  // work is finished

  // - EOF -