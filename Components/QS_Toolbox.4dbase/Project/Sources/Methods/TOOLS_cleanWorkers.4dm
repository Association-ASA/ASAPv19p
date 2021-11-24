//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $listToKill; $iToKill : Collection

$iToKill:=New collection:C1472
$listToKill:=New collection:C1472
$listToKill.push(New object:C1471("prcs"; "QST_commandsUsed"))
$listToKill.push(New object:C1471("prcs"; "QST_nested"))
$listToKill.push(New object:C1471("prcs"; "QST_getObjectType"))
$listToKill.push(New object:C1471("prcs"; "QST_get4DKonstant"))
$listToKill.push(New object:C1471("prcs"; "QST_get4DKeyword"))
$listToKill.push(New object:C1471("prcs"; "QST_getsystemKeyword"))
$listToKill.push(New object:C1471("prcs"; "QST_getPluginMethods"))
$listToKill.push(New object:C1471("prcs"; "QST_getComposantMethod"))
$listToKill.push(New object:C1471("prcs"; "QST_graphviz"))
$listToKill.push(New object:C1471("prcs"; "QST_getTablesList"))
$listToKill.push(New object:C1471("prcs"; "QST_setCollTo"))
$listToKill.push(New object:C1471("prcs"; "QST_rebuildLH"))
$listToKill.push(New object:C1471("prcs"; "QST_symbolFileAnalyze"))
$listToKill.push(New object:C1471("prcs"; "QST_symbolAnalyze"))
$listToKill.push(New object:C1471("prcs"; "QST_commands"))
$listToKill.push(New object:C1471("prcs"; "QST_assignRestrictions"))
$listToKill.push(New object:C1471("prcs"; "QST_methods"))
$listToKill.push(New object:C1471("prcs"; "QST_VCS"))
$listToKill.push(New object:C1471("prcs"; "QST_start"))
$listToKill.push(New object:C1471("prcs"; "QST_TOOLS_readSymbolFile"))
$listToKill.push(New object:C1471("prcs"; "QST_create4Djs"))
$listToKill.push(New object:C1471("prcs"; "QST_job"))
$listToKill.push(New object:C1471("prcs"; "QST_setCollToDiamond"))

For ($a; 1; Storage:C1525.QS_TBX_SHARED_DATA.maxWorkers)
	$listToKill.push(New object:C1471("prcs"; "QST_mAnalysis_1_"+String:C10($a)))
	$listToKill.push(New object:C1471("prcs"; "QST_mAnalysis_2_"+String:C10($a)))
	$listToKill.push(New object:C1471("prcs"; "QST_mAnalysis_3_"+String:C10($a)))
	$listToKill.push(New object:C1471("prcs"; "QST_mAnalysis_4_"+String:C10($a)))
	$listToKill.push(New object:C1471("prcs"; "QST_mAnalysis_5_"+String:C10($a)))
	$listToKill.push(New object:C1471("prcs"; "QST_"+String:C10($a)+"_cross"))
	$listToKill.push(New object:C1471("prcs"; "QST_CalleesCallers_"+String:C10($a)))
End for 

For ($vlProcess; 1; Count tasks:C335)
	If (Process state:C330($vlProcess)>=Executing:K13:4)
		PROCESS PROPERTIES:C336($vlProcess; $procName; $procState; $procTime; $procMode; $procUniqueID; $procOrigin)
		If ($procOrigin=5)  // Worker 
			
			$iToKill.clear()
			$iToKill:=$listToKill.indices("prcs = :1"; $procName)
			
			If ($iToKill.length>0)
				KILL WORKER:C1390($procName)
			End if 
			
		End if 
		
	End if 
End for 

KILL WORKER:C1390  // itself