Case of 
	: (Form event code:C388=On Clicked:K2:4)
		  // DATA
		C_OBJECT:C1216($VarForm)
		$VarForm:=New object:C1471
		
		$ref:=Open form window:C675("_LinkCreateDataFile";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("_LinkCreateDataFile";$VarForm)
		CLOSE WINDOW:C154($ref)
		
		$Result:=$VarForm.Path_data_file
		
		OBJECT SET ENABLED:C1123(*;"lcl_getData_btn";($Result#""))
		(OBJECT Get pointer:C1124(Object named:K67:5;"create_data_file_b"))->:=Num:C11($Result#"")
		(OBJECT Get pointer:C1124(Object named:K67:5;"c_data_file_t"))->:=$Result
		
		LINKS_UpdateDOM 
End case 

