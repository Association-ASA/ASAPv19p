C_POINTER:C301($ptr)
$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"tablelist")
If ($ptr->#0)
	C_TEXT:C284($name)
	$name:=$ptr->{$ptr->}
	Form:C1466.tablename:=$name
	Form:C1466.table:=Form:C1466.ds[$name]
	Form:C1466.list:=Form:C1466.table.all()
	DATA_DisplayListbox 
End if 