
C_LONGINT:C283($evt)
C_OBJECT:C1216($formEvent)
C_TEXT:C284($object; $old)

$evt:=Form event code:C388
$formEvent:=FORM Event:C1606
If (OB Is defined:C1231($formEvent; "objectName"))
	$object:=$formEvent.objectName
End if 

Case of 
	: ($evt=On Load:K2:1)
		C_OBJECT:C1216($qs_data)
		$qs_data:=Storage:C1525.QS_TBX_SHARED_DATA
		Form:C1466.modified:=New collection:C1472  // use on screen page 1
		Form:C1466.exported:=New collection:C1472  // use on screen page 1
		Form:C1466.exportList:=New collection:C1472  // use on screen page 1
		Form:C1466.toExport:=New collection:C1472  // List of method to export
		Form:C1466.allVersion:=New collection:C1472  // use on screen page 3
		Form:C1466.allVersionTemp:=New collection:C1472  // use on screen page 3
		Form:C1466.allProjects:=New collection:C1472  // use on screen page 4
		Form:C1466.oldVersion:=""
		Form:C1466.currentVersion:=""
		Form:C1466.currentProject:=$qs_data.QS_TBX_DBName
		Form:C1466.VCS_QS_TBX_DBName:=Form:C1466.currentProject
		Use ($qs_data)
			$qs_data.VCS_QS_TBX_DBName:=Form:C1466.currentProject
		End use 
		
		OBJECT SET VISIBLE:C603(*; "btnGoPage1"; (FORM Get current page:C276#1))
		$FenetreInformation:="Reading project methods information - please wait few seconds."
		displayInfo($FenetreInformation)
		
		OBJECT SET ENABLED:C1123(*; "@_lb"; False:C215)
		OBJECT SET ENABLED:C1123(*; "allExport-Projects"; False:C215)
		OBJECT SET ENABLED:C1123(*; "allExports_1project"; False:C215)
		
		WA SET PREFERENCE:C1041(*; "Compare_VCS"; WA enable Web inspector:K62:7; True:C214)
		//$pathSep:=Folder separator
		//WA OPEN URL(*;"Compare_VCS";Get 4D folder(Current resources folder)+"codemirror"+$pathSep+"compare4D"+$pathSep+"compare4d.html")
		$file:=File:C1566("/RESOURCES/codemirror/compare4D/compare4d.html").platformPath
		WA OPEN URL:C1020(*; "Compare_VCS"; $file)
		
		SearchPicker SET HELP TEXT("searchInAllMethods"; "Method path to search")
		
		SET TIMER:C645(1)  // Immediate call
		
		// ********************************************************************************************************************************
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)
		CALL FORM:C1391(Current form window:C827; "VCS_Refresh")
		
		// ********************************************************************************************************************************
		
	: ($evt=On Mouse Enter:K2:33)
		
		$txt:=""
		Case of 
				
			: ($object="BtnCopyToPasteboard")
				$txt:="Set previous code into the pasteboard"
				
			: ($object="BtnRecordNewChanges")
				$txt:="Create a new Stamp Point"
				
			: ($object="BtnCompare")
				$txt:="Compare method versions"
				
			: ($object="BtnAllVersions")
				$txt:="Display all method versions"
				
			: ($object="btnAllProjects")
				$txt:="Display all projects saved"
				
			: ($object="BtnReturnPage1")
				$txt:="Return to main page"
				
		End case 
		
		If ($txt#"")
			OBJECT SET HELP TIP:C1181(*; $object; $txt)
		End if 
		
		// ********************************************************************************************************************************
		
	: ($evt=On Clicked:K2:4) | ($evt=On Data Change:K2:15)
		
		If (Right click:C712)
			// #TODO
			//Case of 
			//: ($object="Exports_lb") | ($object="allExport-Projects")
			//C_COLLECTION($col)
			//$col:=New collection("Merge 2 exports";"Delete the current export")
			//$merge:=Pop up menu($col.join(";"))
			//$col:=Form.exportListSelected
			//$QS_VCS_COMP_DB_PATH:=Storage.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
			//$QS_TBX_DBName:=Storage.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName
			
			//Case of 
			//: ($merge=1)
			
			//If ($col.length>1)
			
			//Case of 
			//  // **************** Merge 2 rows with a same uniqueID (bug) **************
			
			//: ($col.length=2) & ($col[0].uniqueID=$col[1].uniqueID)
			//  // Need to delete one entry from the SQL database
			
			//$time:=$col[0].uniqueID
			//$today:=Date($col[0].timeStamp)
			
			//Begin SQL
			//USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
			
			//DELETE FROM EXPORTS
			//WHERE  EXP_APPLICATION = :[$QS_TBX_DBName] and EXP_CODE = :[$time];
			
			//INSERT INTO EXPORTS
			//(EXP_CODE, EXP_DATE, EXP_APPLICATION)
			//VALUES
			//(:[$time], :[$today], :[$QS_TBX_DBName]);
			
			//USE DATABASE SQL_INTERNAL;
			
			//End SQL
			
			//  // **************** Merge 2 rows with a # uniqueID **************
			
			//: ($col.length=2) & ($col[0].uniqueID#$col[1].uniqueID)
			
			//C_TEXT($maxID)
			//C_COLLECTION($pos)
			
			//$maxID:=$col.max("uniqueID")
			//$pos:=$col.indices("uniqueID =:1";$maxID)
			//$col:=$col.remove($pos[0])
			
			//$time:=$col[0].uniqueID
			//$today:=Date($col[0].timeStamp)
			
			//Begin SQL
			//USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
			
			//DELETE FROM EXPORTS
			//WHERE  EXP_APPLICATION = :[$QS_TBX_DBName] and EXP_CODE = :[$time];
			
			//INSERT INTO EXPORTS
			//(EXP_CODE, EXP_DATE, EXP_APPLICATION)
			//VALUES
			//(:[$maxID], :[$today], :[$QS_TBX_DBName]);
			
			//USE DATABASE SQL_INTERNAL;
			
			//End SQL
			
			
			//End case 
			//CALL FORM(Current form window;"VCS_Refresh")
			
			//Else 
			
			//ALERT("You need to select 2 rows.")
			//End if 
			
			//  // **************** Delete a row **************
			//: ($merge=2)
			//If ($col.length=1)
			
			//CONFIRM("This operation is not reversible.";"Oups";"Yes, I want to delete this")
			//If (OK=0)
			//$time:=$col[0].uniqueID
			//$today:=Date($col[0].timeStamp)
			
			//Begin SQL
			//USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
			
			//DELETE FROM EXPORTS
			//WHERE  EXP_APPLICATION = :[$QS_TBX_DBName] and EXP_CODE = :[$time];
			
			//DELETE FROM VCS
			//WHERE  VCS_APPLICATION = :[$QS_TBX_DBName] and VCS_TIMESTAMP = :[$time] and VCS_DATE = :[$today];
			
			//USE DATABASE SQL_INTERNAL;
			
			//End SQL
			//End if 
			
			//Else 
			//ALERT("To avoid any error, please select only 1 export to delete.")
			
			//End if 
			
			//End case 
			//SET TIMER(-1)
			
			//End case 
		End if 
		
		Case of 
				
			: ($object="BtnCopyToPasteboard")
				If (Form:C1466.oldVersion#"")
					SET TEXT TO PASTEBOARD:C523(Form:C1466.oldVersion)
				Else 
					ALERT:C41("No previous code to get. Select first a method inside the list.")
				End if 
				
			: ($object="BtnRecordNewChanges")
				VCS_recordNewChanges
				
			: ($object="BtnCompare")
				VCS_Compare
				
			: ($object="BtnAllVersions")
				VCS_DisplayAllVersions
				
			: ($object="btnAllProjects")
				VCS_ManageAllProjects
				
			: ($object="BtnReturnPage1")
				FORM GOTO PAGE:C247(1)
				
			: ($object="Modified_lb")
				If (Form:C1466.modifiedCurrent#Null:C1517)
					VCS_FindPrevious_Version(Form:C1466.modifiedCurrent.path)
					VCS_Compare
				End if 
				
			: ($object="Exports_lb")
				If (Form:C1466.exportListCurrent#Null:C1517)
					VCS_List_All_Exported(Form:C1466.exportListCurrent.uniqueID)
					LISTBOX SELECT ROW:C912(*; "Exported_lb"; 0; lk remove from selection:K53:3)
					LISTBOX SELECT ROW:C912(*; "Modified_lb"; 0; lk remove from selection:K53:3)
				End if 
				
			: ($object="Exported_lb")
				
				LISTBOX SELECT ROW:C912(*; "Modified_lb"; 0; lk remove from selection:K53:3)
				If (Form:C1466.exportedCurrent#Null:C1517)
					Form:C1466.oldPath:=Form:C1466.exportedCurrent.path
					Form:C1466.oldVersion:=VCS_UpdateOldVersion(Form:C1466.exportedCurrent.timeStamp; Form:C1466.oldPath)
					
					$FenetreInformation:=Form:C1466.oldPath+" selected. Double clic to set the previous code into the pasteboard."
					displayInfo($FenetreInformation)
				End if 
				
			: ($object="AllVersion_lb")
				VCS_allVersions_lb
				
			: ($object="Projects_LB")
				Form:C1466.exportList.clear()
				Form:C1466.exported.clear()
				
				If (Form:C1466.allProjectsCurrent#Null:C1517)
					Use (Storage:C1525)
						Use (Storage:C1525.QS_TBX_SHARED_DATA)
							Storage:C1525.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName:=Form:C1466.allProjectsCurrent.project
						End use 
					End use 
					Form:C1466.exportList:=VCS_ListExports
					
				End if 
				
			: ($object="allExport-Projects")
				If (Form:C1466.exportListCurrent#Null:C1517)
					VCS_List_All_Exported(Form:C1466.exportListCurrent.uniqueID)
					Form:C1466.allVersionTemp:=Form:C1466.exported.copy()
					LISTBOX SELECT ROW:C912(*; "Exported_lb"; 0; lk remove from selection:K53:3)
					LISTBOX SELECT ROW:C912(*; "Modified_lb"; 0; lk remove from selection:K53:3)
				End if 
				
			: ($object="allExports_1project")
				C_TEXT:C284($currentVersion)
				If (Form:C1466.exportedCurrent#Null:C1517)
					
					LISTBOX SELECT ROW:C912(*; "Modified_lb"; 0; lk remove from selection:K53:3)
					Form:C1466.oldPath:=Form:C1466.exportedCurrent.path
					Form:C1466.oldVersion:=VCS_UpdateOldVersion(Form:C1466.exportedCurrent.timeStamp; Form:C1466.oldPath)
					$FenetreInformation:=Form:C1466.oldPath+" selected. Double clic on the Method Name to copy the code into the pasteboard."
					displayInfo($FenetreInformation)
					
					ON ERR CALL:C155("BASE_noERROR")
					METHOD GET CODE:C1190(Form:C1466.oldPath; $currentVersion; *)
					MM_removeFirstLine(->$currentVersion)
					Form:C1466.currentVersion:=$currentVersion
					ON ERR CALL:C155("")
					
					$old:=Form:C1466.oldVersion
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "Compare_Application"; "insertInEditor"; $result; "mergeleft"; $currentVersion)
					PROCESS_sleep
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "Compare_Application"; "insertInEditor"; $result; "mergeright"; $old)
					
				End if 
		End case 
		
		// ********************************************************************************************************************************
		
	: ($evt=On Double Clicked:K2:5)
		
		Case of 
			: ($object="Modified_lb")
				If (Form:C1466.modifiedCurrent#Null:C1517)
					METHOD OPEN PATH:C1213(Form:C1466.modifiedCurrent.path; *)
				End if 
				
			: ($object="Exported_lb")
				SET TEXT TO PASTEBOARD:C523(Form:C1466.oldVersion)
				displayInfo("Code  of '"+Form:C1466.oldPath+"' set in pasteboard.")
				
			: ($object="allExports_1project")
				If (Form:C1466.exportedCurrent#Null:C1517)
					SET TEXT TO PASTEBOARD:C523(Form:C1466.oldVersion)
					displayInfo("Code  of '"+Form:C1466.oldPath+"' set in pasteboard.")
				End if 
				
		End case 
		
		// ********************************************************************************************************************************
		
	: ($evt=On Page Change:K2:54)
		(OBJECT Get pointer:C1124(Object named:K67:5; "searchInAllMethods"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5; "searchInAllProjects"))->:=""
		Form:C1466.txtQuery:=""
		Form:C1466.currentProject:=Form:C1466.VCS_QS_TBX_DBName
		
		// ********************************************************************************************************************************
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		CANCEL:C270
		
End case 