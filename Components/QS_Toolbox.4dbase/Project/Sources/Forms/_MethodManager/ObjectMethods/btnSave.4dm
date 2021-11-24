$action:=False:C215
If (x_io_confirm_yesNo ("Do you really want to save the Attributes?";->$action))
	MM_saveMethodsAttributes (Form:C1466.listboxDisplayed)
	Form:C1466.toSave:=False:C215
	OBJECT SET VISIBLE:C603(*;"btnSave";False:C215)
End if 