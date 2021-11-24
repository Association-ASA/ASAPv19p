//%attributes = {"invisible":true}
  // PM: "getParseResult4DCode" (new LV 25.08.20, 13:15:11)
  // $0 - C_COLLECTION - parse result of 4Dcode
  // $1 - C_TEXT - src4Dcode
  // $2 - C_COLLECTION - filterTypes
  // Get all found keys with type-info from any src4Dcode
  // Uses js: function parseGetTokens(src4dCode, typFilterList)
  // Last change: LV 25.08.20, 13:15:11

C_COLLECTION:C1488(<>colParseResult;$0)
C_TEXT:C284($src4Dcode;$1)
C_COLLECTION:C1488($colFilterTypes;$2)

C_OBJECT:C1216($signal)
C_BOOLEAN:C305($signaled)
C_LONGINT:C283($winRef)

$src4Dcode:=$1
$winRef:=Storage:C1525.windows["_webParseForm"]

If (Count parameters:C259>1)
	$colFilterTypes:=$2
Else 
	$colFilterTypes:=New collection:C1472
End if 

<>colParseResult:=New collection:C1472

If ($winRef#0)
	$signal:=New signal:C1641
	CALL FORM:C1391($winRef;"doParseGetTokens";$src4Dcode;$signal;$colFilterTypes)
	
	$signaled:=$signal.wait(5)
End if 

$0:=<>colParseResult

  // - EOF -