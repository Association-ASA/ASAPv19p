$formulareName:=""
$RefMenu:=Create menu:C408

//APPEND MENU ITEM($RefMenu;"Design form export")
//SET MENU ITEM PARAMETER($RefMenu;-1;"1")
//SET MENU ITEM ICON($RefMenu;-1;"file:images/icons/icn_fr_form.png")

GET LIST ITEM:C378(*; "myLH"; Selected list items:C379(*; "myLH"); $eleRef; $eleTxt; $eleSSL; $elebDep)
If ($eleRef#0)  // No action on Project forms
	ARRAY TEXT:C222($atKeys; 0x0000)
	ARRAY TEXT:C222($atValues; 0x0000)
	GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item
	$key:=Find in array:C230($atKeys; "tableNumber")
	$key2:=Find in array:C230($atKeys; "formName")
	
	$tableNumber:=Num:C11($atValues{$key})
	$formulareName:=$atValues{$key2}
	
	If ($tableNumber>0)
		C_POINTER:C301($ZptTable)
		$ZptTable:=Table:C252($tableNumber)
	End if 
End if 

If ($formulareName#"")
	APPEND MENU ITEM:C411($RefMenu; "Graphviz picture export")
	SET MENU ITEM PARAMETER:C1004($RefMenu; -1; "2")
	SET MENU ITEM ICON:C984($RefMenu; -1; "file:images/icons/icn_fr_graphviz.png")
	
	APPEND MENU ITEM:C411($RefMenu; "-")
	SET MENU ITEM PARAMETER:C1004($RefMenu; -1; "0")
	
	APPEND MENU ITEM:C411($RefMenu; "json view")
	SET MENU ITEM PARAMETER:C1004($RefMenu; -1; "3")
	SET MENU ITEM ICON:C984($RefMenu; -1; "file:images/icons/icn_fr_view.png")
	
	APPEND MENU ITEM:C411($RefMenu; "json save")
	SET MENU ITEM PARAMETER:C1004($RefMenu; -1; "4")
	SET MENU ITEM ICON:C984($RefMenu; -1; "file:images/icons/icn_fr_save.png")
	
Else 
	APPEND MENU ITEM:C411($RefMenu; "-")
	SET MENU ITEM PARAMETER:C1004($RefMenu; -1; "100")
	
	APPEND MENU ITEM:C411($RefMenu; "<IOptions are available when a form is selected")
	SET MENU ITEM PARAMETER:C1004($RefMenu; -1; "200")
End if 

$referenceLigne:=Dynamic pop up menu:C1006($RefMenu)
RELEASE MENU:C978($RefMenu)

Case of 
	: ($referenceLigne="1")
		C_OBJECT:C1216($FormDetail; $signal)
		// Initialisation
		C_OBJECT:C1216($param)
		$param:=New object:C1471("title"; "Export form definition"; "icon"; "images/icons/btn_attributes.png"; "type"; 0)
		QST_progress_start($param)
		
		$FormDetail:=New object:C1471
		$FormDetail.tableNum:=0
		$FormDetail.formName:=""
		$FormDetail.tableName:=""
		
		SUPPORT_form_GetJSON($FormDetail)
		$signal:=New signal:C1641
		signal_setNew($signal; 1)
		CALL WORKER:C1389("QST_exportForm"; "FE_exportForm"; $FormDetail; $signal)
		$signaled:=$signal.wait()
		
	: ($referenceLigne="2")
		FE_createGraphviz
		
	: ($referenceLigne="3")
		FE_viewFormJSON
		
	: ($referenceLigne="4")
		FE_exportFormJSON
		
End case 