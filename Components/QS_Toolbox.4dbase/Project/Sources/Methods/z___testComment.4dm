//%attributes = {"invisible":true,"folder":"test","lang":"en"}
// Method to test comments

IDLE:C311

/* ======== Root (START)
/* ----- Block-A (START) -----
testCommentA "//"
..-----Block-A(..END)-----*/
/* ----- Block-B (START) -----
testCommentB "//"
..-----Block-B(..END)-----*/
..========Root(..END)*/

IDLE:C311

/*
a commentBlock line-2
line-3
*/

// ######

$txt:="...//..."
$txt:=".../*...*/..."
$txt:="https://www.apple.com"

IDLE:C311  // #xy#

If ((True:C214)/* inline commentBlock */ & (False:C215))
	//endLineComment
	IDLE:C311/* inline comment block */
End if 

// - EOF -
//$db:=Folder(Folder(fk database folder).platformPath;fk platform path).path+"Project/Sources/Methods/"
//$file:=File($db+"__Converter"+".4dm")
//$code:=Document to text(Convert path POSIX to system($file.path))



C_LONGINT:C283($starter; $stop)
//TRACE
If (True:C214)  // only for shutdown
	Parser_4DCodeKill  // remove old parser-process
	// kill is only needed when in nextLine you want to restart fresh new build of parser,
	// ..shutdown needs some less milliseconds...
End if 
If (True:C214)  // only on startup
	CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; "method"; 0)
	Parser_4DCodeStart  // start new parser-process
	// start is only needed when you want to use parser,
	// using without load is finished is not possible
	// ..loading needs some less milliseconds...
End if 
// Normally startParser and killParser used only one time on any total sessionStart and sessionEnd
// !!! Please let the parserProcess "KEEP ALIVE" to fast everytime use it without any start/restart !!!
// Test component-Function "getParseResult4DCodeSum"
$starter:=Milliseconds:C459
Parser_getParseResult4DCodeSum  // gets all method datas and metas from all kind of methods
$stop:=Milliseconds:C459
ALERT:C41("getParseResult4DCode Summary\r\r"+String:C10(($stop-$starter)/(1000))+"s")
TRACE:C157
If (True:C214)  // only for shutdown, but just use kill if parser no longer needed
	Parser_4DCodeKill  // remove old parser-process
End if 
