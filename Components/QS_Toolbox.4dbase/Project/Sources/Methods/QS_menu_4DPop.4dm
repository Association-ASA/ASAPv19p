//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$menu:=New collection:C1472
QS_createMenu ($menu)

C_TEXT:C284($action_txt)
$action_txt:=""
$path_icons:="images/main/icn_"
$isOk:=x_btnPopup_coll (On Clicked:K2:4;->$action_txt;Self:C308;$path_icons;$menu)

If ($isOk)
	__Menu_mng_action ($action_txt)
End if 