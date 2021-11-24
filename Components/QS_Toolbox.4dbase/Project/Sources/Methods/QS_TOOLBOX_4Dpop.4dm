//%attributes = {"invisible":true,"shared":true}
var $1; $pt : Pointer  //For 4DPop compatibility
var $SharedData : Object
var $var : Text
$pt:=->$var

If (Storage:C1525.QS_TBX_SHARED_DATA#Null:C1517)  // We already request to start
	If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone=True:C214)
		QS_menu_4DPop
	Else 
		ALERT:C41("Start is not finish. Retry in a few moment.")
	End if 
	
Else 
	
	Init_storage
	$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
	Use ($SharedData)
		$SharedData.SoftName:="QS_Toolbox"
	End use 
	OB_windowNumberToStorage("mainMenu"; 0)
	
	var $signal : Object
	$signal:=New signal:C1641
	signal_setNew($signal; 1)
	CALL WORKER:C1389("QST_init"; "QS_init"; $pt; True:C214; $signal)
	$signal.wait()
	
End if 
