C_LONGINT:C283($C; $L)
LISTBOX GET CELL POSITION:C971(ListBoxIndex; $C; $L)
If ($L>0)
	TbTexteIndex{$L}:=VarDetailTexte
	READ WRITE:C146([DiaTexteIndex:39])
	GOTO RECORD:C242([DiaTexteIndex:39]; TbIDIndex{$L})
	[DiaTexteIndex:39]DefinitionIndex:3:=TbTexteIndex{$L}
	SAVE RECORD:C53([DiaTexteIndex:39])
	ZAmnistiePartielle(->[DiaTexteIndex:39])
End if 