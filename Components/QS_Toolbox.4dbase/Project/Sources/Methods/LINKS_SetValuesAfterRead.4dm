//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 26/11/17, 21:20:45
  // ----------------------------------------------------
  // Méthode : LINKS_SetValuesAfterRead
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_COLLECTION:C1488($pos)

  // GLOBAL SETTINGS
$pos:=Form:C1466.linkProperties.indices("propName = :1";"is_remote_b")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"is_remote_b"))->:=1
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"user_name_t")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"user_name_t"))->:=Form:C1466.linkProperties[$pos[0]].propValue
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"password_t")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"password_t"))->:=Form:C1466.linkProperties[$pos[0]].propValue
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"structure_opening_mode")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"structure_opening_mode_li"))->:=Num:C11(Form:C1466.linkProperties[$pos[0]].propValue)
End if 

  // SETTINGS FOR REMOTE

$pos:=Form:C1466.linkProperties.indices("propName = :1";"server_database_name")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_database_name_t"))->:=Form:C1466.linkProperties[$pos[0]].propValue
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"server_path")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_path_t"))->:=Form:C1466.linkProperties[$pos[0]].propValue
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"open_login_dialog")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_open_login_dialog_b"))->:=1
End if 

  // SETTINGS FOR LOCAL

$pos:=Form:C1466.linkProperties.indices("propName = :1";"definition_import_file")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_definition_import_file_t"))->:=Form:C1466.linkProperties[$pos[0]].propValue
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"open_in_custom_mode")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_open_in_custom_mode_b"))->:=1
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"open_tools")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_open_tools_b"))->:=1
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"skip_onstartup_method")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_skip_onstartup_method_b"))->:=1
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"data_opening_mode")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_data_opening_mode_li"))->:=Num:C11(Form:C1466.linkProperties[$pos[0]].propValue)
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"structure_file")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"lcl_structure_file_t"))->:=Form:C1466.linkProperties[$pos[0]].propValue
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"data_file")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"lcl_data_file_t"))->:=Form:C1466.linkProperties[$pos[0]].propValue
End if 

  // CREATE NEW

$pos:=Form:C1466.linkProperties.indices("propName = :1";"create_structure_file")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"create_structure_file_b"))->:=1
End if 

$pos:=Form:C1466.linkProperties.indices("propName = :1";"create_data_file")
If ($pos.length>0)
	(OBJECT Get pointer:C1124(Object named:K67:5;"create_data_file_b"))->:=1
End if 
