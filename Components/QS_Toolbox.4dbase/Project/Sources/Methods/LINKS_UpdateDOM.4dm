//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}

(OBJECT Get pointer:C1124(Object named:K67:5;"ChangeDetected"))->:=1
  // GLOBAL SETTINGS

If ((OBJECT Get pointer:C1124(Object named:K67:5;"is_remote_b"))->=1)
	LINK_UpdateProperty ("is_remote";"true")
Else 
	LINK_RemoveProperty ("is_remote")
End if 
OBJECT SET ENABLED:C1123(*;"Rmt_@";(OBJECT Get pointer:C1124(Object named:K67:5;"is_remote_b"))->=1)
OBJECT SET ENABLED:C1123(*;"Lcl_@";(OBJECT Get pointer:C1124(Object named:K67:5;"is_remote_b"))->#1)

If ((OBJECT Get pointer:C1124(Object named:K67:5;"user_name_t"))->#"")
	LINK_UpdateProperty ("user_name";(OBJECT Get pointer:C1124(Object named:K67:5;"user_name_t"))->)
Else 
	LINK_RemoveProperty ("user_name")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"password_t"))->#"")
	LINK_UpdateProperty ("password";(OBJECT Get pointer:C1124(Object named:K67:5;"password_t"))->)
Else 
	LINK_RemoveProperty ("password")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"structure_opening_mode_li"))->>0)
	$value:=String:C10((OBJECT Get pointer:C1124(Object named:K67:5;"structure_opening_mode_li"))->-1)
	LINK_UpdateProperty ("structure_opening_mode";$value)
End if 

  // SETTINGS FOR REMOTE

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_database_name_t"))->#"")
	LINK_UpdateProperty ("server_database_name";(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_database_name_t"))->)
Else 
	LINK_RemoveProperty ("server_database_name")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_path_t"))->#"")
	LINK_UpdateProperty ("server_path";(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_path_t"))->)
Else 
	LINK_RemoveProperty ("server_path")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_open_login_dialog_b"))->=1)
	LINK_UpdateProperty ("open_login_dialog";"true")
Else 
	LINK_RemoveProperty ("open_login_dialog")
End if 

  // SETTINGS FOR LOCAL

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_open_in_custom_mode_b"))->=1)
	LINK_UpdateProperty ("open_in_custom_mode";"true")
Else 
	LINK_RemoveProperty ("open_in_custom_mode")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_open_tools_b"))->=1)
	LINK_UpdateProperty ("open_tools";"true")
Else 
	LINK_RemoveProperty ("open_tools")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_skip_onstartup_method_b"))->=1)
	LINK_UpdateProperty ("skip_onstartup_method";"true")
Else 
	LINK_RemoveProperty ("skip_onstartup_method")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"lcl_definition_import_file_t"))->#"")
	LINK_UpdateProperty ("definition_import_file";(OBJECT Get pointer:C1124(Object named:K67:5;"lcl_definition_import_file_t"))->)
Else 
	LINK_RemoveProperty ("definition_import_file")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_structure_file_t"))->#"")
	LINK_UpdateProperty ("structure_file";(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_structure_file_t"))->)
Else 
	LINK_RemoveProperty ("structure_file")
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"lcl_data_file_t"))->#"")
	LINK_UpdateProperty ("data_file";(OBJECT Get pointer:C1124(Object named:K67:5;"lcl_data_file_t"))->)
Else 
	LINK_RemoveProperty ("data_file")
End if 

  // DO NOT USE -- 4D INTERNAL USED ONLY
  //If ((OBJECT Get pointer(Object named;"resources_import_file_t"))->#"")
  //LINK_UpdateProperty ("resources_import_file";(OBJECT Get pointer(Object named;"resources_import_file_t"))->)
  //Else 
  //LINK_RemoveProperty ("resources_import_file")
  // End if  

If ((OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_data_opening_mode_li"))->>0)
	$value:=String:C10((OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_data_opening_mode_li"))->)
	LINK_UpdateProperty ("data_opening_mode";$value)
End if 

  // CREATE NEW
(OBJECT Get pointer:C1124(Object named:K67:5;"create_structure_file_b"))->:=Num:C11((OBJECT Get pointer:C1124(Object named:K67:5;"c_structure_file_t"))->#"")

If ((OBJECT Get pointer:C1124(Object named:K67:5;"create_structure_file_b"))->=1)
	LINK_UpdateProperty ("create_structure_file";"true")
	LINK_UpdateProperty ("structure_file";(OBJECT Get pointer:C1124(Object named:K67:5;"c_structure_file_t"))->)
Else 
	LINK_RemoveProperty ("create_structure_file")
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"c_structure_file_t"))->#"")
		LINK_RemoveProperty ("structure_file")
	End if 
End if 

(OBJECT Get pointer:C1124(Object named:K67:5;"create_data_file_b"))->:=Num:C11((OBJECT Get pointer:C1124(Object named:K67:5;"c_data_file_t"))->#"")

If ((OBJECT Get pointer:C1124(Object named:K67:5;"create_data_file_b"))->=1)
	LINK_UpdateProperty ("create_data_file";"true")
	LINK_UpdateProperty ("data_file";(OBJECT Get pointer:C1124(Object named:K67:5;"c_data_file_t"))->)
Else 
	LINK_RemoveProperty ("create_data_file")
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"c_data_file_t"))->#"")
		LINK_RemoveProperty ("data_file")
	End if 
End if 