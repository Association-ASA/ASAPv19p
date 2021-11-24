//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($menu)
C_POINTER:C301($Nil)
$menu:=New collection:C1472

If ((OBJECT Get pointer:C1124(Object named:K67:5;"rd50"))->=1)
	QS_menu_pushItem($menu;"Attributes";"attributes")
End if 

QS_menu_pushItem($menu;"Deprecated commands";"deprecated")
QS_menu_pushItem($menu;"Beautify methods (Mimosa)";"mimosa")

If ((OBJECT Get pointer:C1124(Object named:K67:5;"rd53"))->#1)
	QS_menu_pushItem($menu;"Magik comments (Protée)";"protee";QS_miniVersionR(3))
	QS_menu_pushItem($menu;"Clear comments";"clear_c";QS_miniVersionR(3))
End if 

C_TEXT:C284($action_txt)
$action_txt:=""
$path_icons:="images/methods/icn_upd_"
$isOk:=x_btnPopup_coll(On Clicked:K2:4;->$action_txt;$Nil;$path_icons;$menu)

If ($isOk)
	
	Case of 
			
		: ($action_txt="attributes")
			MM_massiveUpdatetAttributes
			
		: ($action_txt="deprecated")
			MM_CorrectDeprecated
			
		: ($action_txt="mimosa")
			MM_massiveBeautify
			
		: ($action_txt="protee")
			
			If (QS_miniVersionR(3))
				MM_massiveMagikComment
			Else 
				
			End if 
			
		: ($action_txt="create_c")
			MM_createComment
			
		: ($action_txt="clear_c")
			MM_clearComment
			
	End case 
	Form:C1466.listboxDisplayed:=Form:C1466.listboxDisplayed
End if 