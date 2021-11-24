//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
If (Form:C1466.methodSelected.length=0)
	Form:C1466.methodSelected:=Form:C1466.listboxDisplayed
End if 
$action:=False:C215

If (x_io_confirm_yesNo ("Copy the "+String:C10(Form:C1466.methodSelected.length)+" method"+TOOL_plurial (Form:C1466.methodSelected.length)+" information to pasteboard";->$action))
	MP_ListToPaperboard (True:C214)
End if 
