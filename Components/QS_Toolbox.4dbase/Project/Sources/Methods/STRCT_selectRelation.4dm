//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// $name:=BASE_NewSelf 

C_OBJECT:C1216($oTable)
ARRAY OBJECT:C1221($arr; 0x0000)

$position:=Form:C1466.posCurrentTable-1

If ($position>=0)
	
	C_OBJECT:C1216($oTable)
	ARRAY OBJECT:C1221($arr; 0x0000)
	$tableName:=Storage:C1525.structureTable[$position].name
	
	$FenetreInformation:="Get relations for: "+$tableName
	displayInfo($FenetreInformation)
	
	C_COLLECTION:C1488($result)
	$result:=New collection:C1472
	OB GET ARRAY:C1229(Form:C1466.oStructure; "relation"; $arr)
	
	For ($i; 1; Size of array:C274($arr))
		$oTable:=$arr{$i}
		STRCT_buildRelations($result; $oTable; $tableName)
	End for 
End if 

$Listbox_Name:="lb_result"
LB_Init_Start($Listbox_Name)

If ($result.length>0)
	
	LB_buildByCollection($result; $Listbox_Name)
	
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		If (Substring:C12($tabPropertyNames{$i}; 1; 2)="b_")
			$tabPropertyNames{$i}:=Substring:C12($tabPropertyNames{$i}; 3)
		End if 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
		LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 50)
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "From")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align left:K42:2)
				
			: ($i=2)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "To")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align left:K42:2)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Relation Name\\N to 1")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align left:K42:2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 120)
				
			: ($i=4)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Relation Name\\1 to N")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 120)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align left:K42:2)
				
			: ($i=5)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "AutoLoad\\N to 1")
				
			: ($i=6)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "AutoLoad\\1 to N")
				
			: ($i=7)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Integrity")
				
			: ($i=8)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Choice\\Field")
				
			: ($i=9)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Widlcar")
				
			: ($i=10)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Create")
				
			: ($i=11)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Auto\\Fill")
				
		End case 
		
	End for 
	LB_setHeights($Listbox_Name; 3; 1)
	
	OBJECT SET ENTERABLE:C238(*; $Listbox_Name; False:C215)
	OBJECT SET VISIBLE:C603(*; $Listbox_Name; True:C214)
	OBJECT SET VISIBLE:C603(*; "Zone_Web"; False:C215)
	
	LB_BlockEvents($Listbox_Name)
	
End if 