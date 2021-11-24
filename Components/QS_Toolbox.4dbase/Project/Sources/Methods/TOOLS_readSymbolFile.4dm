//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 12/07/19, 08:17:04
// Paramètres
// ----------------------------------------------------
// Méthode : TOOLS_readSymbolFile
// Description
// https://doc.4d.com/4Dv17R6/4D/17-R6/Compilation-diagnostic-aids.300-4354680.en.html

//The first column contains the names of process and interprocess variables and ar.These variables are listed in alphabetical order.
//The second column contains the type of the variable.Types are set by compiler directive commands or are determined by the compiler b.If the type of a variable cannot be determined, the column is empty.
//The third column lists the number of dimensions if the variable is an array.
//The fourth column contains a reference to the context in which the compiler esta.If the variable is used in several contexts, the context mentioned is the one us.
//- If the variable was found in a database method, the database method name is give(M)*.
//- If the variable was found in a project method, the method is identified as it ha(M).
//- If the variable was found in a trigger(table method). the table name is given. preceded by(TM).
//- If the variable was found in a form method, the form name is given, preceded by (FM).
//- If the variable was found in an object method, the object method’s name is giv(OM).
//- If the variable is an object in a form and does not appear in any project, form (F).

C_COLLECTION:C1488($data)
C_OBJECT:C1216($source; $declaration; $2)
C_BOOLEAN:C305($is_4DPop; $1; $3)
C_TEXT:C284($symbols; $lastPart)

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> Start")

$is_4DPop:=$1
$declaration:=$2

Use ($declaration)
	$declaration.first:=New shared collection:C1527
	$declaration.last:=New shared collection:C1527
	$declaration.runInProgress:=True:C214
	$declaration.declaration:=New shared collection:C1527
	$declaration.count:=0
	$declaration.countMax:=0
End use 

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> file read")

If (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ServerMode)
	$symbols:=symbols_s_getData
	
Else 
	$symbols:=symbols_getData
End if 

$symbols:=Replace string:C233($symbols; "\n"; "")
$data:=Split string:C1554($symbols; "\r\r\r")
$data.shift().shift()  // Remove the 2 first line -> Date & Empty line
$lastPart:=$data.pop()  // The collection.pop( ) method removes the last element from the collection and returns it as the function result.

Use ($declaration)
	OB_CopyToSharedCollection($data; $declaration.first)
	$declaration.last:=$lastPart
End use 

CALL WORKER:C1389("QST_symbolFileAnalyze"; "TOOLS_SymbolFileAnalyse"; $is_4DPop; $declaration)
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> End")

If ($3=True:C214)
	$signal:=New signal:C1641
	signal_setNew($signal; 1)
	CALL WORKER:C1389("QST_methods"; "MM_analyzer"; $declaration; $signal)
	$signal.wait()
End if 

If (Count parameters:C259=4)
	C_OBJECT:C1216($4)
	signal_addResult($4; Current method name:C684)
End if 