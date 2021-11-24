//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 26/11/17, 16:39:33
  // ----------------------------------------------------
  // Méthode : LINKS_InitOptions
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------


  // GLOBAL SETTINGS

(OBJECT Get pointer:C1124(Object named:K67:5;"is_remote_b"))->:=0
(OBJECT Get pointer:C1124(Object named:K67:5;"user_name_t"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"password_t"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"structure_opening_mode_li"))->:=1

OBJECT SET ENABLED:C1123(*;"Rmt_@";(OBJECT Get pointer:C1124(Object named:K67:5;"is_remote_b"))->=1)
OBJECT SET ENABLED:C1123(*;"Lcl_@";(OBJECT Get pointer:C1124(Object named:K67:5;"is_remote_b"))->#1)

  // SETTINGS FOR REMOTE

(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_database_name_t"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_server_path_t"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"Rmt_open_login_dialog_b"))->:=0

  // SETTINGS FOR LOCAL

(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_open_in_custom_mode_b"))->:=0
(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_open_tools_b"))->:=0
(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_skip_onstartup_method_b"))->:=0
(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_definition_import_file_t"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"Lcl_data_opening_mode_li"))->:=1

  // CREATE NEW

(OBJECT Get pointer:C1124(Object named:K67:5;"create_structure_file_b"))->:=0
(OBJECT Get pointer:C1124(Object named:K67:5;"c_structure_file_t"))->:=""

(OBJECT Get pointer:C1124(Object named:K67:5;"create_data_file_b"))->:=0
(OBJECT Get pointer:C1124(Object named:K67:5;"c_data_file_t"))->:=""

Form:C1466.linkProperties:=New collection:C1472