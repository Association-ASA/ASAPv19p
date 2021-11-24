//%attributes = {"invisible":true}
var $type : Integer
var $SharedData : Object
var $1 : Pointer

//SET DATABASE PARAMETER(Debug log recording;2+4+8)

ON ERR CALL:C155("Base_NoError")

If (Count parameters:C259>=2)
	$type:=Type:C295($2)
End if 

Init_storage
QST_initStorage

CALL WORKER:C1389("QST_debug"; "floatWindow_launch")
CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; "start"; 0)

OB_windowNumberToStorage("mainMenu"; 0)
OB_windowNumberToStorage("counter"; -MAXINT:K35:1+1)

If (QS_TOOLBOX_start)
	If (Process number:C372("QST_job")=0)
		Case of 
			: ($type#Is boolean:K8:9)  // to avoid to work with multiple cases
				CALL WORKER:C1389("QST_start"; "_Start"; True:C214)
				
			: ($type=Is boolean:K8:9)
				CALL WORKER:C1389("QST_start"; "_Start"; $2)
				
		End case 
	End if 
End if 

CALL FORM:C1391(Storage:C1525.windows.mainMenu; "CF_action"; $SharedData.QS_initDone)

If (Count parameters:C259=3)
	var $3 : Object
	signal_addResult($3; Current method name:C684)
End if 
//SET DATABASE PARAMETER(Debug log recording;0)