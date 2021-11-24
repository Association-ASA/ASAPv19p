//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($object)

CALL FORM:C1391(Current form window:C827;"CF_setMagic";True:C214)
PROCESS_sleep 

$object:=FORM Event:C1606.objectName
$action:=Form:C1466.method[Num:C11($object)-1]
If ($action#"")
	Form:C1466.result.clear()
	LB_Init_Start ("LB_Information")  // To clean the screen
	EXECUTE METHOD:C1007($action;*)
End if 

Form:C1466.resultCopy:=Form:C1466.result.copy()
Form:C1466.callAgain.unshift(New object:C1471("method";$action;"title";Form:C1466.menu[Num:C11($object)-1].menu))
If (Form:C1466.callAgain.length>10)
	Form:C1466.callAgain.remove(Form:C1466.callAgain.length-1;1)
End if 
OBJECT SET VISIBLE:C603(*;"@Redo";Form:C1466.callAgain.length>0)

