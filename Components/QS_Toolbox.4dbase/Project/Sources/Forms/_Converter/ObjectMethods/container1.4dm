Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_OBJECT:C1216($togObj)
		C_LONGINT:C283($pos)
		C_POINTER:C301($valPtr;$fieldPtr)
		$togObj:=togObj1
		$fieldPtr:=->Konstant
		TOGCTN_HANDLE_CLICK ($togObj)
		TOGOBJ_GET_VAL ($togObj;"Position";->$pos)
		$valPtr:=OBJECT Get pointer:C1124(Object named:K67:5;"val1")
		
		CONVERT_UpdateList 
		
End case 