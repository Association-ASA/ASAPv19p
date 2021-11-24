//%attributes = {"invisible":true}
  // PM: "createListCalleeAndCaller"
  // open todos, removeComment+CoverDoubleQuoteStrings
  // open todos, all method paths (not only projectMethods)
  // open todos, all kinds of usage in expression-form-properties or menu-startMethod
C_OBJECT:C1216($objResult;$0)
C_COLLECTION:C1488($colProjMethods;$colCallees)
C_TEXT:C284($methName;$code;$methListPattern;$calleesName)
C_OBJECT:C1216($objCallees;$objResult)
$objResult:=New object:C1471
$colProjMethods:=zGetProjMethods 
$methListPattern:="(?<!(\\$)|(<>))\\b(("+$methListPattern+$colProjMethods.join(")|(")+"))\\b"
For each ($methName;$colProjMethods)
	METHOD GET CODE:C1190($methName;$code;*)
	  // open todos, remove in $code all types of comments and cover doubleQuoteStringContents
	$colCallees:=LV_RegexMatchG ($code;$methListPattern)
	$objCallees:=New object:C1471
	For each ($calleesName;$colCallees)
		$objCallees[$calleesName]:=True:C214
	End for each 
	$objResult[$methName]:=New object:C1471("callees";$objCallees;"callers";New object:C1471)
End for each 

For each ($methName;$objResult)
	For each ($calleesName;$objResult[$methName].callees)
		$objResult[$calleesName].callers[$methName]:=True:C214
	End for each 
End for each 
$0:=$objResult
  // - EOF -