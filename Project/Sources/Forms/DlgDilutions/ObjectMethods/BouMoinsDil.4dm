C_LONGINT:C283($C; $L)
LISTBOX GET CELL POSITION:C971(*; "ListBoxDilution"; $C; $L)
If ($L>0)
	DELETE FROM ARRAY:C228(TbDilution; $L)
End if 