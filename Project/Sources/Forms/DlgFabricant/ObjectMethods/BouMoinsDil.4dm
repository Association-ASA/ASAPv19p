C_LONGINT:C283($C; $L)
LISTBOX GET CELL POSITION:C971(*; "ListBoxFabricant"; $C; $L)
If ($L>0)
	DELETE FROM ARRAY:C228(TbFabricant; $L)
End if 