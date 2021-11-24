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
		Form:C1466.nbButton:=11  // To update if a button is added 
		
	: ($evt=On Clicked:K2:4)
		C_TEXT:C284($object)
		C_BOOLEAN:C305($isFine)
		C_LONGINT:C283($n)
		$object:=FORM Event:C1606.objectName
		
		Case of 
				
			: ($object="_@")
				Form:C1466.menu.clear()
				
				Case of 
					: ($object="_Check")
						Form:C1466.menu.push(New object:C1471("menu";"Commands, open-close couple";"pict";"#images/bevels/btn_balanced.png";"method";"SC_list_OpenClosureCommand"))
						Form:C1466.menu.push(New object:C1471("menu";"Sets, name declaration";"pict";"#images/bevels/btn_drawer_open.png";"method";"SC_checkSetName"))
						Form:C1466.menu.push(New object:C1471("menu";"Tables & fields & Methods, name";"pict";"#images/bevels/btn_label.png";"method";"SC_DB_checkName"))
						
					: ($object="_SearchFor")
						Form:C1466.menu.push(New object:C1471("menu";"4D Server improvement";"pict";"#images/bevels/btn_4d_server.png";"method";"SC_4DServer_Optimizer"))
						Form:C1466.menu.push(New object:C1471("menu";"Comment parts";"pict";"#images/bevels/btn_comments_parts.png";"method";"SC_search_If_False"))
						Form:C1466.menu.push(New object:C1471("menu";"Deprecated command";"pict";"#images/bevels/btn_deprecated.png";"method";"SC_deprecatedCommand"))
						Form:C1466.menu.push(New object:C1471("menu";"Event";"pict";"#images/bevels/btn_events_code.png";"method";"SC_lookAtEvents"))
						Form:C1466.menu.push(New object:C1471("menu";"Format definition";"pict";"#images/bevels/btn_format.png";"method";"SC_lookAtFormat"))
						Form:C1466.menu.push(New object:C1471("menu";"Specific object type";"pict";"#images/bevels/btn_objects.png";"method";"SC_lookAtObjectType"))
						Form:C1466.menu.push(New object:C1471("menu";"Search for GDPR or RGPD keyword";"pict";"#images/bevels/btn_gdpr.png";"method";"SC_GDPR"))
						Form:C1466.menu.push(New object:C1471("menu";"Pictures referenced from library";"pict";"#images/bevels/btn_pictures.png";"method";"SC_pictureFrom4DLibrary"))
						Form:C1466.menu.push(New object:C1471("menu";"Subform";"pict";"#images/bevels/btn_subForm.png";"method";"SC_findSubformByName"))
						Form:C1466.menu.push(New object:C1471("menu";"Variables (process & interprocess)";"pict";"#images/bevels/btn_variable.png";"method";"SC_displayVariables"))
						
					: ($object="_Tips")
						Form:C1466.menu.push(New object:C1471("menu";"Get system configuration";"pict";"#images/bevels/btn_system_monitor.png";"method";"SC_get_Configuration"))
						Form:C1466.menu.push(New object:C1471("menu";"Parse code";"pict";"#images/bevels/btn_source_code.png";"method";"SC_TIPSFromDoc"))
						Form:C1466.menu.push(New object:C1471("menu";"Show all";"pict";"#images/bevels/btn_show_all.png";"method";"SC_displayTIPS"))
						
					: ($object="_AnalyseOf")
						Form:C1466.menu.push(New object:C1471("menu";"Events vs Methods";"pict";"#images/bevels/btn_events_code.png";"method";"SC_Events_vs_Methods"))
						Form:C1466.menu.push(New object:C1471("menu";"Variables usage vs declaration";"pict";"#images/bevels/btn_variable.png";"method";"SC_checkDeclrVariables"))
						
					: ($object="_ListOf")
						Form:C1466.menu.push(New object:C1471("menu";"all objects";"pict";"#images/bevels/btn_objects_all.png";"method";"SC_listAllObjects"))
						Form:C1466.menu.push(New object:C1471("menu";"Database parameters";"pict";"#images/bevels/btn_database_params.png";"method";"SC_get_DB_Parameters"))
						Form:C1466.menu.push(New object:C1471("menu";"Web Server information";"pict";"#images/bevels/btn_world.png";"method";"SC_getWebServerInformation"))
						Form:C1466.menu.push(New object:C1471("menu";"Web options";"pict";"#images/bevels/btn_web_settings.png";"method";"SC_getWebOptions"))
						
					: ($object="_GetInfo")
						Form:C1466.menu.push(New object:C1471("menu";"Index list";"pict";"#images/bevels/btn_indexes.png";"method";"SC_list_Index"))
						Form:C1466.menu.push(New object:C1471("menu";"Primary key";"pict";"#images/bevels/btn_primary_key.png";"method";"SC_list_Relations"))
						Form:C1466.menu.push(New object:C1471("menu";"Style sheets";"pict";"#images/bevels/btn_styles_sheet.png";"method";"SC_list_styleSheets"))
						Form:C1466.menu.push(New object:C1471("menu";"Plugin list";"pict";"#images/bevels/btn_plugin.png";"method";"SC_list_PlugIns"))
						Form:C1466.menu.push(New object:C1471("menu";"Component list";"pict";"#images/bevels/btn_component.png";"method";"SC_list_Components"))
						Form:C1466.menu.push(New object:C1471("menu";"System format";"pict";"#images/bevels/btn_system_format.png";"method";"SC_list_systemFormat"))
						Form:C1466.menu.push(New object:C1471("menu";"External IP address";"pict";"#images/bevels/btn_ip.png";"method";"SC_show_IP"))
						Form:C1466.menu.push(New object:C1471("menu";"Licence information";"pict";"#images/bevels/btn_license.png";"method";"SC_get_licenceInfos"))
						Form:C1466.menu.push(New object:C1471("menu";"Application path";"pict";"#images/bevels/btn_structure_file.png";"method";"SC_show_applicationPath"))
						Form:C1466.menu.push(New object:C1471("menu";"Data file path";"pict";"#images/bevels/btn_database_file.png";"method";"SC_show_DatafilePath"))
						Form:C1466.menu.push(New object:C1471("menu";"Project Conversion logs";"pict";"#images/bevels/btn_conversion_log.png";"method";"SC_conversionLogs"))
				End case 
				
				  // Now hide unused buttons and update icon
				Form:C1466.method.clear()
				$n:=Form:C1466.menu.length
				
				For ($a;1;Form:C1466.nbButton)
					$isFine:=$a<=$n
					OBJECT SET VISIBLE:C603(*;"btn"+String:C10($a);$isFine)
					
					If ($isFine)
						OBJECT SET HELP TIP:C1181(*;"btn"+String:C10($a);Form:C1466.menu[$a-1].menu)
						OBJECT SET FORMAT:C236(*;"btn"+String:C10($a);";"+Form:C1466.menu[$a-1].pict+";1;;1")
						Form:C1466.method.push(Form:C1466.menu[$a-1].method)  // To get the method to execute based on button name (and number of it)
					End if 
				End for 
				(OBJECT Get pointer:C1124(Object named:K67:5;"txtMenu"))->:=$object
				Form:C1466.menuSelected:=$object
				
			: ($object="btn@")
				TOOL_executeMethod 
				Form:C1466.objectName:=""
				(OBJECT Get pointer:C1124(Object named:K67:5;"Search"))->:=""
				(OBJECT Get pointer:C1124(Object named:K67:5;"txtMenu"))->:=Form:C1466.menuSelected+": "+Form:C1466.menu[Num:C11($object)-1].menu+Choose:C955(Form:C1466.result.length>0;" ("+String:C10(Form:C1466.result.length)+").";"")
				
				If (Form:C1466.result.length>0)
					ARRAY TEXT:C222($tabPropertyNames;0x0000)
					OB GET PROPERTY NAMES:C1232(Form:C1466.result[0];$tabPropertyNames)
					Form:C1466.column:=$tabPropertyNames{1}
					SearchPicker SET HELP TEXT ("Search";Form:C1466.column)
					CALL FORM:C1391(Current form window:C827;"CF_setMagic";False:C215)
				Else 
					CALL FORM:C1391(Current form window:C827;"CF_setMagic";True:C214)
				End if 
				
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
				
				
			: ($object="redo")
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
				
		End case 
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		
		CANCEL:C270
		
End case 