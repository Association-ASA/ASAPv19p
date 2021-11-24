//%attributes = {"invisible":true,"preemptive":"capable","publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  //$menu.push(New object("label";"System info";"menu";"systeminfo"))
  //$menu.push(New object("label";"Camera";"menu";"camera"))
  //$menu.push(New object("label";"Bugs";"menu";"bug"))
  //$menu.push(New object("label";"Help";"menu";"help"))
C_COLLECTION:C1488($1;$menu)
C_BOOLEAN:C305($is_crossReference;$isOk;$calleesCallers)

$menu:=$1
  //$is_crossReference:=Bool(Storage.QS_TBX_SHARED_DATA.QS_TBX_crossReference & (Storage.allMethods.length>0))
$is_crossReference:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_crossReference)
$calleesCallers:=Storage:C1525.QS_TBX_SHARED_DATA.calleesCallersDone

QS_menu_pushItem ($menu;"4D commands";"4Dcommand";$is_crossReference)
QS_menu_pushItem ($menu;"Methods explorer";"methodManager";$is_crossReference)
QS_menu_pushItem ($menu;"Form explorer";"formExplorer";$is_crossReference)
QS_menu_pushItem ($menu;"DB overview";"dbOverview";$is_crossReference)
QS_menu_pushItem ($menu;"User mode navigator";"dataExplorer")
QS_menu_pushItem ($menu;"";"")
QS_menu_pushItem ($menu;"Methods analyser";"methodAnalyser";$is_crossReference)
QS_menu_pushItem ($menu;"Methods pallet";"methodsPallet";$is_crossReference)
QS_menu_pushItem ($menu;"Methods call chain";"MethodsCallChain";($is_crossReference & $calleesCallers))
QS_menu_pushItem ($menu;"";"")
QS_menu_pushItem ($menu;"Structure analysis";"structureAnalysis";$is_crossReference)
QS_menu_pushItem ($menu;"Search and Control";"searchAndControl";$is_crossReference)
QS_menu_pushItem ($menu;"Reports";"reports";$is_crossReference)
QS_menu_pushItem ($menu;"";"")
QS_menu_pushItem ($menu;"Version Control System";"vcs")
QS_menu_pushItem ($menu;"Converter EN/FR";"converter")
QS_menu_pushItem ($menu;"";"")
QS_menu_pushItem ($menu;"New DB analysis";"dbAnalyze";$is_crossReference)
QS_menu_pushItem ($menu;"Callees/Callers analysis";"Callees";$is_crossReference)
QS_menu_pushItem ($menu;"";"")

If (Current process name:C1392="QST_Menu")  // Show this only when we are on Pallet mode
	QS_menu_pushItem ($menu;"Go to structure";"goToStructure")
End if 

QS_menu_pushItem ($menu;"Setup";"setup")
QS_menu_pushItem ($menu;"Restart 4D";"restart")

QS_menu_pushItem ($menu;"";"")
QS_menu_pushItem ($menu;"QST Pallet";"_MNU_Start")
If (Current process name:C1392="QST_Menu")  // Remove the 2 last items from the Pallet mode
	$menu:=$menu.remove($menu.length-2;2)
End if 