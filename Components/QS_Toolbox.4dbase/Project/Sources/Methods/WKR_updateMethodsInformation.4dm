//%attributes = {"invisible":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 28/02/19, 22:23:47
// Paramètres
// ----------------------------------------------------
// Méthode : WKR_updateMethodsInformation
// Description
//

#DECLARE($is_4DPop : Boolean)

var $SharedData : Object
var $version : Text
var $QS_VCS_COMP_DB_PATH : Text
var $mainMenu : Integer
var $declaration : Object
var $LV_mode : Boolean
$LV_mode:=False:C215

If ($LV_mode)
	Parser_4DCodeKill
End if 

floatWindow_launch
LH_clearList($SharedData.QS_LH_commands)

$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
Use ($SharedData)
	$SharedData.QS_LH_commands:=0
	$SharedData.analysisStart:=Current time:C178
	$SharedData.calleesCallersDone:=False:C215
End use 

PROCESS_sleep

CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; "method"; 0)
$declaration:=New shared object:C1526
$version:=TOOL_return4Dversion("QST")
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "Refresh Symbols.txt file -> start")
XML_compiler_create

If ($LV_mode)
	CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "LV_parseCode -> Start")
	Parser_4DCodeStart
	$signal_LV:=New signal:C1641
	CALL WORKER:C1389("QST_job"; "Parser_getParseResult4DCodeSum"; $signal_LV)
End if 

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "Refresh Symbols.txt file -> end")
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; $version)
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> Start")

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$mainMenu:=Storage:C1525.windows.mainMenu

Use (Storage:C1525)
	Storage:C1525.componantsMethods.clear()
End use 

// -------------- Process variables declaration &  DB_symbol.txt set to Storage  &  4D commands to storage --------------------

$signal:=New signal:C1641
signal_setNew($signal; 1)
CALL WORKER:C1389("QST_get4DCommand"; "TOOLS_Get4DCommand"; "FR"; $signal)
$signal.wait()

$signal:=New signal:C1641
signal_setNew($signal; 2)
CALL WORKER:C1389("QST_symbolReadFile"; "TOOLS_readSymbolFile"; $is_4DPop; $declaration; True:C214; $signal)
CALL WORKER:C1389("QST_rebuildLH"; "COMMANDS_LH_create"; False:C215; $signal)  // not PREEMPTIVE with LIST commands
$signal.wait()

$signal:=New signal:C1641
signal_setNew($signal; 1)
CALL WORKER:C1389("QST_assignRestrictions"; "COMMANDS_restrictions"; $is_4DPop; $signal)  // Update storage.allMethods
$signal.wait()

If ($LV_mode)
	$signal_LV.wait()
	CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "LV_parseCode -> End")
	Parser_4DCodeKill
End if 

If (Count parameters:C259=2)
	var $2 : Object
	signal_addResult($2; Current method name:C684)
End if 
