//%attributes = {"invisible":true,"preemptive":"capable"}
  // PM: "getParseResult4DCodeSum" (new LV 14.09.2020, 09:30:00)
  // $0 - C_COLLECTION - parse result of 4Dcode
  // Get for all kind of methods (Summary) the method datas
  // path, code, mod (methodPathName, methodSourceCode, modificationDateTime)
  // PLUS all tokenTypes which used from the method, 9 collections for 9 types:
  // - usedPm  (ProjectMethod only directCalls, not StrInDoubleQuotes)
  // - usedCmd (4D-Commands)
  // - usedCst (4D-Constants)
  // - usedVlc ($localVariables)
  // - usedVip (<>ipVariables)
  // - usedBb  (BlockBegin Cmds)
  // - usedBm  (BlockMiddle Cmds)
  // - usedBe  (BlockEnd Cmds)
  // - usedStr ("StringsInDoubleQuotes")
  // PLUS all callers of/for each projectMethod (Null/Collection)
  // Uses js: function parseGetTokens(src4dCode, typFilterList)
  // Last change: LV 14.09.2020, 09:30:00

C_OBJECT:C1216($signal;$1)
C_BOOLEAN:C305($signaled)
C_LONGINT:C283($winRef)

$signal:=$1
$winRef:=Storage:C1525.windows["_webParseForm"]

If ($winRef#0)
	CALL FORM:C1391($winRef;"Parser_doParseGetTokensSum";$signal)
End if 

  // - EOF - 