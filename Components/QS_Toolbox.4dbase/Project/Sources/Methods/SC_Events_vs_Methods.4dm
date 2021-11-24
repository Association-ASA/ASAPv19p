//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 09/11/16, 19:11:51
// ----------------------------------------------------
// méthode : SC_Events_vs_Methods
// description
// checks all objects to find Event defined and not managed
// inpsired from Event_hdl from VDL
//
// paramètres
// ----------------------------------------------------

C_LONGINT:C283($tableID)
C_LONGINT:C283($Lon_x)
C_TEXT:C284($tableName)
C_TEXT:C284($Txt_event; $methodCode)
ARRAY TEXT:C222($tabPaths; 0x0000)
ARRAY TEXT:C222($tabObjects; 0x0000)
ARRAY POINTER:C280($tabPtrVariables; 0x0000)
ARRAY LONGINT:C221($tabPtrPagesNumber; 0x0000)
ARRAY LONGINT:C221($tabEvents; 0x0000)
ARRAY TEXT:C222($tabForms; 0x0000)
C_COLLECTION:C1488($MyColl; $j; $currentObjectllkonstants; $result; $data)
C_OBJECT:C1216($table)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$MyColl:=New collection:C1472
$j:=New collection:C1472
$currentObjectllkonstants:=New collection:C1472
$result:=New collection:C1472
BASE_getTablesList(True:C214)
$data:=Storage:C1525.allMethods

For each ($table; Storage:C1525.structureTable)
	
	$tableID:=$table.id
	If ($tableID>0)
		FORM GET NAMES:C1167(Table:C252($tableID)->; $tabForms; *)
	Else 
		FORM GET NAMES:C1167($tabForms; *)
	End if 
	
	$tableName:=Str_GetTableOrProjectForm($tableID)
	
	For ($sale; 1; Size of array:C274($tabForms))  // For each form
		
		$currentForm:=$tabForms{$sale}
		
		// ---------------------
		// Objects form analysis
		// ---------------------
		
		// Get all objects and methods associated
		FE_getObjectsAndMethods($tableID; $currentForm; ->$tabObjects; ->$tabPtrVariables; ->$tabPtrPagesNumber; ->$tabPaths)
		
		For ($currentObject; 1; Size of array:C274($tabObjects))
			
			$typeObject:=Object_GetType($tabObjects{$currentObject})
			$page:=String:C10($tabPtrPagesNumber{$currentObject})
			OBJECT GET EVENTS:C1238(*; $tabObjects{$currentObject}; $tabEvents)  // get  assigned events
			
			// -----------------------------
			// Workaround of ACI0096019
			
			If ($typeObject="@button@") | ($typeObject="@checkbox") | ($typeObject="tab control") | ($typeObject="splitter")
				$Lon_x:=Find in array:C230($tabEvents; 19)  // plug-In area
				
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
				
				$Lon_x:=Find in array:C230($tabEvents; 20)
				
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
			End if 
			
			If ($typeObject="@picture@") | ($typeObject="@rule@") | ($typeObject="@dropdown list") | ($typeObject="text input")
				$Lon_x:=Find in array:C230($tabEvents; 19)  // plug-In area
				
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
			End if 
			
			If ($typeObject="static@")
				$Lon_x:=Find in array:C230($tabEvents; 2)  // on Unload
				
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
			End if 
			
			If ($typeObject="list@")
				
				$Lon_x:=Find in array:C230($tabEvents; 5)  // header
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
				
				$Lon_x:=Find in array:C230($tabEvents; 8)  // display detail
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
				
				$Lon_x:=Find in array:C230($tabEvents; 19)  // plug-In area
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
				
				$Lon_x:=Find in array:C230($tabEvents; 6)  // printing break
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
				
				$Lon_x:=Find in array:C230($tabEvents; 7)  // printing footer
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
				
				$Lon_x:=Find in array:C230($tabEvents; 23)  // printing detail
				If ($Lon_x>0)
					DELETE FROM ARRAY:C228($tabEvents; $Lon_x)
				End if 
			End if 
			
			// ---------------------------------
			
			If (Size of array:C274($tabEvents)>0)  // There is at least one event still checked
				
				For ($sucre; 1; Size of array:C274($tabPaths))
					
					$path:=$tabPaths{$sucre}
					$L:=Length:C16($path)
					$before:=$L-1
					$until:=$L
					
					While (Substring:C12($path; $before; 1)#"/")
						$until:=$before
						$before:=$before-1
					End while 
					
					$MethodSansChemin:=Substring:C12($path; $until)
					
					If ($MethodSansChemin=$tabObjects{$currentObject})  // This is the object method
						
						$j:=$data.indices("name = :1"; $tabPaths{$sucre})
						If ($j.length>0)
							
							$methodCode:=$data[$j[0]].code
							$currentObjectllkonstants:=$data[$j[0]].constantToken
							$count:=0
							
							For each ($token; $currentObjectllkonstants)
								
								If ($token=":K2:@")  // It is a konstant from 'form event' management
									$eventNumber:=Num:C11(Replace string:C233($token; ":K2:"; ""))
									
									If (Find in array:C230($tabEvents; $eventNumber)=-1)
										$Txt_event:="Unknown/User event '"+$data[$j[0]].constantUsed[$count]+"'"
										$result.push(New object:C1471("method"; $tableName+$currentForm; "page"; $page; "object type"; $typeObject; "object"; $tabObjects{$currentObject}; "event"; $Txt_event))
									End if 
								End if 
								$count:=$count+1
							End for each 
						End if 
					End if 
				End for 
			End if 
		End for 
		
		// ---------------------
		// Project form analysis
		// ---------------------
		
		$Lon_x:=Find in array:C230($tabPaths; "@{formMethod}")  // Should be 1 if present
		
		If ($Lon_x>0)
			OBJECT GET EVENTS:C1238(*; ""; $tabEvents)  // get events from Form
			
			$RealEvent:=""
			$Event:=""
			
			$j:=$data.indices("name = :1"; $tabPaths{$Lon_x})
			If ($j.length>0)
				
				$methodCode:=$data[$j[0]].code
				$currentObjectllkonstants:=$data[$j[0]].constantToken
				$count:=0
				
				For each ($token; $currentObjectllkonstants)
					
					If ($token=":K2:@")  // It is a konstant from 'form event' management
						$eventNumber:=Num:C11(Replace string:C233($token; ":K2:"; ""))
						
						If (Find in array:C230($tabEvents; $eventNumber)=-1)
							$Txt_event:="Unknown/User event '"+$data[$j[0]].constantUsed[$count]+"'"
							$result.push(New object:C1471("method"; $tableName+$currentForm; "page"; $page; "object type"; $typeObject; "object"; ""; "event"; $Txt_event))
						End if 
					End if 
					$count:=$count+1
				End for each 
			End if 
			
		End if 
		
		FORM UNLOAD:C1299  // No need the form in memory anymore
		
	End for 
End for each 

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table\\Object")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 250)
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 90)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				
			: ($i=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 120)
				
			: ($i=4)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 120)
				
			: ($i=5)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 3; 1)
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$txt:=String:C10($result.length)+" events flags with no management into object/form method."
	displayInfo($txt; "red")
	
Else 
	displayInfo("Search returns no result.")
End if 