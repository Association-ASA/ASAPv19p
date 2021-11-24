If (Form:C1466.key#"")
	C_OBJECT:C1216($licence)
	$licence:=New object:C1471("key";Form:C1466.key)
	If (key_checkKey ($licence)=False:C215)
		ALERT:C41("Error!!!\nThe licence number is not correct.\n\nCheck it and enter it from the 'About' button.")
		GOTO OBJECT:C206(*;"licenceKey")
	End if 
End if 