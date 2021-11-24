C_LONGINT:C283($a)

$a:=Form:C1466.selection.length

CONFIRM:C162("Do you really want to delete "+String:C10($a)+" "+Form:C1466.tablename+"?")
If (OK=1)
	Form:C1466.list:=Form:C1466.list.minus(Form:C1466.selection)
	Form:C1466.selection.drop()
End if 