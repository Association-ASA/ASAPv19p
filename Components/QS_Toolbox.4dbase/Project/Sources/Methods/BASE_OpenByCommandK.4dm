//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
/* ----------------------------------------------------
 Nom utilisateur (OS) : Arnaud de Montard
 Date et heure : 27/05/18, 20:33:52
 ----------------------------------------------------
 Paramètres
 $1 = Path to open by a Command K
 ----------------------------------------------------
 Description
 http://forums.4d.com/Post/FR/24349669/1/24362519

 Example:
 BASE_openByCommandK("[table_1]dumy")
 BASE_openByCommandK("[table_1];dummy")
 BASE_openByCommandK("Formulaire :dummy")
 BASE_openByCommandK("dummy")
*/


C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($error_t)

$pss_l:=Current process:C322

$error_t:=""
$cmdKpath_t:=$1
$cmdK_t:="__QST_HOST_Command_K_method"

$targettitle2_t:=""
Case of   //expected target window title #TODO with regex
	: ($cmdKpath_t="[@];\"@\"")  //table form
		$targetTitle_t:="Form@:@"
	: ($cmdKpath_t="\"@\"")  //project form
		$targetTitle_t:="Form@:@"
	: ($cmdKpath_t="[@]@")  //table or field
		$targetTitle_t:="@structure"
		$targettitle2_t:="@struktur"
	Else 
		$targetTitle_t:=""  //something else…
End case 

  //dummy method we use to paste and hit cmd+K
UPDT_WriteMethod ($cmdK_t;$cmdKpath_t)
METHOD OPEN PATH:C1213($cmdK_t;*)

$timeOut_l:=Tickcount:C458+120
$cmdKwindowRef_l:=0
$cmdKwindowTitle_t:="@"+$cmdK_t
$cmdKwindowRef_l:=WDW_WaitUntilOpened ($cmdKwindowTitle_t)

If ($cmdKwindowRef_l=0)
	$error_t:="Failed waiting a window named "+$cmdKwindowTitle_t
	
Else 
	
	POST KEY:C465(Character code:C91("a");Command key mask:K16:1)
	PROCESS_sleep (10)
	POST KEY:C465(Character code:C91("k");Command key mask:K16:1)
	If ($targettitle_t#"")
		$timeout_l:=Tickcount:C458+120
		
		Repeat 
			PROCESS_sleep 
			$targetwindowref_l:=Frontmost window:C447
			$wt_t:=Get window title:C450($targetwindowref_l)
		Until (($wt_t=$targettitle_t) | ($wt_t=$targettitle2_t) | (Tickcount:C458>$timeout_l))
		
		If (Tickcount:C458>$timeout_l)  // failed
			$error_t:="Failed waiting a window named "+$targettitle_t+" or "+$targettitle2_t
			
		Else 
			HIDE WINDOW:C436($targetwindowref_l)
			$timeout_l:=Tickcount:C458+40
			
			Repeat 
				PROCESS_sleep 
			Until ((Get window title:C450(Frontmost window:C447)=$cmdKwindowTitle_t) | (Tickcount:C458>$timeout_l))
			
			If (Tickcount:C458>$timeout_l)
				$error_t:="Cannot clean "+$cmdK_t
			Else 
				POST KEY:C465(Character code:C91("w");Command key mask:K16:1)
				PROCESS_sleep (10)
				UPDT_WriteMethod ($cmdK_t;"")
			End if 
			
			SHOW WINDOW:C435($targetwindowref_l)
		End if 
	End if 
End if 
$0:=$error_t