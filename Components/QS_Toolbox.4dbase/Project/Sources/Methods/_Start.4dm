//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
/* ----------------------------------------------------
 Nom utilisateur (OS) : Association QualiSoft
 Date et heure : 07/04/18, 08:52:57
 ----------------------------------------------------
 Méthode : _Start
 Description

 Paramètres
▶️ 🔄: $is_4Dpop 
 ----------------------------------------------------
*/
#DECLARE($is_4Dpop : Boolean)

C_OBJECT:C1216($QS_data; $signal)
C_BOOLEAN:C305($initDone)
C_TIME:C306($QS_TBX_START; $QS_TBX_END)

$QS_TBX_START:=Current time:C178
$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA
$initDone:=$QS_data.QS_initDone
$mainMenu:=Storage:C1525.windows.mainMenu

// Start to work now!
Use ($QS_data)
	$QS_data.analysisStart:=$QS_TBX_START
	$QS_data.QS_TBX_crossReference:=False:C215
End use 

C_BOOLEAN:C305($FirstSave)
C_OBJECT:C1216($declaration)
$declaration:=New shared object:C1526

$onErrCallMethod:=Method called on error:C704
ON ERR CALL:C155("Base_NoError")

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "Get environment variables -> start")
QST_initVariables  // Restore previous version of data

$signal:=New signal:C1641
signal_setNew($signal; 6)
// ‼️ MANUAL SETTINGS ‼️
CALL WORKER:C1389("QST_getComposantMethod"; "TOOLS_composantMethodList"; $signal)
CALL WORKER:C1389("QST_getsystemKeyword"; "TOOLS_systemKeyword"; $signal)

CALL WORKER:C1389("QST_admin"; "QST_CREATE_FOLDERS")  // No need to wait => no need to manage a signal
//CALL WORKER("QST_getPluginMethods"; "PLUGIN_listCommands"; $signal)
// CALL WORKER("QST_get4DCommand"; "TOOLS_Get4DCommand"; "FR"; $signal)
CALL WORKER:C1389("QST_getTablesList"; "BASE_getTablesList"; $signal)
CALL WORKER:C1389("QST_getObjectType"; "TOOLS_Object_Get_type"; $signal)
CALL WORKER:C1389("QST_get4DKonstant"; "TOOLS_Get4DKonstant"; "FR"; $signal)
CALL WORKER:C1389("QST_get4DKeyword"; "TOOLS_Get4DKeyword"; "FR"; $signal)
$signal.wait()

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "Get environment variables -> end")

// ************ Since Workers have been started & finished, now we can work with non preemptive stuff
If (Not:C34($initDone))
	
	If (VCS_SaveFirstTime)
		// Nothing has been done before
		Use ($QS_data)
			$QS_data.QS_initDone:=False:C215
		End use 
		
		$signal:=New signal:C1641
		signal_setNew($signal; 1)
		CALL WORKER:C1389("QST_getMethodsInformation"; "WKR_updateMethodsInformation"; $is_4Dpop; $signal)
		If (Application type:C494#4D Server:K5:6)
			ALERT:C41("No execution has been done before for this DB.\nAn automatic analysis already started and could take a while depending of the number of methods/tables/forms.\nYou can follow the progress by having a look on Process Explorer"\
				+" and looking for any process starting "+"by 'QST_xxx'.")
		End if 
		$signal.wait()  // The first one created with 8 items. Normally is already finished when user click on the OK button
		
	Else 
		
		$initDone:=True:C214
		
		$signal2:=New signal:C1641
		signal_setNew($signal2; 2)
		CALL WORKER:C1389("QST_TOOLS_readSymbolFile"; "TOOLS_readSymbolFile"; $is_4DPop; $declaration; False:C215; $signal2)
		CALL WORKER:C1389("QST_rebuildLH"; "COMMANDS_LH_create"; False:C215; $signal2)  // not PREEMPTIVE with LIST commands
		$signal2.wait()
		
		$signal:=New signal:C1641
		signal_setNew($signal; 1)
		CALL WORKER:C1389("QST_assignRestrictions"; "COMMANDS_restrictions"; $is_4DPop; $signal)  // Update storage.allMethods
		$signal.wait()
		
		CALL WORKER:C1389("QST_job"; "updateVCSapplication")
		
	End if 
	
End if 

CM_analysisEnd
CALL FORM:C1391($mainMenu; "CF_action"; True:C214)
PROCESS_sleep(60)  // Let the system finish anything in case it needs it
KILL WORKER:C1390("SplashScreen")

If (Not:C34($is_4Dpop))
	//mQST_MNU_Start
	$newProcess:=New process:C317("_MNU_Start"; 0; "QST_Menu"; "__Menu_og"; *)
	
End if 

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
End if 