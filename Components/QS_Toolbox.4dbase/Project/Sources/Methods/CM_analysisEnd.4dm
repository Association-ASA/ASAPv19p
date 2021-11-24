//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($SharedData)

$signal:=New signal:C1641
signal_setNew($signal; 1)
CALL WORKER:C1389("QST_debug"; "floatWindow_save"; $signal)
$signal.wait()

$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
Use ($SharedData)
	$SharedData.QS_TBX_crossReference:=True:C214
	$SharedData.analysisStart:=Current time:C178
	$SharedData.excutionTime:=Current time:C178-$SharedData.analysisStart
	$SharedData.QS_initDone:=True:C214
End use 

//// Now prepare the future
//$data:=Storage.allMethods.copy()
//$directAccess:=New object 
//For ($a; 1; $data.length)
//$directAccess[$data[$a-1].name]:=New object("level"; $a-1)
//End for 
//OB_CopyToSharedObject($directAccess; Storage.index)

CALL WORKER:C1389("QST_debug"; "floatWindow_close")