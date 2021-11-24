//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 19/04/18, 21:52:54
// ----------------------------------------------------
// Méthode : SC_get_DB_Parameters
// Description
// Paramètres
// ----------------------------------------------------
// According vR.175

C_COLLECTION:C1488($result)
$result:=New collection:C1472
$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

// Minimum Web process
$result.push(New object:C1471("method"; Konstant_getName(37; 6); "scope"; "4D local, 4D Server"; "keep"; True:C214; "parameter"; Get database parameter:C643(_o_Minimum Web process:K37:6); "pValues"; "0 -> 32767"\
; "information"; "Minimum number of Web processes to maintain in non-contextual mode with 4D in local mode and 4D Server. By default, the value is 0."))

// Maximum Web process
$result.push(New object:C1471("method"; Konstant_getName(37; 7); "parameter"; Get database parameter:C643(_o_Maximum Web process:K37:7); "keep"; True:C214; "pValues"; "0 -> 32767"\
; "information"; "Maximum number of Web processes to maintain in non-contextual mode with 4D in local mode and 4D Server. By default, the value is 10."\
; "scope"; "4D local, 4D Server"))

// Maximum Web process
$result.push(New object:C1471("method"; Konstant_getName(37; 8); "parameter"; Get database parameter:C643(_o_Web conversion mode:K37:8); "keep"; False:C215\
; "pValues"; "0 -> 3"; "information"; "This constant is obsolete and ignored since 4D v13. Conversion mode of 4D forms for the Web with 4D in local mode and 4D Server. By default, "+\
"the 4D Web Server uses the cascading style sheets (CSS1) to generate HTML pages similar to the 4D forms displayed in 4D."; "scope"; "Current process"))

// Taille cache données
$result.push(New object:C1471("method"; Konstant_getName(37; 9); "parameter"; Get database parameter:C643(_o_Database cache size:K37:9); "keep"; False:C215\
; "pValues"; "-"; "information"; "Allows you to get the current memory cache size used by 4D for the data. This value is expressed in bytes."\
; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 10); "parameter"; Get database parameter:C643(_o_4D Local mode scheduler:K37:10); "keep"; True:C214\
; "pValues"; "the value parameter is expressed in hexadecimal 0x00aabbcc as follows:\raa=minimum number of ticks per call to the system(0 to 100 included)\rbb=maximum number of ticks per call to the system(0 to 100 included)\rcc = number of ticks between calls to the "\
+"system (0 to 20 included)."; "information"; "4D local mode when the command is called from a 4D single-user application (selector=10).\r4D Server when the command is called from 4D Server(selector=11)\r4D remote mode when the command is called from a 4D connected to 4D Server (selector=12)."\
; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 11); "parameter"; Get database parameter:C643(_o_4D Server scheduler:K37:11); "keep"; True:C214\
; "pValues"; "the value parameter is expressed in hexadecimal 0x00aabbcc as follows:\r"+\
"aa=minimum number of ticks per call to the system(0 to 100 included)\r"+\
"bb=maximum number of ticks per call to the system(0 to 100 included)\r"+\
"cc = number of ticks between calls to the system (0 to 20 included)."\
; "information"; "4D local mode when the command is called from a 4D single-user application (selector=10).\r4D Server when the command is called from 4D Server(selector=11)\r4D remote mode when the command is called from a 4D connected to 4D Server (selector=12)."\
; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 12); "parameter"; Get database parameter:C643(_o_4D Remote mode scheduler:K37:12); "keep"; True:C214\
; "pValues"; "the value parameter is expressed in hexadecimal 0x00aabbcc as follows:\r"+\
"aa=minimum number of ticks per call to the system(0 to 100 included)\r"+\
"bb=maximum number of ticks per call to the system(0 to 100 included)\r"+\
"cc = number of ticks between calls to the system (0 to 20 included)."\
; "information"; "4D local mode when the command is called from a 4D single-user application (selector=10).\r4D Server when the command is called from 4D Server (selector=11)\r"+\
"4D remote mode when the command is called from a 4D connected to 4D Server (selector=12)."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 13); "parameter"; Get database parameter:C643(4D Server timeout:K37:13); "keep"; True:C214\
; "pValues"; "0 -> 32767"; "information"; "Set the maximum period \"authorized\" to wait for a client response.\rIf the value is negative, then the timeout is temporary (not permanent)."\
; "scope"; "4D application if value positive"))

$result.push(New object:C1471("method"; Konstant_getName(37; 14); "parameter"; Get database parameter:C643(4D Remote mode timeout:K37:14); "keep"; True:C214\
; "pValues"; "0 -> 32767"; "information"; "Is only taken into account if you are using the legacy network."; "scope"; "4D application if value positive"))

$result.push(New object:C1471("method"; Konstant_getName(37; 15); "parameter"; Get database parameter:C643(Port ID:K37:15); "keep"; True:C214\
; "pValues"; "One of available ports"; "information"; "80"; "scope"; "Is useful for 4D Web Servers compiled and merged with 4D Desktop "))

$result.push(New object:C1471("method"; Konstant_getName(37; 16); "parameter"; Get database parameter:C643(_o_IP address to listen:K37:16); "keep"; True:C214; "pValues"; "Constant obsolete"; \
"information"; "It is recommend to use the WEB SET OPTION and WEB GET OPTION commands for configuring the HTTP server."; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 17); "parameter"; Get database parameter:C643(Character set:K37:17); "keep"; True:C214; "pValues"; "Constant obsolete"\
; "information"; "It is recommend to use the WEB SET OPTION and WEB GET OPTION commands for configuring the HTTP server."; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 18); "parameter"; Get database parameter:C643(Max concurrent Web processes:K37:18); "keep"; True:C214; "pValues"; "Constant obsolete"\
; "information"; "It is recommend to use the WEB SET OPTION and WEB GET OPTION commands for configuring the HTTP server."; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 19); "parameter"; Get database parameter:C643(_o_Client minimum Web process:K37:19); "keep"; True:C214; "pValues"; "0 -> 32767"\
; "information"; "The values defined using these selectors are applied to all the remote machines used as Web servers."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 20); "parameter"; Get database parameter:C643(_o_Client maximum Web process:K37:20); "keep"; True:C214; "pValues"; "0 -> 32767"\
; "information"; "The values defined using these selectors are applied to all the remote machines used as Web servers."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 21); "parameter"; Get database parameter:C643(_o_Client max Web requests size:K37:21); "keep"; True:C214; "pValues"; "?"\
; "information"; "The values defined using these selectors are applied to all the remote machines used as Web servers."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 22); "parameter"; Get database parameter:C643(Client port ID:K37:22); "keep"; True:C214; "pValues"; "One of available ports"\
; "information"; "The values defined using these selectors are applied to all the remote machines used as Web servers."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 23); "parameter"; Get database parameter:C643(_o_Client IP address to listen:K37:23); "keep"; True:C214; "pValues"; "One of available ports"\
; "information"; "The values defined using these selectors are applied to all the remote machines used as Web servers."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 24); "parameter"; Get database parameter:C643(Client character set:K37:24); "keep"; True:C214; "pValues"; "One of available ports"\
; "information"; "The values defined using these selectors are applied to all the remote machines used as Web servers."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 25); "parameter"; Get database parameter:C643(Client max concurrent Web proc:K37:25); "keep"; True:C214; "pValues"; "One of available ports"\
; "information"; "The values defined using these selectors are applied to all the remote machines used as Web servers."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 27); "parameter"; Get database parameter:C643(Maximum Web requests size:K37:27); "keep"; True:C214; "pValues"; "Constant obsolete"\
; "information"; "It is recommend to use the WEB SET OPTION and WEB GET OPTION commands for configuring the HTTP server."; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 28); "parameter"; Get database parameter:C643(4D Server log recording:K37:28); "keep"; False:C215; "pValues"; "0 or from 1 to X"\
; "information"; "Starts or stops the recording of standard requests received by 4D Server (excluding Web requests). By default, the value is 0 (requests not recorded)."; "scope"; "4D Server, 4D remote"))

$result.push(New object:C1471("method"; Konstant_getName(37; 30); "parameter"; Get database parameter:C643(Client Web log recording:K37:30); "keep"; True:C214; "pValues"; " 0 = Do not record (default),\r1 = Record in CLF format,\r2 = Record in DLF format,\r3 = Record in ELF format,\r4 = Record in WLF format."\
; "information"; "Starts or stops the recording of Web requests received by the Web servers of all the client machines. By default, the value is 0 (requests not recorded)."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 31); "parameter"; Get database parameter:C643(Table sequence number:K37:31); "keep"; True:C214; "pValues"; "Any longint value"\
; "information"; " This selector is used to modify or get the current unique number for records of the table passed as parameter. \"Current number\" means \"last number used\""; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 34); "parameter"; Get database parameter:C643(Debug log recording:K37:34); "keep"; False:C215; "pValues"; "Longint containing a bit field: value = bit1(1)+bit2(2)+bit3(4)+bit4(8)+…)."\
; "information"; "Starts or stops the sequential recording of events occurring at the 4D programming level in the 4DDebugLog file, which is automatically placed in the Logs subfolder of the database, next to the structure file."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 35); "parameter"; Get database parameter:C643(Client Server port ID:K37:35); "keep"; True:C214; "pValues"; "0 to 65535"\
; "information"; "TCP port number where the 4D Server publishes the database (bound for 4D remote machines). By default, the value is 19813. "; "scope"; "Database"))

$result.push(New object:C1471("method"; Konstant_getName(37; 37); "parameter"; Get database parameter:C643(_o_Invert objects:K37:37); "keep"; True:C214; "pValues"; "0 = mode disabled,\r1 = automatic mode,\r2 = mode enabled"\
; "information"; " Configuration of the \"object inversion\" mode which is used to invert forms, objects, menu bars, and so on, in Application mode when the database is displayed in Windows in a right-to-left language."; "scope"; "Database"))

$result.push(New object:C1471("method"; Konstant_getName(37; 39); "parameter"; Get database parameter:C643(HTTPS port ID:K37:38); "keep"; True:C214; "pValues"; "Constant obsolete"\
; "information"; "It is recommend to use the WEB SET OPTION and WEB GET OPTION commands for configuring the HTTP server."; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 40); "parameter"; Get database parameter:C643(Client HTTPS port ID:K37:39); "keep"; True:C214\
; "pValues"; "0 to 65535"; "information"; " TCP port number used by the Web servers of the client machines for secure connections via SSL (HTTPS protocol). By default, the value is 443 (standard value)."; "scope"; "All 4D remote machines"))

$result.push(New object:C1471("method"; Konstant_getName(37; 41); "parameter"; Get database parameter:C643(Unicode mode:K37:40); "keep"; True:C214\
; "pValues"; "0 (compatibility mode) or 1 (Unicode mode)"; "information"; "Required to be set to 1"; "scope"; "Database"))

$result.push(New object:C1471("method"; Konstant_getName(37; 43); "parameter"; Get database parameter:C643(SQL autocommit:K37:42); "keep"; True:C214; "pValues"; " 0 (deactivation) or 1 (activation)"\
; "information"; "By default, the value is 0 (deactivated mode)"; "scope"; "Database"))

$result.push(New object:C1471("method"; Konstant_getName(37; 44); "parameter"; Get database parameter:C643(SQL engine case sensitivity:K37:43); "keep"; True:C214; "pValues"; "0 (case not taken into account) or 1 (case-sensitive)"\
; "information"; "Activation or deactivation of case-sensitivity for string comparisons carried out by the SQL engine. "; "scope"; "Database"))

$result.push(New object:C1471("method"; Konstant_getName(37; 45); "parameter"; Get database parameter:C643(Client log recording:K37:44); "keep"; False:C215; "pValues"; "0 = do not record, 1 to X = sequential number, attached to file name"\
; "information"; "Starts or stops recording of standard requests carried out by the 4D client machine that executed the command (excluding Web requests). By default, the value is 0 (no recording of requests)."; "scope"; "Remote 4D machine"))

$result.push(New object:C1471("method"; Konstant_getName(37; 46); "parameter"; Get database parameter:C643(Query by formula on server:K37:45); "keep"; False:C215; "pValues"; "0 (use database configuration), 1 (execute on client) or 2 (execute on server)"\
; "information"; "This difference in execution location influences not only application performance (execution on the server is usually faster) but also programming. "; "scope"; "Current table and process"))

$result.push(New object:C1471("method"; Konstant_getName(37; 47); "parameter"; Get database parameter:C643(Order by formula on server:K37:46); "keep"; False:C215; "pValues"; "0 (use database configuration), 1 (execute on client) or 2 (execute on server)"\
; "information"; "This difference in execution location influences not only application performance (execution on the server is usually faster) but also programming. "; "scope"; "Current table and process"))

$result.push(New object:C1471("method"; Konstant_getName(37; 48); "parameter"; Get database parameter:C643(Auto synchro resources folder:K37:48); "keep"; False:C215; "pValues"; "0 (no synchronization), 1 (auto synchronization) or 2 (ask)"\
; "information"; "When the contents of the Resources folder on the server has been modified or a user has requested synchronization, the server notifies the connected client machines."; "scope"; "4D remote machine"))

$result.push(New object:C1471("method"; Konstant_getName(37; 49); "parameter"; Get database parameter:C643(Query by formula joins:K37:47); "keep"; False:C215; "pValues"; "0 (use database configuration), 1 (always use automatic relations) or 2 (use SQL joins if possible)"\
; "information"; "With 4D in remote mode, \"SQL joins\" can only be used if the formulas are executed on the server"; "scope"; "Current process"))

$result.push(New object:C1471("method"; Konstant_getName(37; 53); "parameter"; Get database parameter:C643(Server base process stack size:K37:53); "keep"; False:C215; "pValues"; "Positive longint"\
; "information"; "Size of the stack allocated to each preemptive system process on the server, expressed in bytes. The default size is determined by the system."; "scope"; "4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 54); "parameter"; Get database parameter:C643(Idle connections timeout:K37:51); "keep"; False:C215\
; "pValues"; "Whole value expressing a duration in seconds. The value can be positive (new connections) or negative (existing connections). By default, the value is 20."\
; "information"; "Maximum period of inactivity (timeout) for connections to both the 4D database engine and the SQL engine, as well as, in ServerNet mode (new network layer), to the 4D application server."\
; "scope"; "4D application unless value is negative"))

$result.push(New object:C1471("method"; Konstant_getName(37; 55); "parameter"; Get database parameter:C643(PHP interpreter IP address:K37:59); "keep"; False:C215; "pValues"; "Formatted string of the type \"nnn.nnn.nnn.nnn\" (for example \"127.0.0.1\")"\
; "information"; " IP address used locally by 4D to communicate with the PHP interpreter via FastCGI. By default, the value is \"127.0.0.1\""; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 56); "parameter"; Get database parameter:C643(PHP interpreter port:K37:55); "keep"; False:C215; "pValues"; "Positive long integer type value. By default, the value is 8002."\
; "information"; "Number of the TCP port used by the PHP interpreter of 4D. Must be unique if multiple 4D run on the same machine."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 57); "parameter"; Get database parameter:C643(PHP number of children:K37:56); "keep"; False:C215; "pValues"; "Positive long integer type value. By default, the value is 5."\
; "information"; "Number of child processes to be created and maintained locally by the PHP interpreter of 4D. Ff the default port is 8002 and you launch 5 child processes, they will use ports 8002 to 8006."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 58); "parameter"; Get database parameter:C643(PHP max requests:K37:57); "keep"; False:C215; "pValues"; "Positive long integer type value. By default, the value is 500."\
; "information"; "Maximum number of requests accepted by the PHP interpreter. When this maximum number is reached, the interpreter returns errors of the \"server busy\" type."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 60); "parameter"; Get database parameter:C643(PHP use external interpreter:K37:58); "keep"; False:C215; "pValues"; "0 = use internal interpreter, 1 = use external interpreter"\
; "information"; "Value indicating whether PHP requests in 4D are sent to the internal interpreter provided by 4D or to an external interpreter. By default the value is 0."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 61); "parameter"; Get database parameter:C643(_o_Maximum temporary memory size:K37:52); "keep"; False:C215; "pValues"; "Positive longint"\
; "information"; "Maximum size of temporary memory that 4D can allocate to each process, expressed in MB. By default, the value is 0 (no maximum size)."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 64); "parameter"; Get database parameter:C643(SSL cipher list:K37:54); "keep"; False:C215; "pValues"; "Sequence of strings separated by colons (for example \"RC4-MD5:RC4-64-MD5:....\")"\
; "information"; "Cipher list used by 4D for the secure protocol. This list modifies the priority of ciphering algorithms implemented by 4D."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 66); "parameter"; Get database parameter:C643(Cache unload minimum size:K37:60); "keep"; False:C215; "pValues"; "Positive longint > 1"\
; "information"; "Minimum size of memory to release from the database cache when the engine needs to make space in order to allocate an object to it (value in bytes)"; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 69); "parameter"; Get database parameter:C643(Direct2D status:K37:61); "keep"; False:C215; "pValues"; "One of the following constants (mode 3 by default):\rDirect2D Disabled (0)\rDirect2D Hardware (1)\rDirect2D Software (3)"\
; "information"; "Starting with 4D v14, hybrid modes are disabled and redirected to available modes (the former mode 2 is equivalent to 1; former modes 4 and 5 are equivalent to mode 3)"; "scope"; "4D application "))

$result.push(New object:C1471("method"; Konstant_getName(37; 74); "parameter"; Get database parameter:C643(Direct2D get active status:K37:62); "keep"; False:C215; "pValues"; "0, 1, 2, 3, 4 or 5 "\
; "information"; "Returns active implementation of Direct2D under Windows. "; "scope"; "4D Application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 79); "parameter"; Get database parameter:C643(Diagnostic log recording:K37:69); "keep"; False:C215; "pValues"; "0 = do not record, 1 = record"\
; "information"; "Starts or stops recording of the 4D diagnostic file. By default, the value is 0 (do not record)."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 80); "parameter"; Get database parameter:C643(Log command list:K37:70); "keep"; False:C215\
; "pValues"; "String containing a list of 4D command numbers to record (separated by semi-colons) or \"all\" to record all the commands or \"\" (empty string) to record none of them. "\
; "information"; "List of 4D commands to record in the debugging file (see selector 34, Debug Log Recording). By default, all 4D commands are recorded."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 81); "parameter"; Get database parameter:C643(Spellchecker:K37:71); "keep"; False:C215; "pValues"; "0 (default) = native OS X spellchecker (Hunspell disabled), 1 = Hunspell spellcheck enabled. "\
; "information"; "Enables the Hunspell spellcheck under OS X. Under Windows, only the Hunspell spellcheck is available"; "scope"; "4D application"))

If ((Num:C11(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMineur)<=3) & (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DVersionR=True:C214) & (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMajeur=17))
	
	$result.push(New object:C1471("method"; Konstant_getName(37; 82); \
		"parameter"; Get database parameter:C643(_o_QuickTime support:K37:72); \
		"keep"; True:C214; \
		"pValues"; "0 (default) = QuickTime disabled, 1 = QuickTime enabled. "; \
		"information"; "4D starting with v14, by default QuickTime codecs are no longer supported."; \
		"scope"; "4D application"))
End if 

$result.push(New object:C1471("method"; Konstant_getName(37; 85); "parameter"; Get database parameter:C643(Dates inside objects:K37:73); "keep"; False:C215; "pValues"; "0 = ignore local time zone, 1 (default) = take time zone into account."\
; "information"; "By default, 4D dates converted to JSON format take the local time zone into account. "; "scope"; "Current process"))

$result.push(New object:C1471("method"; Konstant_getName(37; 87); "parameter"; Get database parameter:C643(Use legacy Network Layer:K37:75); "keep"; True:C214; "pValues"; "0 = do not use legacy layer, 1 = use legacy layer"\
; "information"; "Sets or gets the current status of the legacy network layer for client/server connections. The legacy network layer is obsolete beginning with 4D v14 R5 and should be replaced progressively in your applications with the ServerNet network layer. "; "scope"; "4D in local mode, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 88); "parameter"; Get database parameter:C643(SQL Server Port ID:K37:74); "keep"; True:C214; "pValues"; " 0 to 65535"\
; "information"; "Gets or sets the TCP port number used by the integrated SQL server of 4D in local mode or 4D Server. By default, the value is 19812."; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 90); "parameter"; Get database parameter:C643(Circular log limitation:K37:76); "keep"; False:C215; "pValues"; "Any integer value, 0 = keep all logs"\
; "information"; "Maximum number of files to keep in rotation for each type of log. By default, all files are kept."; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 92); "parameter"; Get database parameter:C643(Number of formulas in cache:K37:77); "keep"; False:C215; "pValues"; "Positive longints"\
; "information"; "Sets or gets the maximum number of formulas to be kept in the cache of formulas, which is used by the EXECUTE FORMULA command."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 95); "parameter"; Get database parameter:C643(Cache flush periodicity:K37:78); "keep"; False:C215; "pValues"; "longint > 1 (seconds)"\
; "information"; "Gets or sets the current cache flush periodicity, expressed in seconds. "; "scope"; "4D local, 4D Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 79); "parameter"; Get database parameter:C643(Tips enabled:K37:79); "keep"; False:C215; "pValues"; "0 = tips disabled, 1 = tips enabled (default)"\
; "information"; "Sets or gets the current display status of the tips for the 4D application. By default, tips are enabled."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 80); "parameter"; Get database parameter:C643(Tips delay:K37:80); "keep"; False:C215; "pValues"; "longint >= 0 (ticks)"\
; "information"; "Delay before tips are displayed once the mouse cursor has stopped in objects with attached help messages. Value is expressed in ticks (1/60th of a second). Default value is 45 ticks (0.75 seconds)."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 81); "parameter"; Get database parameter:C643(Tips duration:K37:81); "keep"; False:C215; "pValues"; "longint >= 60 (ticks)"\
; "information"; "Maximum display duration for a tip. Value is expressed in ticks (1/60th of a second). Default value is 720 ticks (12 seconds)."; "scope"; "4D application"))

$result.push(New object:C1471("method"; Konstant_getName(37; 82); "parameter"; Get database parameter:C643(Min TLS version:K37:82); "keep"; False:C215; "pValues"; "TLSv1_0, TLSv1_1, TLSv1_2"\
; "information"; "Used to specify the minimum Transport Layer Security (TLS) version, which provides data encryption and authentication between applications and servers."; "scope"; "4D Server, 4D Web Server and 4D SQL Server"))

$result.push(New object:C1471("method"; Konstant_getName(37; 90); "parameter"; Get database parameter:C643(Times inside objects:K37:90); "keep"; False:C215; "pValues"; "Times in seconds (0) (default), Times in milliseconds (1) "\
; "information"; "Defines the way time values are converted and stored within object properties and collection elements, as well as how they will be imported/exported in JSON and in Web areas. ORDA methods and SQL engine ignore this setting"; "scope"; "4D local, 4D Server"))

// SMTP Log
$result.push(New object:C1471("method"; Konstant_getName(37; 95); "parameter"; Get database parameter:C643(SMTP Log:K37:95); "keep"; False:C215; "pValues"; " 0 or from 1 to X (0 = do not record, 1 to X = sequential number, added to the file name). By default, the value is 0 (SMTP exchanges not recorded)."\
; "information"; "starts or stops the recording of exchanges between 4D and the SMTP server, when a transporter object is processed through transporter.send( ) or transporter.checkConnection( )"; "scope"; "4D local, 4D Server"))

// Current process debug log recording
$result.push(New object:C1471("method"; Konstant_getName(37; 97); \
"keep"; False:C215; \
"parameter"; Get database parameter:C643(Current process debug log recording:K37:97); \
"pValues"; "Starts or stops the sequential recording of programming events for the current process in a separated log file. "; \
"information"; "This selector is provided solely for the purpose of debugging and should be used with care. In particular, it must not put into production since it can have an impact on the application performance. \n"+\
"You can use both Debug log recording and Current "+"process debug log recording selectors simultaneously, in which case the current process actions will not be logged in the main log file."; \
"scope"; "4D application"))

// Is current database a project
$result.push(New object:C1471("method"; Konstant_getName(37; 98); "parameter"; Get database parameter:C643(Is current database a project:K37:98); "keep"; True:C214; "pValues"; " 0 for Binary, 1 for Project"\
; "information"; "You can only use this selector with the Get database parameter command and its value cannot be set."; "scope"; "4D application"))

// Is host database a project
$result.push(New object:C1471("method"; Konstant_getName(37; 99); "parameter"; Get database parameter:C643(Is host database a project:K37:99); "keep"; True:C214; "pValues"; " 0 for Binary, 1 for Project"\
; "information"; "You can only use this selector with the Get database parameter command and its value cannot be set."; "scope"; "4D application"))


// ******************** Listbox preparation

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "#")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 170)
				
			: ($i=2)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Scope")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 170)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Keep between\\2 sessions")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 90)
				
			: ($i=4)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Default value")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 80)
				
			: ($i=5)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Authorized values")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 250)
				
			: ($i=6)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Information")
				LISTBOX SET PROPERTY:C1440(*; "QS_Col_"+$tabPropertyNames{$i}; lk allow wordwrap:K53:39; lk yes:K53:69)
				LISTBOX SET PROPERTY:C1440(*; "QS_Col_"+$tabPropertyNames{$i}; lk truncate:K53:37; lk without ellipsis:K53:64)
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 1; 3)
	LB_ResizeLine($Listbox_Name)
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	displayInfo("")
End if 