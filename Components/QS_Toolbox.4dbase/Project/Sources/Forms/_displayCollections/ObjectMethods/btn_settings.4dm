C_COLLECTION:C1488($menu)
C_POINTER:C301($Nil)
C_TEXT:C284($action_txt)
$action_txt:=""
$path_icons:="images/methods/icn_upd_"
$isOk:=True:C214

$menu:=New collection:C1472
QS_menu_pushItem ($menu;"Export Picture Library";"picture")
QS_menu_pushItem ($menu;"-----------";"")
QS_menu_pushItem ($menu;"Open CSM";"csm")
QS_menu_pushItem ($menu;"Open Application properties";"application")
QS_menu_pushItem ($menu;"-----------";"")
QS_menu_pushItem ($menu;"Compact Data file";"compact")

$isOk:=x_btnPopup_coll (On Clicked:K2:4;->$action_txt;$Nil;$path_icons;$menu)
If ($isOk)
	
	Case of 
			
		: ($action_txt="picture")
			OTHERS_PictureLibraryExport 
			
		: ($action_txt="csm")
			OPEN SECURITY CENTER:C1018
			
		: ($action_txt="application")
			OPEN SETTINGS WINDOW:C903("/")
			
		: ($action_txt="compact")
			TOOLS_CompactDB 
	End case 
End if 
