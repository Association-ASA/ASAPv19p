//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($SharedData)
C_LONGINT:C283($PreviousValue)

$PreviousValue:=Storage:C1525.QS_TBX_SHARED_DATA.startDBAnalysis

$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
Use ($SharedData)
	$SharedData.analysisStart:=Current time:C178
	$SharedData.calleesCallersDone:=False:C215
	$SharedData.startDBAnalysis:=1
End use 

$x:=Current time:C178
CALL WORKER:C1389("QST_debug"; "floatWindow_launch")
CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; "method"; 0)
CM_crossReference
$x:=Current time:C178-$x

$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
Use ($SharedData)
	$SharedData.startDBAnalysis:=$PreviousValue
End use 

//ALERT(Time string($x))