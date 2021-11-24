If (QST_minimalVersion)
	LH_clearList(Storage:C1525.QS_TBX_SHARED_DATA.QS_LH_commands)
	
	If (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode)  // Component mode
		_cleanRessourcesFolder
	End if 
End if 