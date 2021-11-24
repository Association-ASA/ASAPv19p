
C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		
		Form:C1466.tableProperties:=False:C215
		
		$Listbox_Name:="ExploreStructure"
		LB_Init_Start($Listbox_Name)
		BASE_getTablesList(True:C214)
		Form:C1466.structure:=Storage:C1525.structureTable
		Form:C1466.result:=New collection:C1472
		Form:C1466.callAgain:=New collection:C1472
		Form:C1466.readAndWrite:=False:C215
		
		OBJECT SET VISIBLE:C603(*; "4DFile@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Zone_Web"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Read@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "lb_result"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "ListeTables"; False:C215)
		
		Form:C1466.oStructure:=STRCT_GetDatabaseStructure
		FORM GOTO PAGE:C247(1)
		
		
	: ($evt=On Page Change:K2:54)
		
		displayInfo("")
		//OBJECT SET VISIBLE(*;"ExploreStructure";(FORM Get current page=1))
		OBJECT SET VISIBLE:C603(*; "LB_Information"; (FORM Get current page:C276=3))
		OBJECT SET VISIBLE:C603(*; "lb_result"; (FORM Get current page:C276<3))
		OBJECT SET VISIBLE:C603(*; "Read@"; (FORM Get current page:C276=4))
		OBJECT SET VISIBLE:C603(*; "struct_@"; (FORM Get current page:C276<3))
		
		LB_Init_Start("lb_result")
		LB_Init_Start("LB_Information")
		
		Case of 
			: (FORM Get current page:C276=1)
				OBJECT SET VISIBLE:C603(*; "Zone_Web"; False:C215)
				
			: (FORM Get current page:C276=2)
				$Listbox_Name:="lb_result"
				LB_Init_Start($Listbox_Name)
				
			: (FORM Get current page:C276=3)
				$Debug:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Debug
				OBJECT SET VISIBLE:C603(*; "encours"; $Debug)
				$txt:="WARNING: make a backup prior using 4D or SQL commands directly on your data."
				displayInfo($txt; "red")
				
			: (FORM Get current page:C276=4)
				(OBJECT Get pointer:C1124(Object named:K67:5; "ChangeDetected"))->:=0
				LINKS_InitOptions
				LINKS_List4DLinks
				
		End case 
		
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		BASE_getTablesList
		CANCEL:C270
		
End case 