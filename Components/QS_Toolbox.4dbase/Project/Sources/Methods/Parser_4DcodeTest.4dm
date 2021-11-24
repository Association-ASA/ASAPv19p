//%attributes = {"invisible":true}
  // PM: "testParser4Dcode"

C_COLLECTION:C1488($colParseResults)
C_LONGINT:C283($start;$stop)

TRACE:C157

If (True:C214)  // only for shutdown
	Parser_4DCodeKill   // remove old parser-process
	  // kill is only needed when in nextLine you want to restart fresh new build of parser,
	  // ..shutdown needs some less milliseconds...
End if 

If (True:C214)  // only on startup
	Parser_4DCodeStart   // start new parser-process
	  // start is only needed when you want to use parser,
	  // using without load is finished is not possible
	  // ..loading needs some less milliseconds...
End if 

  // Normally startParser and killParser used only one time on any total sessionStart and sessionEnd
  // !!! Please let the parserProcess "KEEP ALIVE" to fast everytime use it without any start/restart !!!
  // Test component-Function "getParseResult4DCode"
  // Usage: $colParseResults:=getParseResult4DCode(srcCode4D {;colFilterTypes})
$colParseResults:=getParseResult4DCode ("Alert(String(True)\rIDLE\r// - EOF -")

TRACE:C157

C_TEXT:C284($srcCode)
METHOD GET CODE:C1190(Current method path:C1201;$srcCode)

  // $2 (colFilterTypes) is optional, when no $2 exist than returned all types
$colParseResults:=getParseResult4DCode ($srcCode)  // ALL types
  // ...but parser is still beta (e.g. ignore such types "variable", this comes later)
  // getParseResult4DCode is very fast, but do not waste the time,
  // it is always better (recommended) to make only one call with all types you needed
  // and do not split this when not necessary into separate calls, one for command, one for varLocal....
  // Do this in one Call with full list of all types you need!

  // Next line only examples to demo how to use colFilterTypes ($2)
$colParseResults:=getParseResult4DCode ($srcCode;New collection:C1472("command";"method-project";"variable-local";"variable-ip"))

  // Next line only examples to demo how to use colFilterTypes ($2)
$colParseResults:=getParseResult4DCode ($srcCode;New collection:C1472("comment";"string"))

  // ==================

TRACE:C157

$colParseResults:=getParseResult4DCode ("Alert(String(True))\rIDLE\r\r// - EOF -")

$colParseResults:=getParseResult4DCode ("Alert(String(True)\rIDLE\r\r// - EOF -";New collection:C1472("command"))

$colParseResults:=getParseResult4DCode ("Alert(String(True)\rIDLE\r\r// - EOF -";New collection:C1472("comment"))

$colParseResults:=getParseResult4DCode ("Alert(String(True)\rIDLE\r\r// - EOF -";New collection:C1472("command";"comment"))

TRACE:C157

C_COLLECTION:C1488($colFilterTypes)
C_TEXT:C284($srcCode)
METHOD GET CODE:C1190(Current method path:C1201;$srcCode)

$colFilterTypes:=New collection:C1472("command";"string")
$colParseResults:=getParseResult4DCode ($srcCode;$colFilterTypes)

$colFilterTypes:=New collection:C1472("string")
$colParseResults:=getParseResult4DCode ($srcCode;$colFilterTypes)

$colParseResults:=getParseResult4DCode ($srcCode;New collection:C1472("command";"method-project";"variable-local";"variable-ip"))

$start:=Milliseconds:C459
$colParseResults:=getParseResult4DCode ($srcCode)
$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCodeALL\r\r"+String:C10($stop-$start)+"ms")

$start:=Milliseconds:C459
$colParseResults:=getParseResult4DCode ($srcCode)
$colParseResults:=$colParseResults.distinct("src")
$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCodeALLDistinct\r\r"+String:C10($stop-$start)+"ms")

$start:=Milliseconds:C459
$colParseResults:=getParseResult4DCode ($srcCode)
$colParseResults:=$colParseResults.distinct("src";ck diacritical:K85:3)
$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCodeALLDistinctDiacritical\r\r"+String:C10($stop-$start)+"ms")

$start:=Milliseconds:C459
$colParseResults:=getParseResult4DCode ($srcCode;New collection:C1472("command";"method-project";"variable-local";"variable-ip";"string";"comment"))
$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCode\r\r"+String:C10($stop-$start)+"ms")

$start:=Milliseconds:C459
$colParseResults:=getParseResult4DCode ($srcCode;New collection:C1472("command";"method-project";"variable-local";"variable-ip";"string";"comment"))
$colParseResults:=$colParseResults.distinct("src")
$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCodeDistinct\r\r"+String:C10($stop-$start)+"ms")

$start:=Milliseconds:C459
$colParseResults:=getParseResult4DCode ($srcCode;New collection:C1472("command";"method-project";"variable-local";"variable-ip";"string";"comment"))
$colParseResults:=$colParseResults.distinct("src";ck diacritical:K85:3)
$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCode+distinctDiacritical\r\r"+String:C10($stop-$start)+"ms")

TRACE:C157

  // ============================================
  // --- Recommended/Fastest course of action ---
  // ============================================

C_COLLECTION:C1488($colUsedProjMethods;$colUsedCommands;$colUsedConstants;$colUsedVarLocal;$colUsedVarIP)
C_COLLECTION:C1488($colUsedBlockBegins;$colUsedBlockMiddles;$colUsedBlockEnds)
C_COLLECTION:C1488($colUsedStrings;$colUsedNumbers;$colUsedOperators)

$start:=Milliseconds:C459

$colParseResults:=getParseResult4DCode ($srcCode)  // get all tokens (do not use $2 filterTypes)
  // Just if split-into-separated-types and distinct-src is needed
  // fetch with 4DsCollFuncs type by type (query) as unique-src (distinct):
  // col.query("typ='anyTypeToFilter'").distinct("src")

$colUsedProjMethods:=$colParseResults.query("typ='method-project'").distinct("src";ck diacritical:K85:3)

$colUsedCommands:=$colParseResults.query("typ='command'").distinct("src";ck diacritical:K85:3)  // 4D-Commands
$colUsedConstants:=$colParseResults.query("typ='attribute'").distinct("src";ck diacritical:K85:3)  // attribute = 4D-Constants e.g. "ck diacritical"

$colUsedVarLocal:=$colParseResults.query("typ='variable-local'").distinct("src";ck diacritical:K85:3)
$colUsedVarIP:=$colParseResults.query("typ='variable-ip'").distinct("src";ck diacritical:K85:3)

$colUsedBlockBegins:=$colParseResults.query("typ='keyword blockBegin'").distinct("src";ck diacritical:K85:3)  // ['if','case of','for each','for','while','repeat','use','begin sql']
$colUsedBlockMiddles:=$colParseResults.query("typ='keyword blockMiddle'").distinct("src";ck diacritical:K85:3)  // ['else']
$colUsedBlockEnds:=$colParseResults.query("typ='keyword blockEnd'").distinct("src";ck diacritical:K85:3)  // ['end if','end case','end for each','end for','end while','until','end use','end sql']

$colUsedStrings:=$colParseResults.query("typ='string'").distinct("src";ck diacritical:K85:3)  // string/date/time = "stringInDoubleQuotes", !2010-09-13!, ?01:00:00?

$colUsedNumbers:=$colParseResults.query("typ='number'").distinct("src";ck diacritical:K85:3)  // any number e.g. 1.23
$colUsedOperators:=$colParseResults.query("typ='operator'").distinct("src";ck diacritical:K85:3)  // [-,:,:=,??,?+,*,&,#,%,+,<,<<,<=,=,>,>=,>>,|]

$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCode+buildTypeLists\r\r"+String:C10($stop-$start)+"ms")
TRACE:C157

  // ============================================
  // --- Summary ---
  // ============================================

$start:=Milliseconds:C459

Parser_getParseResult4DCodeSum   // gets all method datas and metas from all kind of methods

$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCode Summary\r\r"+String:C10($stop-$start)+"ms")
TRACE:C157

If (True:C214)  // only for shutdown, but just use kill if parser no longer needed
	Parser_4DCodeKill   // remove old parser-process
End if 

  // - EOF -