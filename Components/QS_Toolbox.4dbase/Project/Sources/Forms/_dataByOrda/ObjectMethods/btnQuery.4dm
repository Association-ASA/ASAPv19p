C_TEXT:C284($tablename)
C_LONGINT:C283($i)
C_POINTER:C301($table)

$tablename:=Form:C1466.tablename

For ($i;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		If (Table name:C256($i)=$tablename)
			$table:=Table:C252($i)
			$i:=Get last table number:C254
		End if 
	End if 
End for 
If (Not:C34(Is nil pointer:C315($table)))
	USE ENTITY SELECTION:C1513(Form:C1466.list)
	QUERY:C277($table->)
	If (OK=1)
		Form:C1466.list:=Create entity selection:C1512($table->)
	End if 
End if 
