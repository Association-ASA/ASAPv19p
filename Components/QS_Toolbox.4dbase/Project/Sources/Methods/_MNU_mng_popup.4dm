//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}

If (Right click:C712)
	C_COLLECTION:C1488($menu)
	$menu:=New collection:C1472
	QS_createMenu($menu)
	
	C_TEXT:C284($action_txt)
	C_BOOLEAN:C305($isOK)
	$isOk:=True:C214
	$action_txt:=""
	$path_icons:="images/main/icn_"
	$isOk:=x_btnPopup_coll(On Clicked:K2:4; ->$action_txt; Self:C308; $path_icons; $menu)
	
Else 
	C_TEXT:C284($action_txt)
	C_BOOLEAN:C305($isOK)
	$action_txt:=x_btn_toggleReadTxt(Self:C308)
	$isOk:=True:C214
End if 

If ($isOk)
	__Menu_mng_action($action_txt)
	
	Case of 
		: ($action_txt="dbAnalyze")
			$action:=$menu[0].menu  // Select the first item of the menu
			x_btn_toggleSetTxt(Self:C308; $action)
			
		: ($action_txt="Callees")
			$action:=$menu[1].menu  // Select the second item of the menu
			x_btn_toggleSetTxt(Self:C308; $action)
			
	End case 
	
End if 
