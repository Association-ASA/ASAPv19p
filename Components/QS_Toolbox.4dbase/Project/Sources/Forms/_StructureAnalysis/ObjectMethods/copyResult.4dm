Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		$isOk:=True:C214
		$Listbox_Name:="Lb_Balance"
		If (LISTBOX Get number of rows:C915(*;$Listbox_Name)>5000)
			$action:=False:C215
			$isOk:=x_io_confirm_yesNo ("This can take a while. Do you really want to copy all data?";->$action)
			
		End if 
		
		If ($isOk)
			LB_ListBox_To_PasteBoard ($Listbox_Name)
		End if 
End case 