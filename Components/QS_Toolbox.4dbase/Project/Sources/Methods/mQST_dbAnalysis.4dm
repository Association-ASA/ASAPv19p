//%attributes = {"invisible":true,"shared":true,"executedOnServer":false,"preemptive":"indifferent","publishedSql":false,"publishedWsdl":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone)
	
	var $QS_data; $signal : Object
	ON ERR CALL:C155("BASE_noERROR")
	
	$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA
	$mainMenu:=Storage:C1525.windows.mainMenu
	
	Use ($QS_data)
		LH_clearList(Storage:C1525.QS_TBX_SHARED_DATA.QS_LH_commands)
		$QS_data.QS_TBX_crossReference:=False:C215
		$QS_data.QS_LH_commands:=0
		$QS_data.calleesCallersDone:=False:C215
	End use 
	
	Use (Storage:C1525.allMethods)
		Storage:C1525.allMethods.clear()
	End use 
	
	STO_textToStorage("update"; "New analysis requested by "+Current user:C182)
	
	QST_killProcesses
	$signal:=New signal:C1641
	signal_setNew($signal; 1)
	CALL WORKER:C1389("QST_getMethodsInformation"; "WKR_updateMethodsInformation"; False:C215; $signal)
	$signal.wait()
	
	CALL FORM:C1391($mainMenu; "CF_action"; True:C214)
	STO_textToStorage("update"; Storage:C1525.text.message)
	savingData
	
Else 
	var $ptr : Pointer
	EXECUTE METHOD:C1007("qs_toolbox"; *; $ptr)
End if 
CM_analysisEnd