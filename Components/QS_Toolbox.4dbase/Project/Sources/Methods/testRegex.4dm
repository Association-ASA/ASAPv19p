//%attributes = {"invisible":true}
  // PM: "testRegex"
  // test-examples to call componentMethods "getMatchRegex" and "getReplaceRegex"
  // This componentMethods uses javascript to execute a regex!
  // Never forget, that jsRegex vs. 4dMatchRegex(icu)
  // have some different syntaxRules and different behaviour/results
  // so you need sometimes different regexPatterns/Syntax for use in
  // different regex implementations to get same wished result

C_COLLECTION:C1488($colRegexMatchResults)
C_TEXT:C284($txtRegexReplaceResult)
C_LONGINT:C283($start;$stop)

TRACE:C157

If (True:C214)  // only for shutdown
	Parser_4DCodeKill   // remove old parser-process
	  // kill is only needed when in nextLine you want to restart fresh new build of parser,
	  // ..shutdown needs some less milliseconds...
End if 

If (True:C214)  // only on startup
	Parser_4DCodeStart   // start new parser-process
	  // using without starting is not possible
	  // ..loading needs some less milliseconds...
End if 

TRACE:C157

  // Test javascript text.match(regex+flags) and text.replace(regex+flags)
  // ExamplesCodes in pure JS:
  //   '$abcD abcX ($abc) <>ipABC xyz'.match(/\$\w+\b/gi)
  //   '$abcD abcX ($abc) <>ipABC xyz'.replace(/\$\w+\b/gi, 'localVar')
  // Used JS-functions from ".../mp/min4dRunParse.html":
  //   function getMatchRegex(myRegExPattern, mySrcTxt, flags)
  //   function getReplaceRegex(regexPattern, srcTxt, replaceTxt, flags)

C_TEXT:C284($regexPattern;$srcTxt;$flags;$duration)
METHOD GET CODE:C1190(Current method path:C1201;$srcTxt)

  // ---- USE JS-Regex ----

  // test match all "$varName" => resultCollection
$regexPattern:="\\$\\w+\\b"
$flags:="gi"
$start:=Milliseconds:C459
$colRegexMatchResults:=getMatchRegex ($regexPattern;$srcTxt;$flags)
$stop:=Milliseconds:C459
$duration:=String:C10($stop-$start)+"ms"
TRACE:C157


  // test replace all "$varName" with "localVar" => resultText
$regexPattern:="\\$\\w+\\b"
$flags:="gi"
$start:=Milliseconds:C459
$txtRegexReplaceResult:=getReplaceRegex ($regexPattern;$srcTxt;"localVar";$flags)
$stop:=Milliseconds:C459
$duration:=String:C10($stop-$start)+"ms"
TRACE:C157


  // ---- USE 4D/ICU-Regex ----

  // test match all "$varName" => resultCollection
$regexPattern:="\\$\\w+\\b"
$flags:="i"  // _4dRegexMatchG is same like g-flag is setted
$regexPattern:="(?"+$flags+")"+$regexPattern
$start:=Milliseconds:C459
$colRegexMatchResults:=LV_RegexMatchG ($srcTxt;$regexPattern)  // method result is same as like g-flag (g-flag not available in 4d/ICU)
$stop:=Milliseconds:C459
$duration:=String:C10($stop-$start)+"ms"
TRACE:C157


  // test replace all "$varName" with "localVar" => resultText
$regexPattern:="\\$\\w+\\b"
$flags:="i"  // _4dRegexReplaceG is same like g-flag is setted
$regexPattern:="(?"+$flags+")"+$regexPattern
$start:=Milliseconds:C459
$txtRegexReplaceResult:=LV_RegexReplaceG ($srcTxt;$regexPattern;"localVar")  // method result is same as like g-flag (g-flag not available in 4d/ICU)
$stop:=Milliseconds:C459
$duration:=String:C10($stop-$start)+"ms"
TRACE:C157


  // - EOF -