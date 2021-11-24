C_COLLECTION:C1488($menu)
C_POINTER:C301($Nil)
$menu:=New collection:C1472
$isOk:=True:C214

QS_menu_pushItem($menu; "Rename variable"; "renameVariable")

C_TEXT:C284($action_txt)
$action_txt:=""
$path_icons:="images/methods/icn_upd_"
$isOk:=x_btnPopup_coll(On Clicked:K2:4; ->$action_txt; $Nil; $path_icons; $menu)

If ($isOk)
	Case of 
			
		: ($action_txt="renameVariable")
			MP_renameVariable
			
	End case 
End if 

