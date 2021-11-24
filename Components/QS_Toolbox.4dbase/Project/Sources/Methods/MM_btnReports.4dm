//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $is_graphviz; $is_neighbors : Boolean
var $menu : Collection
var $Nil : Pointer

Graphviz_check

$is_graphviz:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Graphviz
$is_neighbors:=(Form:C1466.currentElement#Null:C1517)
$menu:=New collection:C1472

QS_menu_pushItem($menu; "HTML report without schema"; "html_wos")
QS_menu_pushItem($menu; "HTML report with schema"; "html_ws"; $is_graphviz)
QS_menu_pushItem($menu; "Closer neighbors schema"; "neighbors"; ($is_graphviz & $is_neighbors))
QS_menu_pushItem($menu; "Closer neighbors schema - ALL"; "neighbors_a"; $is_graphviz)

var $action_txt : Text
$action_txt:=""
$path_icons:="images/methods/icn_exp_"
$isOk:=x_btnPopup_coll(On Clicked:K2:4; ->$action_txt; $Nil; $path_icons; $menu)

If ($isOk)
	
	Case of 
			
		: ($action_txt="html_ws")
			CALL WORKER:C1389("QST_job"; "MM_export_HTML")
			
		: ($action_txt="html_wos")
			// Force the Graphviz to False
			var $oldValue : Boolean
			$oldValue:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Graphviz
			If ($oldValue=True:C214)
				CALL WORKER:C1389("QST_job"; "MM_changeGraphvizStatus"; False:C215)
				CALL WORKER:C1389("QST_job"; "MM_export_HTML")
				CALL WORKER:C1389("QST_job"; "MM_changeGraphvizStatus"; $oldValue)
			Else 
				CALL WORKER:C1389("QST_job"; "MM_export_HTML")
			End if 
			
		: ($action_txt="neighbors")
			MM_createNeighboringGraph
			
		: ($action_txt="neighbors_a")
			CALL WORKER:C1389("QST_job"; "MM_graphviz_AllNeighboring")
			
	End case 
End if 
