//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick
// Date et heure : 05/08/16
// ----------------------------------------------------
// Méthode : SC_lookAtEvents
// Description
//  
//
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($tTxt_objects; 0x0000)
ARRAY POINTER:C280($tPtr_var; 0x0000)
ARRAY LONGINT:C221($tLon_pages; 0x0000)
ARRAY LONGINT:C221($tabEvenement; 0x0000)

ARRAY TEXT:C222($TbForms; 0x0000)
C_COLLECTION:C1488($events; $result)
C_LONGINT:C283($tableID; $Progressing)
C_OBJECT:C1216($event; $table)
C_TEXT:C284($Language)


$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

BASE_getTablesList(True:C214)
$result:=New collection:C1472
$events:=New collection:C1472
$Language:=Config_getLanguage
$RefMenu:=Create menu:C408
$events:=Storage:C1525.constants.query("token = :1"; ":K2:@")

C_COLLECTION:C1488($col)
$col:=New collection:C1472

For each ($event; $events)
	$col.push($event[$language])
End for each 

$EventRef:=Num:C11(Pop up menu:C542($col.join(";")))

If ($EventRef>0)
	$Progressing:=Storage:C1525.structureTable.length
	$Progression:=0
	$Pas:=1/($Progressing+1)
	
	For each ($table; Storage:C1525.structureTable)  // for each table 
		
		$tableID:=$table.id
		$tableName:=Str_GetTableOrProjectForm($tableID)
		
		If ($tableID>0)
			FORM GET NAMES:C1167(Table:C252($tableID)->; $TbForms; *)
		Else 
			FORM GET NAMES:C1167($TbForms; *)
		End if 
		
		For ($sale; 1; Size of array:C274($TbForms))  //  For each Form
			
			$Formulare:=$TbForms{$sale}
			FE_getObjectsAndMethods($tableID; $Formulare; ->$tTxt_objects; ->$tPtr_var; ->$tLon_pages)
			
			For ($a; 1; Size of array:C274($tTxt_objects))
				
				ARRAY LONGINT:C221($tabEvenement; 0x0000)
				$objet:=$tTxt_objects{$a}
				OBJECT GET EVENTS:C1238(*; $objet; $tabEvenement)  // Get all events flagged for each Widget
				
				If (Find in array:C230($tabEvenement; $EventRef)>0)
					$result.push(New object:C1471("method"; Choose:C955(Bool:C1537($tableName="{Project form}"); "{Project form}_"+$Formulare; $tableName+$Formulare); "type"; $objet; "object name"; Object_GetType($objet); "empty"; ""))
				End if 
				
			End for 
			
			// ---------------------
			// Check now form method and events declared
			// ---------------------
			
			CLEAR VARIABLE:C89($tabEvenement)
			OBJECT GET EVENTS:C1238(*; ""; $tabEvenement)  // Get events declared at structure level
			FORM UNLOAD:C1299  // Realease the form from memory (to do as soon as possible)
			
			If (Find in array:C230($tabEvenement; $EventRef)>0)
				$result.push(New object:C1471("method"; Choose:C955(Bool:C1537($tableName="{Project form}"); "{Project form}_"+$Formulare; $tableName+$Formulare); "type"; "{Method form}"; "object name"; ""; "empty"; ""))
			End if 
			
		End for 
		
	End for each 
	
	BASE_getTablesList  // Restore 
	
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
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Object Name")
					
				: ($i=3)
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Object Type")
					
				: ($i=4)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
					
			End case 
			
		End for 
		LB_setHeights($Listbox_Name; 4; 2)
		
		$FenetreInformation:="Look for event '"+Konstant_getName(2; $EventRef)+"' finished.\rFound "+String:C10($result.length)+" object(s) where the event is defined."
		displayInfo($FenetreInformation; "blue")
	Else 
		$FenetreInformation:="No event '"+Konstant_getName(2; $EventRef)+"' Found."
		displayInfo($FenetreInformation; "blue")
	End if 
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
Else 
	
	$FenetreInformation:="No event selected"
	displayInfo($FenetreInformation; "red")
End if 



