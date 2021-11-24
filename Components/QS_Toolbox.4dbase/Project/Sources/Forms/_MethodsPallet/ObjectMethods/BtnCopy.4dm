C_COLLECTION:C1488($menu)
$menu:=New collection:C1472
QS_menu_pushItem($menu; "Copy method list to paperboard"; "all")
QS_menu_pushItem($menu; "Copy Project methods code to paperboard"; "project")

C_TEXT:C284($action_txt)
C_BOOLEAN:C305($isOK)
C_POINTER:C301($Nil)
$isOk:=True:C214
$action_txt:=""
$path_icons:="images/methods/icn_upd_"
$isOk:=x_btnPopup_coll(On Clicked:K2:4; ->$action_txt; $Nil; $path_icons; $menu)

If ($isOk)
	
	Case of 
			
		: ($action_txt="all")
			MP_ListToPaperboard
			
		: ($action_txt="project")
			MP_methodsCodeToPaperboard
			
	End case 
End if 