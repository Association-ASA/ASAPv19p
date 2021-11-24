//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWsdl":false,"shared":true,"publishedWeb":false,"publishedSql":false,"executedOnServer":false}
/* QS_TOOLBOX_start
     Parameters:
    N/A
    ----------------------------------------------------
    Description:
     
    ----------------------------------------------------
    Creation: QualiSoft - Patrick EMANUEL, 21/08/21, 14:14:06
*/

// Check if worker exist...
var $process_no : Integer
var $SharedData; $signal : Object

$process_no:=Process number:C372("QST_Menu")
$result:=False:C215

If ($process_no=0)  // No : all inits to do
	// In case if issues during the opening. It helps to get the hand back
	PROCESS_sleep(5)  // wait 5 ticks
	If ((Is compiled mode:C492=False:C215) & (Shift down:C543))
		TRACE:C157
	End if 
	
	CALL WORKER:C1389("SplashScreen"; "_splashScreen")
	
	$QS_TBX_START:=Current time:C178
	$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
	Use ($SharedData)
		$SharedData.QS_TBX_START:=$QS_TBX_START
	End use 
	
	QST_createExternalDB
	
	CALL WORKER:C1389("QST_start"; "licence_checkKey")
	$signal:=New signal:C1641
	signal_setNew($signal; 1)
	CALL WORKER:C1389("QST_graphvizCheck"; "GraphvizAndNicmcd_Available"; $signal)
	$signal.wait()
	
	If (Count parameters:C259=1)
		CALL WORKER:C1389("QST_Menu"; "_MNU_Start"; "__Menu_og")
	End if 
	
	$result:=True:C214
Else 
	
	CALL WORKER:C1389($process_no; "_MNU_Start"; "__Menu_og")
	
End if 

$0:=$result