//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 27/03/19, 07:24:36
// Paramètres
// ----------------------------------------------------
// Méthode : MA_analyser
// Description
// TODO - Revoir le système de gestion liée à $Coll....

C_COLLECTION:C1488($allMethods; $Coll; $data; $paths; $pos)
C_OBJECT:C1216($method)
C_TEXT:C284($Language; $oneMethod; $onePath)
C_BOOLEAN:C305($listPresent)

ON ERR CALL:C155("BASE_GetError")

$Coll:=New collection:C1472
$list:=New list:C375
$Language:=Config_getLanguage
$sep:=":"
$listPresent:=Bool:C1537(Storage:C1525.symbols_variable.length>0)
$data:=Storage:C1525.allMethods.copy()

$pic_class:=PIC_GetPicture("images/methods/icns_class.png")
$pic_command:=PIC_GetPicture("images/methods/icns_command.png")
$pic_method:=PIC_GetPicture("images/methods/icns_method.png")
$pic_method_folder:=PIC_GetPicture("images/methods/icns_method_folder.png")
$pic_db_folder:=PIC_GetPicture("images/methods/icns_database.png")
$pic_event:=PIC_GetPicture("images/methods/icns_event.png")
$pic_form:=PIC_GetPicture("images/methods/icns_form.png")
$pic_object:=PIC_GetPicture("images/methods/icn_object.png")
$pic_table:=PIC_GetPicture("images/methods/icns_table.png")
$pic_konstant:=PIC_GetPicture("images/methods/icns_konstant.png")
$pic_plugIn:=PIC_GetPicture("images/methods/icns_plugin.png")
$pic_callees:=PIC_GetPicture("images/methods/icns_callees.png")
$pic_callers:=PIC_GetPicture("images/methods/icns_callers.png")
$pic_trigger:=PIC_GetPicture("images/methods/icns_trigger.png")

$oldRacine:=""
$racine:="-"
StorageCounter("get")

// *********************************************************************
$projectForm:=True:C214
$tableForm:=True:C214
$table:=""
$path:=""
$form:=""
If (Count parameters:C259=0)
	$subList0:=LH_updateTB(->$list; ->$pic_method_folder; "Method Analyzer")
Else 
	$subList0:=LH_updateTB(->$list; ->$pic_method_folder; "Call Chain")
End if 

$paths:=$data.distinct("path")  // asc by default. Requiered for a better presentation

For each ($onePath; $paths)
	$allMethods:=$data.query("path =:1"; $onePath).orderBy("name asc")  // requiered for a better presentation
	$oldRacine:=""
	
	For each ($method; $allMethods)
		
		TOOL_TRACE_On
		// $Coll.clear()
		$Coll:=Split string:C1554($method.name; "/")
		
		Case of 
				
			: ($Coll.length=1) & ($oldRacine#$racine)
				
				$racine:="Path project method"
				$subList99:=LH_updateTB(->$subList0; ->$pic_method_folder; $racine)
				SET LIST ITEM PARAMETER:C986($subList0; 0; "path"; "")
				SET LIST ITEM PARAMETER:C986($subList0; 0; "type"; $racine)
				SET LIST ITEM PARAMETER:C986($subList0; 0; "clicked"; "")
				
				$oldRacine:=$racine
				
			: ($Coll.length=2) & ($oldRacine#$Coll[0])
				$racine:=$Coll[0]
				
				Case of 
						
					: ($racine="[trigger]")
						$pic:=$pic_trigger
						
					: ($racine="[databaseMethod]")
						$pic:=$pic_db_folder
						
					: ($racine="[class]")
						$pic:=$pic_class
				End case 
				
				$subList99:=LH_updateTB(->$subList0; ->$pic; $racine)
				SET LIST ITEM PARAMETER:C986($subList0; 0; "path"; "")
				SET LIST ITEM PARAMETER:C986($subList0; 0; "type"; $racine)
				SET LIST ITEM PARAMETER:C986($subList0; 0; "clicked"; "")
				$oldRacine:=$racine
				
			: ($Coll.length=3) & ($oldRacine#($Coll[0]+$sep+$Coll[1]))
				
				If ($projectForm)
					//"[projectForm]")
					$racine:=$Coll[0]
					$subList10:=LH_updateTB(->$subList0; ->$pic_form; $Coll[0])
					$projectForm:=Not:C34($projectForm)
					SET LIST ITEM PARAMETER:C986($subList0; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($subList0; 0; "type"; $racine)
					SET LIST ITEM PARAMETER:C986($subList0; 0; "clicked"; "")
				End if 
				
				$racine:=$Coll[0]+$sep+$Coll[1]
				$subList99:=LH_updateTB(->$subList10; ->$pic_form; $Coll[1])
				$oldRacine:=$racine
				SET LIST ITEM PARAMETER:C986($subList10; 0; "path"; "")
				SET LIST ITEM PARAMETER:C986($subList10; 0; "type"; $racine)
				SET LIST ITEM PARAMETER:C986($subList10; 0; "clicked"; "")
				
				$oldRacine:=$racine
				
			: ($Coll.length=4) & ($oldRacine#($Coll[0]+$sep+$Coll[1]+$sep+$Coll[2]))
				//"[tableForm]")
				
				If ($tableForm)
					$racine:=$Coll[0]
					$subList10:=LH_updateTB(->$subList0; ->$pic_form; $Coll[0])
					$tableForm:=Not:C34($tableForm)
					SET LIST ITEM PARAMETER:C986($subList0; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($subList0; 0; "type"; $racine)
					SET LIST ITEM PARAMETER:C986($subList0; 0; "clicked"; "")
					
				End if 
				
				If ($table#$Coll[1])  // Table
					$table:=$Coll[1]
					$racine:=$Coll[0]+$sep+$Coll[1]
					$subList11:=LH_updateTB(->$subList10; ->$pic_table; $table)
					SET LIST ITEM PARAMETER:C986($subList10; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($subList10; 0; "type"; $racine)
					SET LIST ITEM PARAMETER:C986($subList10; 0; "clicked"; "")
					
				End if 
				
				If ($form#$Coll[2])  // Form
					$form:=$Coll[2]
					$racine:=$Coll[0]+$sep+$Coll[1]+$sep+$Coll[2]
					$subList99:=LH_updateTB(->$subList11; ->$pic_form; $Coll[2])
					SET LIST ITEM PARAMETER:C986($subList11; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($subList11; 0; "type"; $racine)
					SET LIST ITEM PARAMETER:C986($subList11; 0; "clicked"; "")
					
				End if 
				
		End case 
		
		$path:=$racine+$sep+$method.name+$sep
		$subList1:=LH_updateTB(->$subList99; ->$pic_method; $method.name)
		SET LIST ITEM PARAMETER:C986($subList99; 0; "path"; $method.name)
		SET LIST ITEM PARAMETER:C986($subList99; 0; "type"; "method")
		SET LIST ITEM PARAMETER:C986($subList99; 0; "clicked"; "-")
		
		If ($Coll.length>1)
			If (($racine="[projectForm]") | ($racine="[tableForm]")) & (Position:C15("{formMethod}"; $method.name)=0)
				SET LIST ITEM ICON:C950($subList99; 0; $pic_object)
			End if 
		End if 
		
		// ****** list of Callers & Callees methods ******
		If ($method.callees.length>0)
			
			If (Count parameters:C259=0)  // Methods explorer
				$subList2:=LH_updateTB(->$subList1; ->$pic_callees; "Callees")
				SET LIST ITEM PARAMETER:C986($subList1; 0; Additional text:K28:7; String:C10($method.callees.length))
				
				For each ($oneMethod; $method.callees)
					$subList3:=LH_updateTB(->$subList2; ->$pic_method; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; "path"; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; "clicked"; "-")
					SET LIST ITEM PARAMETER:C986($subList2; 0; "type"; "method")
				End for each 
				
			Else   // Magic Explorer
				If ($method.callees.length>0)
					
					$howMany:="call "+String:C10($method.callees.length)+" method"+("s"*Num:C11($method.callees.length>1))
					
					SET LIST ITEM PARAMETER:C986($subList99; 0; Additional text:K28:7; $howMany)
					SET LIST ITEM PARAMETER:C986($subList99; 0; "clicked"; "+")
					
					For each ($oneMethod; $method.callees)
						$subList3:=LH_updateTB(->$subList1; ->$pic_method; $oneMethod)
						SET LIST ITEM PARAMETER:C986($subList99; 0; Additional text:K28:7; $howMany)
						SET LIST ITEM PARAMETER:C986($subList1; 0; "path"; $oneMethod)
						SET LIST ITEM PARAMETER:C986($subList1; 0; "clicked"; "-")
						SET LIST ITEM PARAMETER:C986($subList1; 0; "type"; "method")
						
						$pos:=$data.indices("name =:1"; $oneMethod)
						If ($pos#Null:C1517)
							If ($data[$pos[0]].callees.length>0)
								SET LIST ITEM PARAMETER:C986($subList1; 0; Additional text:K28:7; "call "+String:C10($data[$pos[0]].callees.length)+" method"+("s"*Num:C11($data[$pos[0]].callees.length>1)))
							End if 
						End if 
						
					End for each 
				End if 
				
			End if 
			
		End if 
		
		If (Count parameters:C259=0)
			
			If ($method.callers.length>0)
				
				$subList2:=LH_updateTB(->$subList1; ->$pic_callers; "Callers")
				SET LIST ITEM PARAMETER:C986($subList1; 0; Additional text:K28:7; String:C10($method.callers.length))
				For each ($oneMethod; $method.callers)
					$subList3:=LH_updateTB(->$subList2; ->$pic_method; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; "path"; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; "clicked"; "-")
					SET LIST ITEM PARAMETER:C986($subList2; 0; "type"; "method")
					
				End for each 
			End if 
			
			If ($method.commandUsed.length>0)
				$subList2:=LH_updateTB(->$subList1; ->$pic_command; "Command used")
				SET LIST ITEM PARAMETER:C986($subList1; 0; Additional text:K28:7; String:C10($method.commandUsed.length))
				For each ($oneMethod; $method.commandUsed)
					$subList3:=LH_updateTB(->$subList2; ->$pic_command; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; "path"; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; "clicked"; "-")
					SET LIST ITEM PARAMETER:C986($subList2; 0; "type"; "method")
					
				End for each 
			End if 
			
			// ****** list of konstants ******
			If ($method.constantUsed.length>0)
				$subList2:=LH_updateTB(->$subList1; ->$pic_konstant; "Constant used")
				SET LIST ITEM PARAMETER:C986($subList1; 0; Additional text:K28:7; String:C10($method.constantUsed.length))
				$i:=0
				For each ($oneMethod; $method.constantUsed)
					$subList3:=LH_updateTB(->$subList2; ->$pic_konstant; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; Additional text:K28:7; $method.constantToken[$i])
					$i:=$i+1
				End for each 
				
			End if 
			
			// ****** list of plugIn ******
			If ($method.pluginUsed.length>0)
				$subList2:=LH_updateTB(->$subList1; ->$pic_plugin; "Plugin used")
				SET LIST ITEM PARAMETER:C986($subList1; 0; Additional text:K28:7; String:C10($method.pluginUsed.length))
				$i:=0
				For each ($oneMethod; $method.pluginUsed)
					$subList11:=LH_updateTB(->$subList2; ->$pic_plugin; $oneMethod)
					SET LIST ITEM PARAMETER:C986($subList2; 0; Additional text:K28:7; $method.pluginToken[$i])
					$i:=$i+1
				End for each 
				
			End if 
			
			// *** Add the Submenus which will be populated only when user when requested **
			If ($listPresent) & ($racine="Path project method")
				$subList2:=LH_updateTB(->$subList1; ->$pic_event; "Syntax")
				SET LIST ITEM PARAMETER:C986($subList1; 0; "type"; "syntax")
				SET LIST ITEM PARAMETER:C986($subList1; 0; "clicked"; "-")
				SET LIST ITEM PARAMETER:C986($subList1; 0; "path"; $method.name)
			End if 
			
			$subList2:=LH_updateTB(->$subList1; ->$pic_event; "Local variables")
			SET LIST ITEM PARAMETER:C986($subList1; 0; "clicked"; "-")
			SET LIST ITEM PARAMETER:C986($subList1; 0; "type"; "variable")
			SET LIST ITEM PARAMETER:C986($subList1; 0; "path"; $method.name)
			
			$subList2:=LH_updateTB(->$subList1; ->$pic_event; "Method's analysis")
			SET LIST ITEM PARAMETER:C986($subList1; 0; "clicked"; "-")
			SET LIST ITEM PARAMETER:C986($subList1; 0; "type"; "analysis")
			SET LIST ITEM PARAMETER:C986($subList1; 0; "path"; $method.name)
			
			SET LIST ITEM PARAMETER:C986($subList2; 0; Additional text:K28:7; String:C10($method.commandUsed.length))
		End if 
		
	End for each 
End for each 
$Coll.clear()
SORT LIST:C391($list)

// End ->  Save data on the FORM information
Form:C1466.LH:=Copy list:C626($list)
CLEAR LIST:C377($list; *)

If (Not:C34($listPresent)) & (Count parameters:C259=0)
	$txt:="Information is more accurate with a compilation done and 'Symbols file' creation enabled (see structure property preference tab)."
	displayInfo($txt; "red")
End if 
StorageCounter("set")