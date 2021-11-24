C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		Form:C1466.result:=New collection:C1472
		Form:C1466.callAgain:=New collection:C1472
		Form:C1466.resultCopy:=New collection:C1472
		Form:C1466.menu:=New collection:C1472
		Form:C1466.method:=New collection:C1472
		Form:C1466.objectName:=""
		Form:C1466.column:=""
		Form:C1466.menuSelected:=""
		Form:C1466.buttonsDisplayed:=False:C215
		
	: ($evt=On Clicked:K2:4)
		C_TEXT:C284($object)
		C_LONGINT:C283($n)
		$object:=FORM Event:C1606.objectName
		
		Case of 
				
			: ($object="_@")
				
				Case of 
					: ($object="_displayCollections")
						Form:C1466.menu.clear()
						Form:C1466.menu.push(New object:C1471("menu";"4D Commands";"pict";"#images/bevels/btn_4Dcommands.png";"method";"displayCollections"))  // Storage.commands4d
						Form:C1466.menu.push(New object:C1471("menu";"Symbols variables";"pict";"#images/bevels/btn_directory_listing.png";"method";"displayCollections"))  // Storage.symbols_variable
						Form:C1466.menu.push(New object:C1471("menu";"All Methods";"pict";"#images/bevels/btn_method.png";"method";"displayCollections"))  // storage.allMethods
						Form:C1466.menu.push(New object:C1471("menu";"Plugins";"pict";"#images/bevels/btn_plugin.png";"method";"displayCollections"))  // storage.plugIn
						
						Form:C1466.menu.push(New object:C1471("menu";"Components Methods";"pict";"#images/bevels/btn_component.png";"method";"displayCollections"))  // Storage.componantsMethods
						Form:C1466.menu.push(New object:C1471("menu";"Constants";"pict";"#images/bevels/btn_konstants.png";"method";"displayCollections"))  // Storage.constants
						Form:C1466.menu.push(New object:C1471("menu";"Objects type";"pict";"#images/bevels/btn_objects_all.png";"method";"displayCollections"))  // Storage.objectType
						Form:C1466.menu.push(New object:C1471("menu";"Structure tables";"pict";"#images/bevels/btn_structure.png";"method";"displayCollections"))  // Storage.structureTable
						Form:C1466.menu.push(New object:C1471("menu";"System keywords";"pict";"#images/bevels/btn_keywords.png";"method";"displayCollections"))  // Storage.systemKeywords
						
						Form:C1466.menu.push(New object:C1471("menu";"VCS";"pict";"#images/bevels/btn_vcs.png";"method";"displayCollections"))  // VCS table
						Form:C1466.menu.push(New object:C1471("menu";"Licence";"pict";"#images/bevels/btn_license.png";"method";"displayCollections"))  // Licence table
						Form:C1466.menu.push(New object:C1471("menu";"Setup";"pict";"#images/bevels/btn_setup.png";"method";"displayCollections"))  // Setup table
						Form:C1466.menu.push(New object:C1471("menu";"Debug";"pict";"#images/bevels/btn_debug.png";"method";"displayCollections"))  // Debug
						Form:C1466.menu.push(New object:C1471("menu";"Error";"pict";"#images/bevels/btn_errors.png";"method";"displayCollections"))  // Error
						Form:C1466.menu.push(New object:C1471("menu";"DB ana";"pict";"#images/bevels/btn_storage.png";"method";"displayCollections"))  // bdAnalysis
						
						Form:C1466.menu.push(New object:C1471("menu";"Conversion";"pict";"#images/bevels/btn_conversion_log.png";"method";"displayCollections"))  // Conversion
						Form:C1466.menu.push(New object:C1471("menu";"Folders";"pict";"#images/bevels/btn_conversion_log.png";"method";"displayCollections"))  // Conversion
						
						  // Now hide unused buttons and update icon
						$step:=43
						Form:C1466.method.clear()
						$n:=Form:C1466.menu.length
						
						If (Not:C34(Form:C1466.buttonsDisplayed))
							
							For ($a;1;$n)
								If ($a>1)
									OBJECT DUPLICATE:C1111(*;"_btn1")
									$switch:=$step*($a-1)
									OBJECT MOVE:C664(*;"_btn"+String:C10($a);$switch;0)
								End if 
								
								OBJECT SET VISIBLE:C603(*;"_btn"+String:C10($a);True:C214)
								OBJECT SET HELP TIP:C1181(*;"_btn"+String:C10($a);Form:C1466.menu[$a-1].menu)
								OBJECT SET FORMAT:C236(*;"_btn"+String:C10($a);";"+Form:C1466.menu[$a-1].pict+";1;;1")
								Form:C1466.method.push(Form:C1466.menu[$a-1].method)  // To get the method to execute based on button name (and number of it)
							End for 
						End if 
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"txtMenu"))->:=$object
						Form:C1466.menuSelected:=$object
						Form:C1466.buttonsDisplayed:=True:C214
						
						
					: ($object="_btn@")
						TOOL_executeMethod 
						
						If (Form:C1466.result.length>0)
							ARRAY TEXT:C222($tabPropertyNames;0x0000)
							OB GET PROPERTY NAMES:C1232(Form:C1466.result[0];$tabPropertyNames)
							Form:C1466.column:=$tabPropertyNames{1}
							SearchPicker SET HELP TEXT ("Search";Form:C1466.column)
							$txt:=String:C10(Form:C1466.result.length)+" rows x "+String:C10(Size of array:C274($tabPropertyNames))+" columns"
							(OBJECT Get pointer:C1124(Object named:K67:5;"txtMenu"))->:=Form:C1466.menuSelected+": "+Form:C1466.menu[Num:C11($object)-1].menu+" ("+$txt+")."
							CALL FORM:C1391(Current form window:C827;"CF_setMagic";False:C215)
							
						Else 
							CALL FORM:C1391(Current form window:C827;"CF_setMagic";True:C214)
						End if 
						
				End case 
				
				
			: ($object="bt_settings")
				C_COLLECTION:C1488($col)
				$col:=New collection:C1472
				
				$col.push("Export Picture Library")
				$col.push("-")
				$col.push("Open CSM")
				$col.push("Open Application properties")
				$col.push("-")
				$col.push("Compact Data file")
				$referenceLigne:=Pop up menu:C542($col.join(";"))
				
				Case of 
						
					: ($referenceLigne=1)
						OTHERS_PictureLibraryExport 
						
					: ($referenceLigne=3)
						OPEN SECURITY CENTER:C1018
						
					: ($referenceLigne=4)
						OPEN SETTINGS WINDOW:C903("/")
						
					: ($referenceLigne=6)
						TOOLS_CompactDB 
				End case 
				
			: ($object="Redo")
				C_LONGINT:C283($menuSelected)
				$menuSelected:=Pop up menu:C542(Char:C90(1)+Form:C1466.callAgain.extract("title").join(";"))
				
				If ($menuSelected>0)
					$Method:=Form:C1466.callAgain[$menuSelected-1].method
					EXECUTE METHOD:C1007($Method;*)
				End if 
				
			: ($object="copyCheck")
				If (Form:C1466.result.length>0)
					CALL WORKER:C1389("QST_job";"lb_collectionToPasteboard";Form:C1466.result)
					displayInfo ("Export will be done sooner and ready to be pasted.")
				Else 
					ALERT:C41("Nothing to copy.")
				End if 
				
			: ($object="killLicence")
				C_TEXT:C284($Number)
				C_OBJECT:C1216($QS_licence)
				
				$QS_licence:=Storage:C1525.licence.licence
				$Number:=$QS_licence.key
				CONFIRM:C162("Do you really want to delete all Licence information regarding the following licence number:"+$Number+"?")
				If (OK=1)
					SET TEXT TO PASTEBOARD:C523($Number)
					ALERT:C41("Licence number copy in Pasteboard by security ;-)")
					key_startFromScratch 
				End if 
				
				
				
		End case 
		
		
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		
		CANCEL:C270
		
End case 