//%attributes = {"invisible":true}
// PM: "openWebAreaForm" (new LV 25.08.20, 13:15:11)
// Last change: LV 25.08.20, 13:15:11

C_TEXT:C284($calledBy; $1; $windows)
C_LONGINT:C283($winRef; $parseProcess)

If (Count parameters:C259>0)
	$calledBy:=$1
Else 
	$calledBy:=""
End if 

$window:="_webParseForm"

If ($calledBy#Current method name:C684)  // isSelfLauched
	// Start the process (if it does not exist) or bring it to the front (if it is already running)
	$parseProcess:=New process:C317(Current method name:C684; 0; "parser4dCode"; Current method name:C684; *)
	OB_windowNumberToStorage("parseProcess"; $parseProcess)
	
	If ($parseProcess#0)
		HIDE PROCESS:C324($parseProcess)
	End if 
	
Else 
	
	$Win:=Open form window:C675($window; -500; -500)
	OB_windowNumberToStorage($window; $Win)
	HIDE WINDOW:C436($Win)
	HIDE PROCESS:C324($parseProcess)
	DIALOG:C40($window)
	CLOSE WINDOW:C154($Win)
	
End if 