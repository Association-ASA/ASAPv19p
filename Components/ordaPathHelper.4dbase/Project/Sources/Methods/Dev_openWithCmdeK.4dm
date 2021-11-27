//%attributes = {}
  //Dev_openWithCmdeK (path_t) -> txt
  //µ Arnaud * 24/05/2018 
  //© Arnaud * 23/05/2018 

C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($error_t)
  //_
$cmn_t:=Current method name:C684
$pss_l:=Current process:C322
$cmdK_t:="CmdK"

$error_t:=""

If (Not:C34(xxDoa_methodExists ($cmdK_t)))
	$error_t:=$cmn_t+" no method named 'CmdK'"
Else 
	
	$pattern_t:=$1
	Case of   //expected target window title #TODO with regex
		: ($pattern_t="[@];\"@\"")  //table form
			$targetTitle_t:="Form@:@"
		: ($pattern_t="\"@\"")  //project form
			$targetTitle_t:="Form@:@"
		: ($pattern_t="[@]@")  //table or field
			$targetTitle_t:="@structure"
		Else 
			$targetTitle_t:=""  //something else…
	End case 
	
	  //dummy method we use to paste and hit cmd+K
	  //[ADHERENT]
	  //[zzz:1]
	  //ASSERT(Doa_methodExists ($cmdK_t);$cmn_t+" no method named 'CmdK'")
	METHOD SET CODE:C1194($cmdK_t;$pattern_t;*)
	METHOD OPEN PATH:C1213($cmdK_t;*)
	
	$timeOut_l:=Tickcount:C458+5
	$cmdKwindowRef_l:=0
	$cmdKwindowTitle_t:="@"+$cmdK_t
	$cmdKwindowRef_l:=Win_waitUntilOpened ($cmdKwindowTitle_t)
	If ($cmdKwindowRef_l=0)
		$error_t:="Failed waiting a window named "+$cmdKwindowTitle_t
	Else 
		$temp_l:=10
		  // Because the code has been write (except if the method is opened in the hosted database:
		  //paste the string for cmd+K in the code
		  //SET TEXT TO PASTEBOARD($pattern_t)
		  //POST KEY(Character code("a");Command key mask)  //select all
		  //DELAY PROCESS($pss_l;$temp_l)
		  //POST KEY(Character code("v");Command key mask)  //paste path
		  //DELAY PROCESS($pss_l;$temp_l)
		
		POST KEY:C465(Character code:C91("a");Command key mask:K16:1)  //select all
		DELAY PROCESS:C323($pss_l;$temp_l)
		POST KEY:C465(Character code:C91("k");Command key mask:K16:1)  //cmde+K
		
		If ($targetTitle_t="")  //unknown target
			
		Else   //target is a known editor
			$targetWindowRef_l:=Win_waitUntilOpened ($targetTitle_t)
			If ($targetWindowRef_l=0)
				$error_t:="Failed waiting a window named "+$cmdKwindowTitle_t
			Else 
				HIDE WINDOW:C436($targetWindowRef_l)  //WWW hide target
				$cmdKwindowRef_l:=Win_waitUntilOpened ($cmdKwindowTitle_t)
				
				If ($cmdKwindowRef_l#0)
					POST KEY:C465(Character code:C91("w");Command key mask:K16:1)  //close
					DELAY PROCESS:C323($pss_l;5)
				Else 
					$error_t:="Cannot clean "+String:C10($cmdKwindowTitle_t)
				End if 
				SHOW WINDOW:C435($targetWindowRef_l)  //WWW show target
				If ($cmdKwindowRef_l#0)
					DELAY PROCESS:C323($pss_l;5)
					$code_t:=""
					METHOD SET CODE:C1194($cmdK_t;$code_t;*)  //clean
				End if 
			End if 
		End if 
	End if 
	
End if 

$0:=$error_t
  //_
