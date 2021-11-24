//%attributes = {"invisible":true}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 07/04/16, 07:50:14
// ----------------------------------------------------
// method : COMMANDS_LH_create
//
//  COMMANDS_btn_propertySelect must be updated if collection is added / removed
//
// ----------------------------------------------------
// @20200417 - Update for v18.1 commands

C_BOOLEAN:C305($1)  // Optionnal
C_OBJECT:C1216($command)
C_TEXT:C284($Language; $oneMethod)
C_REAL:C285($pas)
C_COLLECTION:C1488($commands)
C_LONGINT:C283($list)
C_OBJECT:C1216($SharedData)

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> Start")

$currentOnError:=Method called on error:C704
ON ERR CALL:C155("BASE_noERROR")
$commands:=Storage:C1525.commands4d.orderBy("theme")
$list:=New list:C375

// Get all methods from all objects & project methods
$Language:=Config_getLanguage

$result:=New collection:C1472
$coll:=New collection:C1472
$thema:="-1"

$path_commands:="images/commands/icns_"

$pic_32bits:=PIC_GetPicture("32bits.png")
$pic_forbidden:=PIC_GetPicture("forbidden.png")
$pic_record:=PIC_GetPicture($path_commands+"currentRecord.png")
$pic_selection:=PIC_GetPicture($path_commands+"currentSelection.png")
$pic_document:=PIC_GetPicture($path_commands+"document.png")
$pic_error:=PIC_GetPicture($path_commands+"error.png")
$pic_leak:=PIC_GetPicture($path_commands+"leak_memory.png")
$pic_lockedSet:=PIC_GetPicture($path_commands+"thema.png")
$pic_mac:=PIC_GetPicture($path_commands+"mac.png")
$pic_notServer:=PIC_GetPicture($path_commands+"notecs.png")
$pic_obsolete:=PIC_GetPicture($path_commands+"obsolete.png")
$pic_OK:=PIC_GetPicture($path_commands+"ok.png")
$pic_preemptive:=PIC_GetPicture($path_commands+"preemptive.png")
$pic_notPreemptive:=PIC_GetPicture($path_commands+"preemptif_no.png")
$pic_remote:=PIC_GetPicture($path_commands+"remotediff.png")
$pic_unicode:=PIC_GetPicture($path_commands+"unicode.png")
$pic_win:=PIC_GetPicture($path_commands+"win.png")

$pic_forbidden:=PIC_GetPicture($path_commands+"forbidden_server.png")
$pic_inapropriate:=PIC_GetPicture($path_commands+"inapropriate_server.png")
$pic_noEffect:=PIC_GetPicture($path_commands+"noEffect_server.png")
$pic_tableOptionnal:=PIC_GetPicture($path_commands+"table.png")
$pic_pointer:=PIC_GetPicture($path_commands+"pointer.png")
$pic_tableandpointer:=PIC_GetPicture($path_commands+"tp.png")
$pic_star:=PIC_GetPicture($path_commands+"star.png")

$pic_command:=PIC_GetPicture($path_commands+"command.png")
$pic_commands:=PIC_GetPicture($path_commands+"commands.png")
$pic_event:=PIC_GetPicture($path_commands+"event.png")
$pic_method:=PIC_GetPicture($path_commands+"method.png")
$pic_thema:=PIC_GetPicture($path_commands+"thema.png")

// *********************************************************************
// Add the new thema to the main List

StorageCounter("get")
//$subList:=LH_updateTB(->$list; ->$pic_command; "Commands")
$subList:=LH_updateTBpath(->$list; $path_commands+"command.png"; "Commands")

$vlNbTItems:=Count list items:C380($list; *)
SET LIST ITEM PARAMETER:C986($subList; 0; "type"; "")
SET LIST ITEM PARAMETER:C986($subList; 0; "path"; "")

// Now, start to work on the command list
For each ($command; $commands)
	
	CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; $command.EN)
	
	If ($command.theme#"")  // To not include commands which are not official
		// Thema Level
		If ($thema#$command.theme)  // New Thema
			//$subList2:=LH_updateTB(->$subList; ->$pic_thema; $command.theme)
			$subList2:=LH_updateTBpath(->$subList; $path_commands+"thema.png"; $command.theme)
			SET LIST ITEM PARAMETER:C986($subList; 0; "type"; "")
			SET LIST ITEM PARAMETER:C986($subList; 0; "path"; "")
			$thema:=$command.theme
		End if 
		
		// Command Name Level
		$result:=$command.useIn
		
		//$subList3:=LH_updateTB(->$subList2; ->$pic_command; $command[$Language])
		$subList3:=LH_updateTBpath(->$subList2; $path_commands+"command.png"; $command[$Language])
		SET LIST ITEM PARAMETER:C986($subList2; 0; "type"; "command")
		SET LIST ITEM PARAMETER:C986($subList2; 0; "path"; $command[$Language])  // Set the command name in the language required (FR or EN) // BUG
		
		// Now, update based on restrictions found in the doc
		// **********
		For each ($restrict; $command.restriction)
			
			Case of 
					
				: ($restrict="document")
					$picName:=$pic_document
					
				: ($restrict="Mac")
					$picName:=$pic_mac
					
				: ($restrict="Win")
					$picName:=$pic_win
					
				: ($restrict="Unicode")
					$picName:=$pic_unicode
					
				: ($restrict="Error")
					$picName:=$pic_error
					
				: ($restrict="OK")
					$picName:=$pic_OK
					
				: ($restrict="Record")
					$picName:=$pic_record
					
				: ($restrict="Selection")
					$picName:=$pic_selection
					
				: ($restrict="LockedSet")
					$picName:=$pic_lockedSet
					
				: ($restrict="NotServer")
					$picName:=$pic_notServer
					
				: ($restrict="Obsolete")
					$picName:=$pic_obsolete
					
				: ($restrict="Remote")
					$picName:=$pic_remote
					
				: ($restrict="notPreemptive")
					$picName:=$pic_notPreemptive
					
				: ($restrict="Leak")
					$picName:=$pic_leak
					
				: ($restrict="32bits")
					$picName:=$pic_32bits
					
				: ($restrict="Preemptive")
					$picName:=$pic_preemptive
					
				: ($restrict="Forbidden")
					$picName:=$pic_forbidden
					
				: ($restrict="Inapproriate")
					$picName:=$pic_inapropriate
					
				: ($restrict="noEffect")
					$picName:=$pic_noEffect
					
				: ($restrict="tableOptionnal")
					$picName:=$pic_tableOptionnal
					
				: ($restrict="Pointer")
					$picName:=$pic_pointer
					
				: ($restrict="tableandpointer")
					$picName:=$pic_tableandpointer
					
				: ($restrict="star")
					$picName:=$pic_star
					
			End case 
			
			COMMANDS_LH_set_restriction($command; ->$subList2; ->$picName; $restrict)
			
		End for each 
		
		// **********
		// ThreadSafe - CID number - Syntax This last one will be displayed into the Information footer bar.
		//$subList4:=LH_updateTB(->$subList3; ->$pic_event; "Information")
		$subList4:=LH_updateTBpath(->$subList3; $path_commands+"event.png"; "Information")
		SET LIST ITEM PARAMETER:C986($subList3; 0; "type"; "")
		SET LIST ITEM PARAMETER:C986($subList3; 0; "path"; "")
		
		//LH_updateTB(->$subList4; ->$pic_event; "Token #")
		LH_updateTBpath(->$subList4; $path_commands+"event.png"; "Token #")
		SET LIST ITEM PARAMETER:C986($subList4; 0; Additional text:K28:7; String:C10(Num:C11($command.token)))
		//LH_updateTB(->$subList4; ->$pic_event; "Thread-Safe")
		LH_updateTBpath(->$subList4; $path_commands+"event.png"; "Thread-Safe")
		SET LIST ITEM PARAMETER:C986($subList4; 0; Additional text:K28:7; Choose:C955($command.threadsafe; "Yes"; "No"))
		
		// Command vs Method
		If ($result.length>0)  // One or more methods used this command
			SET LIST ITEM PARAMETER:C986($subList2; 0; Additional text:K28:7; String:C10($result.length))  // The command has been found at least one time
			
			//$subList4:=LH_updateTB(->$subList3; ->$pic_method; "Method")
			$subList4:=LH_updateTBpath(->$subList3; $path_commands+"method.png"; "Method")
			
			For each ($oneMethod; $command.useIn)
				//LH_updateTB(->$subList4; ->$pic_method; $oneMethod)
				LH_updateTBpath(->$subList4; $path_commands+"method.png"; $oneMethod)
				SET LIST ITEM PARAMETER:C986($subList4; 0; "type"; "method")
				SET LIST ITEM PARAMETER:C986($subList4; 0; "path"; $oneMethod)
			End for each 
			
		End if 
	End if 
	
End for each 

C_COLLECTION:C1488($forDebug)
$forDebug:=New collection:C1472
$forDebug.push(New object:C1471("state"; "before"; "listNumber"; String:C10($list)))

$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
Use ($SharedData)
	$SharedData.QS_LH_commands:=Copy list:C626($list)
End use 

CLEAR LIST:C377($list; *)

$forDebug.push(New object:C1471("state"; "After"; "listNumber"; String:C10($SharedData.QS_LH_commands)))
StorageCounter("set")

C_OBJECT:C1216($signal)
$signal:=New signal:C1641
CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; $forDebug; 4; $signal)  //3
$signal.wait()

ON ERR CALL:C155($currentOnError)
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> End")

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
End if 