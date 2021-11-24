//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 21/04/18, 13:02:04
// ----------------------------------------------------
// Méthode : SC_getWebOptions
// Description
//  
//
// Paramètres
// ----------------------------------------------------  


C_COLLECTION:C1488($result)
C_LONGINT:C283($i; $NumValue)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472

WEB GET OPTION:C1209(Web character set:K73:6; $NumValue)
$result.push(New object:C1471("method"; Konstant_getName(73; 17); "scope"; "4D local, 4D Server"; "current value"; String:C10($NumValue); "default value"; "see doc"; "description"; "Character set that the 4D Web Server  (with 4D in local mode and 4D Server) should use to communicate with browsers connecting to the database. The default value actually depends on the language of the operating system."\
))

WEB GET OPTION:C1209(Web IP address to listen:K73:5; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "see doc"; "scope"; "4D remote machine"; "method"; Konstant_getName(73; 16)\
; "description"; "Used to specify this parameter for a remote 4D used as Web Server (applied to the remote web server only)."))

WEB GET OPTION:C1209(Web debug log:K73:18; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "prefixed with 'wdl' "; "scope"; "Local Web server"; "method"; Konstant_getName(73; 84)\
; "description"; "Allows you to get or set the status of the HTTP request log file of the 4D Web server. 0 is defined by default."))

WEB GET OPTION:C1209(Web HTTP compression level:K73:11; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "1 to 9 (1 = faster, 9 = more compressed) or -1 = best compromise"; "scope"; "Local Web server"; "method"; Konstant_getName(73; 50)\
; "description"; "This selector lets you optimize exchanges by either privileging speed of execution (less compression) or the amount of compression (less speed)."))

WEB GET OPTION:C1209(Web HTTP compression threshold:K73:12; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "Any Longint type value"\
; "description"; "This setting is useful in order to avoid losing machine time by compressing small exchanges."; "scope"; "Local Web server"; "method"; Konstant_getName(73; 51)))

WEB GET OPTION:C1209(Web HTTP TRACE:K73:24; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "0 (disabled) or 1 (enabled)"; "scope"; "Local Web server"\
; "method"; Konstant_getName(73; 85); "description"; "Allows you to disable or enable the HTTP TRACE method in the 4D Web server. For security reasons, starting with 4D v15 R2, by default the 4D Web server rejects HTTP TRACE requests with an error 405."))

WEB GET OPTION:C1209(Web inactive process timeout:K73:13; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "480 minutes (pass 0 to restore the default value)"; "scope"; "Local Web server"; "method"; Konstant_getName(73; 78)\
; "description"; "Modifies the life duration of the inactive processes associated with sessions."))

WEB GET OPTION:C1209(Web HTTPS port ID:K73:10; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "0 to 65535"; "scope"; "4D local, 4D Server"; "method"; Konstant_getName(73; 39)\
; "description"; "TCP port number used by the Web server of 4D in local mode and of 4D Server for secure connections via TLS. By default, value is 443."))

WEB GET OPTION:C1209(Web inactive session timeout:K73:3; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "480 minutes (pass 0 to restore the default value)"; "scope"; "Local Web server"; "method"; Konstant_getName(73; 72)\
; "description"; "Modifies the life duration of the inactive sessions."))

WEB GET OPTION:C1209(Web legacy session:K73:1; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "1 (enable mode) or 0 (disable mode)"; "scope"; "Local Web server"; "method"; Konstant_getName(73; 70)\
; "description"; "Enables or disables the session management mode."))

WEB GET OPTION:C1209(Web log recording:K73:9; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "0 = Do not record (default),\r1 = Record in CLF format,\r2 = Record in DLF format,\r3 = Record in ELF format,\r4 = Record in WLF format."; "scope"; "4D local, 4D Server"; \
"method"; Konstant_getName(73; 29)\
; "description"; "Starts or stops the recording of Web requests received by the Web server of 4D in local mode or 4D Server. By default, the value is 0 (requests not recorded)."))

WEB GET OPTION:C1209(Web max concurrent processes:K73:7; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "Any value between 10 and 32 000. The default value is 100"; "scope"; "4D local, 4D Server"; "method"; Konstant_getName(73; 18)\
; "description"; "Strictly upper limit of concurrent Web processes of any type supported by the 4D Web Server with 4D in local mode and 4D Server."))

WEB GET OPTION:C1209(Web max sessions:K73:2; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "100 (pass 0 to restore the default value)"; "scope"; "Local Web server"; "method"; Konstant_getName(73; 71)\
; "description"; "Limits the number of simultaneous sessions."))

WEB GET OPTION:C1209(Web maximum requests size:K73:8; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "500 000 to 2 147 483 648"; "scope"; "4D local, 4D Server"; "method"; Konstant_getName(73; 27)\
; "description"; "Maximum size (in bytes) of incoming HTTP requests (POST) that the Web server is authorized to process."))

WEB GET OPTION:C1209(Web Port ID:K73:14; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "80"; "scope"; "4D in local mode and 4D Server"; "method"; Konstant_getName(73; 15)\
; "description"; "Sets or gets the number of the TCP port used by the 4D Web server with 4D in local mode and 4D Server."))

WEB GET OPTION:C1209(Web Session cookie domain:K73:15; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "80"; "scope"; "local Web server"; "method"; Konstant_getName(73; 81)\
; "description"; "Sets or gets the value of the 'domain' field of the session cookie. If you set, for example, the value '/*.4d.fr' for this selector, the client will only send a cookie when the request is addressed to the domain '.4d.fr', which excludes servers hostin"+"g external static data."))

WEB GET OPTION:C1209(Web session cookie name:K73:4; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "4DSID"; "scope"; "Local Web server"; "method"; Konstant_getName(73; 73)\
; "description"; "Sets the name of the cookie used for saving the session ID."))

WEB GET OPTION:C1209(Web Session cookie path:K73:16; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; ""; "scope"; "local Web server"; "method"; Konstant_getName(73; 82)\
; "description"; "Sets or gets the value of the 'path' field of the session cookie."))

WEB GET OPTION:C1209(Web Session IP address validation enabled:K73:17; $NumValue)
$result.push(New object:C1471("current value"; String:C10($NumValue); "default value"; "0 (disabled) or 1 (enabled)"; "scope"; "local Web server"; "method"; Konstant_getName(73; 83)\
; "description"; "Enables or disables IP address validation for session cookies. Default value is 1."))
$result:=$result.orderBy("Method asc")

// ***************************************************

// ******************** Listbox preparation

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "CONSTANT")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				
			: ($i=2)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Scope")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 170)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Keep between 2 sessions")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 90)
				
			: ($i=4)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Default value")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				
			: ($i=5)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Authorized value")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				
			: ($i=6)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Information")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 1; 3)
	LB_ResizeLine($Listbox_Name)
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	displayInfo("")
End if 