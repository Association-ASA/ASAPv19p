
C_LONGINT:C283($C; $L)
C_POINTER:C301($Pt)
LISTBOX GET CELL POSITION:C971(ListBoxContamination; $C; $L; $Pt)
If ($L>0)
	EDIT ITEM:C870($Pt->{$L})
End if 
