//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 21/04/18, 12:37:02
// ----------------------------------------------------
// Méthode : SC_getWebServerInformation
// Description
//  
//
// Paramètres
// ----------------------------------------------------

C_LONGINT:C283($i)
C_OBJECT:C1216($WebServer; $WebSecurity; $WebOptions)
C_COLLECTION:C1488($result)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472

$WebServer:=WEB Get server info:C1531(True:C214)
$result.push(New object:C1471("method"; "started"; "value"; String:C10($WebServer.started); "information"; "True if the http server is started, False otherwise"))
$result.push(New object:C1471("method"; "uptime"; "value"; String:C10($WebServer.uptime); "information"; "Time elapsed since last startup of the http server"))
$result.push(New object:C1471("method"; "httpRequestCount"; "value"; String:C10($WebServer.httpRequestCount); "information"; "Number of http hits received by the server since it was started"))
$result.push(New object:C1471("method"; "startMode"; "value"; $WebServer.startMode; "information"; "'automatic' if \"Launch Web Server at Startup\" is checked, otherwise 'manual'."))
$result.push(New object:C1471("method"; "SOAPServerStarted"; "value"; String:C10($WebServer.SOAPServerStarted); "information"; "True if the SOAP server is started, False otherwise"))

// Security information

$WebSecurity:=$WebServer.security
$result.push(New object:C1471("method"; "TLSEnabled"; "value"; String:C10($WebSecurity.TLSEnabled); "information"; "True if TLS was started at server startup"))
$result.push(New object:C1471("method"; "openSSLVersion"; "value"; $WebSecurity.openSSLVersion; "information"; "Version of the used OpenSSL library"))
$result.push(New object:C1471("method"; "cipherSuite"; "value"; $WebSecurity.cipherSuite; "information"; "Cipher list used by 4D for the secure protocol (corresponds to the SSL cipher list database parameter)"))
$result.push(New object:C1471("method"; "minTLSVersion"; "value"; $WebSecurity.minTLSVersion; "information"; "Minimum TLS version accepted for connections (corresponds to the Min TLS version database parameter)"))
$result.push(New object:C1471("method"; "perfectForwardSecrecy"; "value"; String:C10($WebSecurity.perfectForwardSecrecy); "information"; "True if PFS is available on the server, False otherwise"))

// Options

$WebOptions:=$WebServer.options
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.webCharacterSet; "information"; "Character set name (corresponds to the Web character set web option)"))
$result.push(New object:C1471("method"; "webHTTPCompressionLevel"; "value"; String:C10($WebOptions.webHTTPCompressionLevel); "information"; "Compression level for compressed HTTP exchanges (corresponds to the Web HTTP compression level web option)"))
$result.push(New object:C1471("method"; "webHTTPCompressionThreshold"; "value"; String:C10($WebOptions.webHTTPCompressionThreshold); "information"; "Compression threshold (corresponds to the Web HTTP compression threshold web option)"))
$result.push(New object:C1471("method"; "webHTTPSPortID"; "value"; String:C10($WebOptions.webHTTPSPortID); "information"; "TCP port number used by the Web server for secure connections (corresponds to the Web HTTPS port ID web option)"))
$result.push(New object:C1471("method"; "webInactiveProcessTimeout"; "value"; String:C10($WebOptions.webInactiveProcessTimeout); "information"; "Life duration of the inactive session processes (corresponds to the Web inactive process timeout web option)"))
$result.push(New object:C1471("method"; "webInactiveSessionTimeout"; "value"; String:C10($WebOptions.webInactiveSessionTimeout); "information"; "Life duration of the inactive sessions (corresponds to the Web inactive session timeout web option)"))

// Is a collection
// $result.push(new object("method";"webIPAddressToListen"
//;"value";$WebOptions.webIPAddressToListen
//;"information";""

$result.push(New object:C1471("method"; "webMaxConcurrentProcesses"; "value"; String:C10($WebOptions.webMaxConcurrentProcesses); "information"; "Maximum number of concurrent web processes (corresponds to the Web max concurrent processes web option)"))
$result.push(New object:C1471("method"; "webPortID"; "value"; String:C10($WebOptions.webPortID); "information"; "TCP port used by the Web server (corresponds to the Web port ID web option)"))

$WebOptions:=$WebServer.cache
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.cacheUsage; "information"; "Cache usage rate"))
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.numOfLoads; "information"; "Number of loaded objects"))
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.currentSize; "information"; "Cache current size"))
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.maxSize; "information"; "Cache maximum size"))
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.objectMaxSize; "information"; "Maximum size of objects loadable in the cache"))
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.enabled; "information"; "True if the web server cache is enabled"))
$result.push(New object:C1471("method"; "webCharacterSet"; "value"; $WebOptions.nbCachedObjects; "information"; "Number of objects in the cache"))
//$result.push(new object("method";"webCharacterSet";"value";$WebOptions.cachedObjects;"information";"Character set name (corresponds to the Web character set web option)"

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Web\nparameter")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				
		End case 
	End for 
	
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	LB_setHeights($Listbox_Name; 2; 2)
	displayInfo("")
End if 
