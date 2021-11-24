//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 09/05/16, 23:16:09
// ----------------------------------------------------
// méthode : METHODS_CreateNeighboringGraph
// description
//
// paramètres
// ----------------------------------------------------

Graphviz_check

If (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Graphviz)
	
	C_COLLECTION:C1488($menu)
	C_POINTER:C301($Nil)
	$menu:=New collection:C1472
	QS_menu_pushItem($menu; ".png"; ".png")
	QS_menu_pushItem($menu; ".pdf"; ".pdf")
	QS_menu_pushItem($menu; ".jpg"; ".jpg")
	QS_menu_pushItem($menu; ".svg"; ".svg")
	
	C_TEXT:C284($action_txt)
	$action_txt:=""
	$path_icons:="images/methods/icn_exp_"
	$isOk:=x_btnPopup_coll(On Clicked:K2:4; ->$action_txt; $Nil; $path_icons; $menu)
	
	If ($isOk)
		
		Graphviz_neighboresCreation
		
	End if 
Else   // <>QS_TBX_Graphviz = False
	
	displayInfo("Graphviz command line is missing."; "red")
End if 