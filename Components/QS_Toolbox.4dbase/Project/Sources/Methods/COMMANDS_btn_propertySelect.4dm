//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		C_COLLECTION:C1488($menu)
		C_OBJECT:C1216($item)
		
		$menu:=New collection:C1472
		
		$menu.push(New object:C1471("action"; ""; "name"; "idle"; "restriction"; "idle"; "help"; "\"Idle\": No filter."))
		$menu.push(New object:C1471("action"; ""; "name"; "leak_memory"; "restriction"; "Leak"; "help"; "\"Leak memory\": Can provoke memory leaks if the code does not delete references after use."))
		$menu.push(New object:C1471("action"; ""; "name"; "remotediff"; "restriction"; "Remote"; "help"; "\"Remote diff\": Different comportement in Remote mode."))
		$menu.push(New object:C1471("action"; ""; "name"; "notecs"; "restriction"; "NotServer"; "help"; "\"Not for server\": Not for server.\nIf one of the following commands is used within a stored procedure, an alert will be displayed indicating that this command cannot be executed on 4D Server.\nThe error #67 is returned and can be intercepted through a m"+"e"+"thod installed in"+" the ON ERR CALL command."))
		
		$menu.push(New object:C1471("action"; ""; "name"; "obsolete"; "restriction"; "obsolete"; "help"; "\"Obsolete\": Obsolete commands."))
		$menu.push(New object:C1471("action"; ""; "name"; "mac"; "restriction"; "Mac"; "help"; "\"Mac OS\": Mac OSX platform-specific behavior."))
		$menu.push(New object:C1471("action"; ""; "name"; "document"; "restriction"; "Document"; "help"; "\"Document var changed\": The Document system variable is changed."))
		$menu.push(New object:C1471("action"; ""; "name"; "ok"; "restriction"; "OK"; "help"; "\"OK changed\": The OK system variable is changed."))
		$menu.push(New object:C1471("action"; ""; "name"; "error"; "restriction"; "Error"; "help"; "\"Error changed\": The Error system variable is changed."))
		$menu.push(New object:C1471("action"; ""; "name"; "lockedSet"; "restriction"; "LockedSet"; "help"; "\"LockedSet changed\": Modify the LockedSet system set."))
		$menu.push(New object:C1471("action"; ""; "name"; "win"; "restriction"; "Win"; "help"; "\"windows\": Windows platform-specific behavior."))
		$menu.push(New object:C1471("action"; ""; "name"; "unicode"; "restriction"; "Unicode"; "help"; "\"Unicode\": Affected by the Unicode mode."))
		$menu.push(New object:C1471("action"; ""; "name"; "currentSelection"; "restriction"; "Selection"; "help"; "\"Current Selection changed\": Change the current selection."))
		$menu.push(New object:C1471("action"; ""; "name"; "currentRecord"; "restriction"; "Record"; "help"; "\"Current Record changed\": Change the currrent record."))
		$menu.push(New object:C1471("action"; ""; "name"; "preemptive"; "restriction"; "Preemptive"; "help"; "\"Preemptive\": Can be run in preemptive processes."))
		$menu.push(New object:C1471("action"; ""; "name"; "preemptif_no"; "restriction"; "notPreemptive"; "help"; "\"Not preemptive\": Cannot be run in preemptive processes."))
		//$menu.push(New object("action";"";"name";"32bits";"restriction";"32 bits";"help";"\"Not 32bits\": Not available in 32 bits."))
		
		$menu.push(New object:C1471("action"; ""; "name"; "forbidden_server"; "restriction"; "Forbidden"; "help"; "\"Forbidden On Server\":\nIf one of the following commands is used within a stored procedure, an alert will be displayed indicating that this command cannot be executed on 4D Server. The error #67 is returned."))
		$menu.push(New object:C1471("action"; ""; "name"; "inapropriate_server"; "restriction"; "Inapropriate"; "help"; "\"Inapropriate On Server\":\nThe following commands can block the server and create errors, and in any case they do not execute properly.\nNo specific error code is returned."))
		$menu.push(New object:C1471("action"; ""; "name"; "noEffect_server"; "restriction"; "noEffect"; "help"; "\"No Effect on server\":\nThe following commands have no effect when they are executed within a stored procedure on the server.\nNo specific error code is returned."))
		
		$menu.push(New object:C1471("action"; ""; "name"; "table"; "restriction"; "tableOptionnal"; "help"; "\"Table optionnal\": Table is optimal if DEFAULT TABLE command used before."))
		$menu.push(New object:C1471("action"; ""; "name"; "pointer"; "restriction"; "pointer"; "help"; "\"Pointer restriction\": When using pointers, the compiler does not allow a command that returns a pointer to be passed directly as first parameter (an error is generated)."))
		$menu.push(New object:C1471("action"; ""; "name"; "tp"; "restriction"; "tableAndPointer"; "help"; "\"Table and Pointer \":\nThe following commands have one common feature: they accept an optional first parameter [Table], and the second parameter can be a pointer."))
		$menu.push(New object:C1471("action"; ""; "name"; "star"; "restriction"; "star"; "help"; "\"Star \":\nThe following commands use the char * as parameter modifier of the command when it is the last optional paramter."))
		
		C_TEXT:C284($keyword; $Language)
		C_OBJECT:C1216($comm)
		C_TEXT:C284($cheminPictos; $cheminPictos01; $txt)
		
		$cheminPictos:="file:images/commands/icn_"
		$cheminPictos01:="file:images/icons/icn_magik_info.png"
		
		$value:=0
		$refMenu:=Create menu:C408
		
		// No need to test if $i=0. Add it immediately to the menu ;-)
		APPEND MENU ITEM:C411($refMenu; "Choose a property"; *)
		SET MENU ITEM PARAMETER:C1004($refMenu; -1; "")
		SET MENU ITEM ICON:C984($refMenu; -1; $cheminPictos01)
		DISABLE MENU ITEM:C150($refMenu; -1)
		SET MENU ITEM MARK:C208($refMenu; -1; Char:C90(18))
		
		$i:=0
		For each ($item; $menu)
			$i:=$i+1
			$k:=Position:C15("\""; Substring:C12($item.help; 2))
			If ($k>0)
				$item.action:=Substring:C12($item.help; 2; $k-1)
			End if 
			
			APPEND MENU ITEM:C411($refMenu; $item.action; *)
			SET MENU ITEM PARAMETER:C1004($refMenu; -1; String:C10($i))
			SET MENU ITEM ICON:C984($refMenu; -1; $cheminPictos+$item.name+".png")
			
		End for each 
		
		C_TEXT:C284($answerMenu)
		C_LONGINT:C283($value)
		$answerMenu:=Dynamic pop up menu:C1006($refMenu)
		
		RELEASE MENU:C978($refMenu)
		$isOk:=(""#$answerMenu)
		
		If ($isOk)
			$action:=Num:C11($answerMenu)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "btn_property")
			x_btn_toggleSetTxt($ptr; $menu[$action-1].name)
			$txt:=$menu[$action-1].help
			(OBJECT Get pointer:C1124(Object named:K67:5; "property_info"))->:=$txt
			
			If ($action=1)
				Form:C1466.indice:=0
				Form:C1466.found.clear()
				
				// Doc says: If you pass a value outside this range, no item is selected.
				SELECT LIST ITEMS BY POSITION:C381(Form:C1466.LH; Count list items:C380(Form:C1466.LH; *)+100)
				$CurrentCommand:=""
				displayInfo($CurrentCommand)
				LH_btn_updateStatus
				
			Else 
				C_COLLECTION:C1488($commands4d)
				$keyword:=$menu[$action-1].restriction
				$Language:=Config_getLanguage
				
				$commands4d:=Storage:C1525.commands4d.copy()
				$commands4d:=$commands4d.query("restriction[] =:1"; $keyword)
				If ($commands4d.length>0)
					Form:C1466.indice:=1
					
					ARRAY LONGINT:C221($tabElements; $commands4d.length)
					$i:=0
					For each ($comm; $commands4d)
						$i:=$i+1
						$text:=$comm[$Language]
						$ItemRef:=Find in list:C952(*; "myLH"; $text; 1; *)
						$tabElements{$i}:=$ItemRef
					End for each 
					ARRAY TO COLLECTION:C1563(Form:C1466.found; $tabElements)
					SELECT LIST ITEMS BY REFERENCE:C630(Form:C1466.LH; $tabElements{1}; $tabElements)
					Content_4DC:=$commands4d.extract("syntax").sort().join("\n"; ck ignore null or empty:K85:5)
					METHOD_codeMirror_display
					WA REFRESH CURRENT URL:C1023(*; "webZone")
					
					$CurrentCommand:=String:C10(Form:C1466.found.length; "### ##0")+" reference(s) found with '"+$keyword+"' as criteria."
					displayInfo($CurrentCommand)
					LH_btn_updateStatus
					
				Else 
					(OBJECT Get pointer:C1124(Object named:K67:5; "searchCommands"))->:=""
					SELECT LIST ITEMS BY POSITION:C381(*; "myLH"; -1)
					Form:C1466.indice:=0
				End if 
				
			End if 
		End if 
		
End case 