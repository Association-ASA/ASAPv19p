//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // $1 : object (.running -> state of the application, .name = application name)
  //
  // ----------------------------------------------------
  // Méthode : TOOL_isApplicationRunning
  // Description
  // http://forums.4d.com/Post/FR/14657093/1/14657094
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 04/02/20, 20:31:25
  // Paramètres

C_OBJECT:C1216($obj;$1)
C_TEXT:C284($in;$out;$error)

$obj:=$1

$obj.running:=False:C215
$applicationName:=$obj.name

C_TEXT:C284($in;$out;$error)

If (Is macOS:C1572)
	
	LAUNCH EXTERNAL PROCESS:C811("ps -ef";$in;$out;$error)
Else 
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	LAUNCH EXTERNAL PROCESS:C811("cmd.exe /C tasklist";$in;$out)
End if 

If (OK=1)
	$obj.running:=(Position:C15($applicationName;$out)>0)
End if 
