//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($menu)
C_POINTER:C301($Nil)
$menu:=New collection:C1472

QS_menu_pushItem ($menu;"Project method";"50")
QS_menu_pushItem ($menu;"Project forms";"51")
QS_menu_pushItem ($menu;"Database";"52")
QS_menu_pushItem ($menu;"Table forms";"53")
QS_menu_pushItem ($menu;"Trigger";"54")
QS_menu_pushItem ($menu;"Class";"55";QS_miniVersionR (3))

C_TEXT:C284($action_txt)
$action_txt:=""
$path_icons:="images/methods/icn_"
$isOk:=x_btnPopup_coll (On Clicked:K2:4;->$action_txt;$Nil;$path_icons;$menu)
If ($isOk)
	
	For ($id;50;55)
		(OBJECT Get pointer:C1124(Object named:K67:5;"rd"+String:C10($id)))->:=0
	End for 
	(OBJECT Get pointer:C1124(Object named:K67:5;"rd"+$action_txt))->:=1
	MM_restoreList 
	Form:C1466.fromWhen:=-1
	
End if 