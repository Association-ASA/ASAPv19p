C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(ListBoxIndex;$C;$L)
If ($L>0)
	READ WRITE:C146([DiaTexteIndex:39])
	GOTO RECORD:C242([DiaTexteIndex:39];TbIDIndex{$L})
	DELETE RECORD:C58([DiaTexteIndex:39])
	ZAmnistiePartielle (->[DiaTexteIndex:39])
	
	LISTBOX DELETE ROWS:C914(ListBoxIndex;$L)
Else 
	ALERT:C41("Cliquez sur une ligne d'index, SVP...")
End if 