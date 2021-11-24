Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_OBJECT:C1216($togObj)
		C_LONGINT:C283($pos)
		C_POINTER:C301($valPtr)
		$togObj:=togObj1
		  //$fieldPtr:=->tableProperties
		TOGCTN_HANDLE_CLICK ($togObj)
		TOGOBJ_GET_VAL ($togObj;"Position";->$pos)
		$valPtr:=OBJECT Get pointer:C1124(Object named:K67:5;"val1")
		
		Form:C1466.tableProperties:=Not:C34(Form:C1466.tableProperties)
		STRCT_displayTableInformation 
End case 