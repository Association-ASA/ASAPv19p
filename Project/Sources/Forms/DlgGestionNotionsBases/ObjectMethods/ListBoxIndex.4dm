C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(ListBoxIndex;$C;$L)
If ($L>0)
	$evt:=Form event code:C388
	Case of 
		: ($evt=Sur clic:K2:4)
			
			VarDetailTexte:=TbTexteIndex{$L}
			
			
		: ($evt=Sur données modifiées:K2:15)
			
			READ WRITE:C146([DiaTexteIndex:39])
			GOTO RECORD:C242([DiaTexteIndex:39];TbIDIndex{$L})
			[DiaTexteIndex:39]DefinitionIndex:3:=TbTexteIndex{$L}
			[DiaTexteIndex:39]EntreeIndex:2:=TbEntreIndex{$L}
			SAVE RECORD:C53([DiaTexteIndex:39])
			ZAmnistiePartielle (->[DiaTexteIndex:39])
			
	End case 
Else 
	ALERT:C41("Cliquez sur une ligne d'index, SVP...")
End if 