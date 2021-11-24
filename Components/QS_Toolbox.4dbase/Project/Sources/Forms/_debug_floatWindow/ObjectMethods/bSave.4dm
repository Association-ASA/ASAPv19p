C_COLLECTION:C1488($menu)
C_POINTER:C301($Nil)
C_TEXT:C284($action_txt)
$action_txt:=""
$path_icons:="images/methods/icn_upd_"
$isOk:=True:C214

$menu:=New collection:C1472
QS_menu_pushItem ($menu;"Export to .HTML";"html")
QS_menu_pushItem ($menu;"Export to .CSV";"csv")
QS_menu_pushItem ($menu;"Export to .TXT";"txt")

$isOk:=x_btnPopup_coll (On Clicked:K2:4;->$action_txt;$Nil;$path_icons;$menu)
If ($isOk)
	
	
	Case of 
		: ($action_txt="html")
			Collection_toHTML (messages;"Debug of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
			
		: ($action_txt="csv")
			Collection_toCSV (messages;"Debug of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
			
		: ($action_txt="txt")
			Collection_toTXT (messages;"Debug of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
			
	End case 
End if 