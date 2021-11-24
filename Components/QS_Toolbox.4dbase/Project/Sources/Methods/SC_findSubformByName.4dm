//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Méthode : SC_findSubformByName
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 02/12/19, 21:23:26
// Paramètres


C_TEXT:C284($search)
C_COLLECTION:C1488($result)
C_LONGINT:C283($tableId)
C_POINTER:C301($ptSubTable)
C_OBJECT:C1216($table)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
$searchInit:=Request:C163("Enter an object Name"; "This one")

If (OK=1) & ($searchInit#"") & ($searchInit#"This one")
	$search:="@"+$searchInit+"@"  // String to find 
	
	
	BASE_getTablesList(True:C214)
	ARRAY TEXT:C222($tTxt_objects; 0x0000)
	ARRAY POINTER:C280($tPtr_var; 0x0000)
	ARRAY LONGINT:C221($tLon_pages; 0x0000)
	ARRAY TEXT:C222($TbForms; 0x0000)
	
	$result.clear()
	
	For each ($table; Storage:C1525.structureTable)  // For each table
		$tableId:=$table.id
		$Formulare:=""
		CLEAR VARIABLE:C89($TbForms)
		$tableName:=Str_GetTableOrProjectForm($tableId)
		
		If ($table.id>0)
			FORM GET NAMES:C1167(Table:C252($tableId)->; $TbForms; *)
		Else 
			FORM GET NAMES:C1167($TbForms; *)
		End if 
		
		
		For ($sale; 1; Size of array:C274($TbForms))  // For each form
			
			$Formulare:=$TbForms{$sale}
			$newForm:=True:C214
			FE_getObjectsAndMethods($tableId; $Formulare; ->$tTxt_objects; ->$tPtr_var; ->$tLon_pages)
			
			For ($a; 1; Size of array:C274($tTxt_objects))
				
				$object_name:=$tTxt_objects{$a}
				$type:=OBJECT Get type:C1300(*; $object_name)
				
				If ($type=Object type subform:K79:40)
					OBJECT GET SUBFORM:C1139(*; $object_name; $ptSubTable; $subForm; $listSubform)
					$isOk:=($subForm=$search)  //| ($subForm=$listSubform)
					If ($isOk)
						$information:=""
						If ($ptSubTable#Null:C1517)
							$information:="["+Table name:C256($ptSubTable)+"]"
						End if 
						If ($subForm#"")
							$information:=$information+$subForm
						End if 
						If ($listSubform#"")
							$information:=$information+$listSubform
						End if 
						$result.push(New object:C1471("method"; $tableName+$Formulare; "object"; $object_name; "details"; $information; "empty"; ""))
					End if 
					
				End if 
				
			End for 
			
			FORM UNLOAD:C1299
			
		End for 
		
	End for each 
	
	If ($result.length>0)
		LB_buildByCollection($result; $Listbox_Name)
		Form:C1466.result:=$result.copy().orderBy("method desc")
		ARRAY TEXT:C222($tabPropertyNames; 0x0000)
		OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
		
		For ($i; 1; Size of array:C274($tabPropertyNames))
			
			Case of 
				: ($i=1)
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table Name\rMethod Path Name\rObject name")
					
				: ($i=2)
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 250)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Object Name")
					
				: ($i=3)
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Object Type")
					
				: ($i=4)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
					
			End case 
			
		End for 
		
		LB_setHeights($Listbox_Name; 3; 2)
		
	Else 
		LB_Init_Start($Listbox_Name)
	End if 
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	displayInfo("Search for '"+$searchInit+"' finished.\rFound "+String:C10($result.length)+" reference(s).")
Else 
	
	displayInfo("No object with '"+$searchInit+"' has been found in this database."; "red")
	
End if 