var $menu : Collection

$menu:=New collection:C1472
QS_menu_pushItem($menu; "User guide"; "us")
QS_menu_pushItem($menu; "Guide Utilisateur"; "fr")

C_TEXT:C284($action_txt)
C_BOOLEAN:C305($isOK)
C_POINTER:C301($Nil)
$action_txt:=""
$path_icons:="images/flags/"
$isOk:=x_btnPopup_coll(On Clicked:K2:4; ->$action_txt; $Nil; $path_icons; $menu)

If ($isOk)
	If ($action_txt="")
		$action_txt:="us"
	End if 
	
	CANCEL:C270
	CALL WORKER:C1389("QST_userGuide"; "_userGuide"; $action_txt)
End if 
