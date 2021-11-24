//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 21/03/19, 17:17:20
  // Paramètres
  // ----------------------------------------------------
  // $0 : Collection created
  // ----------------------------------------------------
  // Méthode : TOOLS_get_TIPS_under_collection
  // Description
  // TODO: To update each time a new version is released
  // ----------------------------------------------------
  // Last update: 2018-04-19: Include V16R2/R3/R4/R5/R6


C_COLLECTION:C1488($QS_TBX_TIPS;$0)
$QS_TBX_TIPS:=New collection:C1472

  //  PAGE BREAK 
$QS_TBX_TIPS.push(New object:C1471("token";6;\
"request";Command name:C538(6);\
"tips";"For the "+Command name:C538(6)+"(*) command to operate correctly, it is preferable to choose the \"Start printing after last page is spooled\" property for the printer.";\
"type";"T"))

  // Substring  
$QS_TBX_TIPS.push(New object:C1471("token";12;\
"request";Command name:C538(12);\
"tips";Command name:C538(12)+": if use in a multi-style context, you need to convert any Window end-of-line characters ('\\r\\n') into single ('\\r') characters in order for processing to be valid.";\
"type";"T"))

  // Uppercase(xxxx) -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";13;\
"request";Command name:C538(13)+"\\(.*(?!;\\*\\)$)";\
"tips";Command name:C538(13)+", the optional * parameter indicates that any accented characters present in a String must be returned as accented uppercase characters.";\
"type";"T"))

  // Position
$QS_TBX_TIPS.push(New object:C1471("token";15;\
"request";Command name:C538(15);\
"tips";Command name:C538(15)+": You cannot use the @ wildcard character.";\
"type";"T"))

  // Position(xxxx) -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";15;\
"request";Command name:C538(15)+"\\(.*(?!;\\*\\)$)";\
"tips";Command name:C538(15)+", the optional * parameter indicates that any accented characters present in a String must be returned as accented uppercase characters.";\
"type";"T"))

  // Lenght
$QS_TBX_TIPS.push(New object:C1471("token";15;\
"request";Command name:C538(16);\
"tips";Command name:C538(16)+": when you want to check whether a string contains any characters, including ignorable characters, you must use the test If(Length(vtAnyText)=0) rather than If(vtAnyText=\"\")).";\
"type";"T"))

  // Before
$QS_TBX_TIPS.push(New object:C1471("token";29;\
"request";Command name:C538(29);\
"tips";Command name:C538(29)+" is equivalent to using Form event and testing whether it returns the On Load event.";\
"type";"W"))

  // After
$QS_TBX_TIPS.push(New object:C1471("token";31;\
"request";Command name:C538(29);\
"tips";Command name:C538(31)+" is equivalent to using Form event and testing whether it returns the On Validate event.";\
"type";"W"))

  // Modified
$QS_TBX_TIPS.push(New object:C1471("token";32;\
"request";Command name:C538(32);\
"tips";"During data entry, it is usually easier to perform operations in object methods using the 'Form event' command than to use "+Command name:C538(32)+" in form methods. Since an object method is sent an 'On Data Change' event whenever a field is modified, the use of an object method is equivalent to using "+Command name:C538(32)+" in a form method.";\
"type";"T"))

  // Current date (xxxx) -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";33;\
"request";Command name:C538(33)+"(?!\\(\\*\\)$)";\
"tips";Command name:C538(33)+", the optional * parameter returns the current date from the server.";\
"type";"T"))

  //  PRINT LABEL
$QS_TBX_TIPS.push(New object:C1471("token";29;\
"request";Command name:C538(29);\
"tips";Command name:C538(29)+": If the table has been declared \"invisible\" in Design mode, the Label Wizard will not be displayed.";\
"type";"W"))

  // PRINT LABEL 
$QS_TBX_TIPS.push(New object:C1471("token";39;\
"request";Command name:C538(39)+"\\(([^.*]*(?!;\\*\\))$)";\
"tips";"This command can be executed on 4D Server within the framework of a stored procedure.";\
"type";"Svr"))

  //  DIALOG
$QS_TBX_TIPS.push(New object:C1471("token";40;\
"request";Command name:C538(40);\
"tips";Command name:C538(40)+": If you do not pass the formData parameter or if you pass an undefined object, DIALOG automatically creates a new empty object bound to the form, available through the Form command.";\
"type";"T"))

  //   RELATE ONE  
$QS_TBX_TIPS.push(New object:C1471("token";42;\
"request";Command name:C538(42);\
"tips";Command name:C538(42)+" does not support Object type fields.";\
"type";"T"))

  //   DEFAULT TABLE  
$QS_TBX_TIPS.push(New object:C1471("token";46;\
"request";Command name:C538(46);\
"tips";Command name:C538(46)+" is simply a programming convenience to reduce the amount of typing and make the code easier to read.";\
"type";"T"))

  //  SELECT ALL - blabla - DELETE SELECTION - blabla - TRUNCATE TABLE 
$QS_TBX_TIPS.push(New object:C1471("token";1051;\
"request";Command name:C538(48)+"([^.]*)!"+Command name:C538(66)+"([^.]*)!"+Command name:C538(1051);\
"tips";"With "+Command name:C538(1051)+" you don't need to use "+Command name:C538(48)+" and "+Command name:C538(66)+" before.";\
"type";"T"))

  //   QUERY BY FORMULA 
$QS_TBX_TIPS.push(New object:C1471("token";48;\
"request";Command name:C538(48);\
"tips";Command name:C538(48)+" is executed on the server, which optimizes its execution. Note that when variables are called directly in the expression, the sort is calculated with the value of the variable on the client machine.";\
"type";"T"))

  //  SORT 
$QS_TBX_TIPS.push(New object:C1471("token";49;\
"request";Command name:C538(49);\
"tips";Command name:C538(339)+" does not support Object type fields.";\
"type";"T"))

  //  SORT - blabla - DISTINCT VALUES
$QS_TBX_TIPS.push(New object:C1471("token";339;\
"request";Command name:C538(49)+"([^.]*)!"+Command name:C538(339);\
"tips";"With "+Command name:C538(339)+", the elements in array are returned sorted in ascending order.";\
"type";"T"))

  //  FIRST RECORD - blabla - LOAD RECORD  
$QS_TBX_TIPS.push(New object:C1471("token";50;\
"request";Command name:C538(50)+"([^.]*)!"+Command name:C538(52);\
"tips";Command name:C538(50)+" automatically load the current record.";\
"type";"T"))

  //  NEXT RECORD - blabla - LOAD RECORD  
$QS_TBX_TIPS.push(New object:C1471("token";51;\
"request";Command name:C538(51)+"([^.]*)!"+Command name:C538(52);\
"tips";Command name:C538(51)+" automatically load the current record.";\
"type";"T"))

  //  LOAD RECORD  
$QS_TBX_TIPS.push(New object:C1471("token";52;\
"request";Command name:C538(52);\
"tips";"If the "+Command name:C538(52)+" command is executed after a "+Command name:C538(145)+", the record is automatically unloaded and loaded without having to use the "+Command name:C538(212)+" command.";\
"type";"T"))

  //  SAVE RECORD  
$QS_TBX_TIPS.push(New object:C1471("token";53;\
"request";Command name:C538(53);\
"tips";"You should not execute a "+Command name:C538(53)+" during the On Validate event for a form that has been accepted. If you do, the record will be saved twice.";\
"type";"N"))

  // FORM SET OUTPUT
$QS_TBX_TIPS.push(New object:C1471("token";54;\
"request";Command name:C538(54);\
"tips";Command name:C538(54)+" For structural reasons, this command is not compatible with project forms.";\
"type";"N"))

  // FORM SET INPUT
$QS_TBX_TIPS.push(New object:C1471("token";55;\
"request";Command name:C538(55);\
"tips";Command name:C538(55)+" For structural reasons, this command is not compatible with project forms.";\
"type";"N"))

  //  PRINT SELECTION 
$QS_TBX_TIPS.push(New object:C1471("token";60;\
"request";Command name:C538(60);\
"tips";Command name:C538(60)+": Do not use the "+Command name:C538(6)+" command. This command is exclusively reserved for use in combination with the "+Command name:C538(5)+" command.";\
"type";"W"))

  //  DELETE SELECTION  
$QS_TBX_TIPS.push(New object:C1471("token";66;\
"request";Command name:C538(66);\
"tips";Command name:C538(66)+" is a permanent operation and cannot be undone.";\
"type";"W"))

  //  SET MENU BAR ( menuBar {; process}{; *} )     -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";67;\
"request";Command name:C538(67)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";"The optional * parameter allows you to save the state of the menu bar. If this parameter is omitted, "+Command name:C538(67)+" reinitializes the menu bar when the command is executed.";\
"type";"T"))

  //  APPLY TO SELECTION  
$QS_TBX_TIPS.push(New object:C1471("token";70;\
"request";Command name:C538(70);\
"tips";"The progress thermometer is displayed while "+Command name:C538(70)+" is executing. To hide it, use "+Command name:C538(175)+" prior to the call to "+Command name:C538(70)+". If the progress thermometer is displayed, the user can cancel the operation.";\
"type";"T"))

  //  APPLY TO SELECTION  
$QS_TBX_TIPS.push(New object:C1471("token";70;\
"request";Command name:C538(70);\
"tips";"The server does not execute any of the commands that may be passed in statement. Every record in the selection will be sent back to the local workstation to be modified.";\
"type";"Svr"))

  //  PRINT RECORD 
$QS_TBX_TIPS.push(New object:C1471("token";71;\
"request";Command name:C538(71);\
"tips";Command name:C538(71)+": do not use the "+Command name:C538(6)+" command. This command is exclusively reserved for use in combination with the "+Command name:C538(5)+" command.";\
"type";"W"))

  // PRINT RECORD 
$QS_TBX_TIPS.push(New object:C1471("token";71;\
"request";Command name:C538(71);\
"tips";"This command can be executed on 4D Server within the framework of a stored procedure. In this context, make sure that no dialog box appears on the server machine(except for a specific requirement).";\
"type";"Svr"))

  //  LOAD VARIABLES
$QS_TBX_TIPS.push(New object:C1471("token";74;\
"request";Command name:C538(74);\
"tips";Command name:C538(74)+" does not support array variables. Use the new BLOB commands instead.";\
"type";"W"))

  //  SAVE VARIABLES
$QS_TBX_TIPS.push(New object:C1471("token";75;\
"request";Command name:C538(75);\
"tips";Command name:C538(75)+" does not support array variables. Use the new BLOB commands instead.";\
"type";"W"))

  //  Subtotal 
$QS_TBX_TIPS.push(New object:C1471("token";97;\
"request";Command name:C538(97);\
"tips";"If you execute "+Command name:C538(97)+" from within an output form displayed at the screen, an error will be generated, triggering an infinite loop of updates between the form and the error window. To get out of this loop, press Alt+Shift (Windows) or Option-Shift (Macintosh) when you clic"+"k on the Abort button in the Error window (you may have to do so several times).";\
"type";"T"))

  //  Date 
$QS_TBX_TIPS.push(New object:C1471("token";102;\
"request";Command name:C538(102);\
"tips";"As of 4D v16 R6, dates can be stored in object attributes as date type values. ";\
"type";"T"))

  //  PREVIOUS RECORD - blabla - LOAD RECORD  
$QS_TBX_TIPS.push(New object:C1471("token";110;\
"request";Command name:C538(110)+"([^.]*)!"+Command name:C538(52);\
"tips";Command name:C538(110)+" automatically load the current record.";\
"type";"T"))

  // In header
$QS_TBX_TIPS.push(New object:C1471("token";112;\
"request";Command name:C538(112);\
"tips";Command name:C538(112)+" is equivalent to using Form event and testing whether it returns the On Header event.";\
"type";"W"))

  // In Break
$QS_TBX_TIPS.push(New object:C1471("token";113;\
"request";Command name:C538(113);\
"tips";Command name:C538(113)+" is equivalent to using Form event and testing whether it returns the On Printing Break event.";\
"type";"W"))

  // USE SET  
$QS_TBX_TIPS.push(New object:C1471("token";118;\
"request";Command name:C538(118);\
"tips";Command name:C538(118)+": Remember that a set is a representation of a selection of records at the moment that the set is created.";\
"type";"W"))

  // UNION 
$QS_TBX_TIPS.push(New object:C1471("token";120;\
"request";Command name:C538(120);\
"tips";"Sets are 'visible' depending on their type (interprocess, process and local) and where they were created (server or client).";\
"type";"Svr"))

  // CREATE EMPTY SET   
$QS_TBX_TIPS.push(New object:C1471("token";140;\
"request";Command name:C538(140);\
"tips";"You do not need to use "+Command name:C538(140)+" before using "+Command name:C538(116)+".";\
"type";"T"))

  // Semaphore  
$QS_TBX_TIPS.push(New object:C1471("token";143;\
"request";Command name:C538(143);\
"tips";Command name:C538(143)+": If you use a global semaphores in this case, it would not only cause unnecessary network exchanges but could also affect other client machines unnecessarily.";\
"type";"T"))

  // READ ONLY 
$QS_TBX_TIPS.push(New object:C1471("token";145;\
"request";Command name:C538(145);\
"tips";Command name:C538(145)+" is not retroactive. To load a record from a read/write table in read-only mode, you must first change the table state to read-only.";\
"type";"T"))

  // READ WRITE 
$QS_TBX_TIPS.push(New object:C1471("token";146;\
"request";Command name:C538(146);\
"tips";Command name:C538(146)+" is not retroactive. To load a record from a read-only table in read/write mode, you must first change the table state to read/write.";\
"type";"T"))

  // Locked 
$QS_TBX_TIPS.push(New object:C1471("token";147;\
"request";Command name:C538(147);\
"tips";Command name:C538(147)+" returns False when there is no current record in table, in other words, when "+Command name:C538(243)+" returns -1.";\
"type";"T"))

  // DISABLE MENU ITEM  
$QS_TBX_TIPS.push(New object:C1471("token";149;\
"request";Command name:C538(149);\
"tips";Command name:C538(149)+": To enable all items of a menu at once, pass 0 (zero) in menuItem.";\
"type";"T"))

  // DISABLE MENU ITEM  
$QS_TBX_TIPS.push(New object:C1471("token";150;\
"request";Command name:C538(150);\
"tips";Command name:C538(150)+": To disable all items of a menu at once, pass 0 (zero) in menuItem.";\
"type";"T"))

  // Menu selected 
$QS_TBX_TIPS.push(New object:C1471("token";152;\
"request";Command name:C538(152);\
"tips";"Whenever possible, use methods associated with menu commands in an associated menu bar (with a negative menu bar number) instead of using "+Command name:C538(152)+".";\
"type";"T"))

  // ABORT
$QS_TBX_TIPS.push(New object:C1471("token";156;\
"request";Command name:C538(156);\
"tips";"4D does not recommend the use of "+Command name:C538(156)+" in methods other than error-handling methods.";\
"type";"W"))

  // TRACE
$QS_TBX_TIPS.push(New object:C1471("token";157;\
"request";Command name:C538(157);\
"tips";"Do not place TRACE calls when using a form whose On Activate and On Deactivate events have been enabled. you will then loop infinitely between these events and the debugger window. If you end up in this situation, Shift+click on the No Trace button of"+" the debugger in order to get out of it.";\
"type";"W"))

  // Request
$QS_TBX_TIPS.push(New object:C1471("token";163;\
"request";Command name:C538(163);\
"tips";"Do not call the "+Command name:C538(163)+" command from the section of a form or object method that handles the On Activate or On Deactivate form event; this will cause an endless loop.";\
"type";"W"))

  // Current time (xxxx) -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";178;\
"request";Command name:C538(178)+"(?!\\(\\*\\)$)";\
"tips";Command name:C538(178)+", the optional * parameter returns the current time from the server.";\
"type";"T"))

  // SAVE SET 
$QS_TBX_TIPS.push(New object:C1471("token";184;\
"request";Command name:C538(184);\
"tips";Command name:C538(184)+": Remember that a set is a representation of a selection of records at the moment that the set is created.";\
"type";"W"))

  // In footer
$QS_TBX_TIPS.push(New object:C1471("token";191;\
"request";Command name:C538(191);\
"tips";Command name:C538(191)+" is equivalent to using Form event and testing whether it returns the On Printing footer event.";\
"type";"W"))

  //  LAST RECORD - blabla - LOAD RECORD  
$QS_TBX_TIPS.push(New object:C1471("token";200;\
"request";Command name:C538(200)+"([^.]*)!"+Command name:C538(52);\
"tips";Command name:C538(200)+" automatically load the current record.";\
"type";"T"))

  //  UNLOAD RECORD 
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212);\
"tips";"When it is used in a transaction, the "+Command name:C538(212)+" command unloads the current record only for the process that manages the transaction. For other processes, the record stays locked as long as the transaction has not been validated (or cancelled).";\
"type";"T"))

  //  UNLOAD RECORD - blabla - QUERY BY FORMULA
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(48);\
"tips";"With "+Command name:C538(48)+", the first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - ORDER BY
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(49);\
"tips";"With "+Command name:C538(49)+", the new first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - FIRST RECORD
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(50);\
"tips";"With "+Command name:C538(50)+", the first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - NEXT RECORD
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(51);\
"tips";"With "+Command name:C538(51)+", the next record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - PREVIOUS RECORD
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(110);\
"tips";"With "+Command name:C538(110)+", the previous record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - LAST RECORD
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(200);\
"tips";"With "+Command name:C538(200)+", the last record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - QUERY SELECTION BY FORMULA
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(207);\
"tips";"With "+Command name:C538(207)+", the first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - QUERY
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(277);\
"tips";"With "+Command name:C538(277)+", the first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - QUERY SELECTION
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(341);\
"tips";"With "+Command name:C538(341)+", the first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - REDUCE SELECTION(0) 
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)!"+Command name:C538(351)+"\\(0\\)";\
"tips";"When "+Command name:C538(351)+"(0) is executed, there is no longer any selection nor any current records in the table. No need to use "+Command name:C538(212)+"before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - QUERY BY SQL
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(942);\
"tips";"With "+Command name:C538(207)+", the first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  //  UNLOAD RECORD - blabla - QUERY BY ATTRIBUTE
$QS_TBX_TIPS.push(New object:C1471("token";212;\
"request";Command name:C538(212)+"([^.]*)"+Command name:C538(1331);\
"tips";"With "+Command name:C538(1331)+", the first record of the selection becomes the current record. Do not use "+Command name:C538(212)+" just before.";\
"type";"T"))

  // Replace string ( source ; oldString ; newString {; howMany}{; *} ) -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";233;\
"request";Command name:C538(233)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(233)+", when the * parameter is passed, comparisons will be based on character codes.";\
"type";"T"))

  //  VALIDATE TRANSACTION  
$QS_TBX_TIPS.push(New object:C1471("token";240;\
"request";Command name:C538(240);\
"tips";Command name:C538(240)+": if the main transaction is cancelled, all the sub-transactions are cancelled as well, even if they have been validated individually using this command.";\
"type";"T"))

  //  CANCEL TRANSACTION  
$QS_TBX_TIPS.push(New object:C1471("token";241;\
"request";Command name:C538(241);\
"tips";Command name:C538(241)+": if the main transaction is cancelled, all the sub-transactions are cancelled as well, even if they have been validated individually using this command.";\
"type";"T"))

  //  Record number   
$QS_TBX_TIPS.push(New object:C1471("token";243;\
"request";Command name:C538(243);\
"tips";"This command returns a different result for the On Validate form event depending on whether it is executed on 4D in local mode or 4D in remote mode. In local mode, the command returns a record number (the record is considered as already created). In r"+"emote mode, the command returns -3 because, in this case, the record is already created on the server but the information has not yet been sent to the client.";\
"type";"Svr"))

  // FORM GOTO PAGE ( pageNumber {; *} )  -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";247;\
"request";Command name:C538(247)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(247)+", when the * parameter is passed, it changes page of current subform.";\
"type";"T"))

  // SELECTION TO ARRAY   -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";260;\
"request";Command name:C538(260)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(260)+", when you pass the * parameter, 4D does not execute the corresponding statement line immediately but instead stores it in memory. All of these lines awaiting execution are executed by one final "+Command name:C538(260)+" statement that does not have the * parameter.";\
"type";"T"))

  // ARRAY TO SELECTION -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";261;\
"request";Command name:C538(261)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(261)+", when you pass the * parameter, 4D does not execute the corresponding statement line immediately but instead stores it in memory. All of these lines awaiting execution are executed by one final "+Command name:C538(260)+" statement that does not have the * parameter.";\
"type";"T"))

  // ARRAY TO SELECTION 
$QS_TBX_TIPS.push(New object:C1471("token";261;\
"request";Command name:C538(261);\
"tips";"If a record is locked by another process during the execution of "+Command name:C538(261)+", that record is not modified. Any locked records are put into the process set called LockedSet.";\
"type";"W"))

  // ARRAY TO SELECTION 
$QS_TBX_TIPS.push(New object:C1471("token";261;\
"request";Command name:C538(261);\
"tips";"The command is optimized for 4D Server. Arrays are sent by the client machine to the server, and the records are modified or created on the server machine.";\
"type";"Svr"))

  //  RELATE MANY  
$QS_TBX_TIPS.push(New object:C1471("token";262;\
"request";Command name:C538(262);\
"tips";Command name:C538(262)+" does not support Object type fields.";\
"type";"T"))

  //  SET TIMEOUT (xx) - blabla - SET TIMEOUT (0)
$QS_TBX_TIPS.push(New object:C1471("token";268;\
"request";Command name:C538(268)+"([^.]*)!"+Command name:C538(268)+"\\(0\\)";\
"tips";"With "+Command name:C538(268)+", to cancel a previous setting and stop monitoring serial port communication, call "+Command name:C538(268)+" again with limit equal to 0.";\
"type";"T"))

  // OBJECT SET COLOR 
$QS_TBX_TIPS.push(New object:C1471("token";271;\
"request";Command name:C538(271);\
"tips";Command name:C538(628)+"is recommanded instead of "+Command name:C538(271);\
"type";"T"))  // 628 = OBJECT SET RGB COLORS 

  //  FORM Get current page  (*) -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";276;\
"request";Command name:C538(276)+"\\(.*(?!;\\*\\)$))";\
"tips";Command name:C538(13)+", the optional * parameter is useful when the command is called in the context of a page type subform containing several pages.";\
"type";"T"))

  //   EDIT ACCESS  
$QS_TBX_TIPS.push(New object:C1471("token";281;\
"request";Command name:C538(281);\
"tips";Command name:C538(281)+" opens a modal window so you must not call it from another modal window; if you do, it will not do anything.";\
"type";"T"))

  //   ARRAY TO LIST   
$QS_TBX_TIPS.push(New object:C1471("token";287;\
"request";Command name:C538(287);\
"tips";Command name:C538(287)+" cannot be used in a component with a choice list because they are loaded with their structure as read only.";\
"type";"T"))

  //   CHANGE CURRENT USER  
$QS_TBX_TIPS.push(New object:C1471("token";289;\
"request";Command name:C538(289);\
"tips";"The access control system must be enabled in order to use "+Command name:C538(289)+", i.e. a password must have been assigned to the Designer.";\
"type";"T"))

  //   ORDER BY FORMULA
$QS_TBX_TIPS.push(New object:C1471("token";300;\
"request";Command name:C538(300);\
"tips";Command name:C538(300)+" is executed on the server, which optimizes its execution. Note that when variables are called directly in the expression, the sort is calculated with the value of the variable on the client machine.";\
"type";"T"))

  //  command\sname(1124)(object\scurrent:K67:2)+
$QS_TBX_TIPS.push(New object:C1471("token";308;\
"request";Command name:C538(308);\
"tips";Command name:C538(308)+" is kept only for compatibility reasons. It is recommended to use the "+Command name:C538(1124)+" command.";\
"type";"W"))

  //  SET AUTOMATIC RELATIONS  
$QS_TBX_TIPS.push(New object:C1471("token";310;\
"request";Command name:C538(310);\
"tips";"When you pass True to the "+Command name:C538(310)+" command, the automatic mode is \"locked\" for all the manual relations during the session. In this case, any calls to the "+Command name:C538(919)+" command during the same session are ignored, regardless of whether they are placed before or after SET AUTOMATIC RELATIONS. To \"unlock\" the automatic mode and take the calls to "+Command name:C538(310)+" into account, pass False to "+Command name:C538(310)+".";\
"type";"T"))

  // New process 
$QS_TBX_TIPS.push(New object:C1471("token";317;\
"request";Command name:C538(317)+"\\(([^.*]*(?!;\\*\\))$)";\
"tips";"Specifying this last parameter tells 4D to first check whether or not a process with the name you passed in name is already running. If it is, 4D does not start a new process and returns the process number of the process with that name.";\
"type";"Svr"))


  //  FILTER EVENT  
$QS_TBX_TIPS.push(New object:C1471("token";321;\
"request";Command name:C538(321);\
"tips";"When you have an event-handling method with only the "+Command name:C538(321)+" command, type Ctrl+Shift+Backspace (on Windows) or Command-Option-Shift-Control-Backspace (on Macintosh). This converts the On Event Call process into a normal process that does not get any events at all.";\
"type";"T"))

  // BRING TO FRONT   
$QS_TBX_TIPS.push(New object:C1471("token";326;\
"request";Command name:C538(326);\
"tips";Command name:C538(326)+": When the process contains several windows and you want to pass a specific one to the front, it is preferable to use, for example, the "+Command name:C538(444)+" command.";\
"type";"T"))

  //  CALL PROCESS  
$QS_TBX_TIPS.push(New object:C1471("token";329;\
"request";Command name:C538(329);\
"tips";Command name:C538(321)+": The On Outside call event modifies the entry context of the receiving input form. In particular, if a field was being edited, the On Data change event is generated.";\
"type";"T"))

  // USE NAMED SELECTION  
$QS_TBX_TIPS.push(New object:C1471("token";332;\
"request";Command name:C538(332);\
"tips";Command name:C538(332)+": a named selection is a representation of a selection of records at the moment that the named selection is created.";\
"type";"W"))

  //  CUT NAMED SELECTION  
$QS_TBX_TIPS.push(New object:C1471("token";334;\
"request";Command name:C538(334);\
"tips";Command name:C538(334)+" is more memory efficient than '"+Command name:C538(331)+"'.";\
"type";"W"))

  //   RELATE MANY SELECTION   
$QS_TBX_TIPS.push(New object:C1471("token";340;\
"request";Command name:C538(340);\
"tips";Command name:C538(340)+" changes the current record for the One table.";\
"type";"T"))


  //    SET INDEX  
$QS_TBX_TIPS.push(New object:C1471("token";344;\
"request";Command name:C538(344);\
"tips";Command name:C538(344)+": A B-Tree index associated with a Text type field stores the first 1024 characters of the field (maximum). Therefore in this context, searches for strings containing more than 1024 characters will fail.";\
"type";"T"))


  // Activated
$QS_TBX_TIPS.push(New object:C1471("token";346;\
"request";Command name:C538(346);\
"tips";"Obsolete. Must be replace by 'On Activate' during a Form Event management. Do not place a command such as TRACE or ALERT in the Activated phase of the form, as this will cause an endless loop.";\
"type";"W"))


  // Deactivated
$QS_TBX_TIPS.push(New object:C1471("token";347;\
"request";Command name:C538(347);\
"tips";Command name:C538(347)+" is equivalent to using Form event and testing whether it returns the On Deactivate event.";\
"type";"W"))


  // SET MENU ITEM ( menu ; menuItem ; itemText {; process}{; *} ) -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";348;\
"request";Command name:C538(348)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(348)+", if you do not pass the * parameter, any \"special\" characters included in itemText (such as ( ; or !) will be considered as instruction characters (metacharacters).";\
"type";"T"))


  // SCAN INDEX   
$QS_TBX_TIPS.push(New object:C1471("token";350;\
"request";Command name:C538(350);\
"tips";Command name:C538(350)+" does not support Object type fields.";\
"type";"T"))


  // REDUCE SELECTION 
$QS_TBX_TIPS.push(New object:C1471("token";351;\
"request";Command name:C538(351);\
"tips";"If the statement "+Command name:C538(351)+"(0) is executed, there is no longer any selection nor any current records in the aTable.";\
"type";"T"))


  // Execute on server 
$QS_TBX_TIPS.push(New object:C1471("token";373;\
"request";Command name:C538(373)+"\\(([^.*]*(?!;\\*\\))$)";\
"tips";"Specifying this last parameter tells 4D to first check whether or not a process with the name you passed in name is already running.";\
"type";"Svr"))


  //  CLEAR LIST ( list {; *} )  -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";377;\
"request";Command name:C538(377)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(377)+", when the * parameter is passed, clear sublists from memory, if any. If omitted, sublists (if any) are not cleared.";\
"type";"T"))


  //   Count list items ( {* ;} list {; *} )  -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";377;\
"request";Command name:C538(377)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(377)+", when the * parameter is passed, return all list items. If omitted, return visible list items (expanded).";\
"type";"T"))


  //   GET LIST ITEM ( {* ;} list ; itemPos | * ; itemRef ; itemText {; sublist ; expanded} )   -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";378;\
"request";Command name:C538(378)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(378)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //    Selected list items ( {* ;} list {; itemsArray {; *}} )    -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";379;\
"request";Command name:C538(379)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(379)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //   SELECT LIST ITEMS BY POSITION ( {* ;} list ; itemPos {; positionsArray} )   -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";381;\
"request";Command name:C538(381)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(381)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //  SET QUERY LIMIT(xx)
$QS_TBX_TIPS.push(New object:C1471("token";395;\
"request";Command name:C538(395);\
"tips";Command name:C538(395)+" affects ALL the subsequent queries made within the current process. REMEMBER to always counterbalance a call to "+Command name:C538(395)+"(limit) (where limit>0) with a call to "+Command name:C538(395)+"(0) in order to restore queries with no limit.";\
"type";"W"))


  //  SET QUERY LIMIT(xx) - blabla - SET QUERY LIMIT(0)
$QS_TBX_TIPS.push(New object:C1471("token";395;\
"request";Command name:C538(395)+"([^.]*)!"+Command name:C538(395)+"\\(0\\)";\
"tips";"With "+Command name:C538(395)+", to restore queries with no limit, call "+Command name:C538(395)+" again with limit equal to 0.";\
"type";"T"))


  //  Create menu       
$QS_TBX_TIPS.push(New object:C1471("token";408;\
"request";Command name:C538(408);\
"tips";Command name:C538(408)+": If you pass an invalid value in menu, a blank menu is created.";\
"type";"W"))


  //  APPEND MENU ITEM     
$QS_TBX_TIPS.push(New object:C1471("token";411;\
"request";Command name:C538(411);\
"tips";Command name:C538(411)+" is obsolete.   Use menus that have a reasonable number of items.";\
"type";"T"))


  //  APPEND MENU ITEM     
$QS_TBX_TIPS.push(New object:C1471("token";411;\
"request";Command name:C538(411);\
"tips";Command name:C538(411)+": if it was created with the * option (last position), metacharacters as !(-; will be returned as standard characters.";\
"type";"T"))


  // INSERT MENU ITEM
$QS_TBX_TIPS.push(New object:C1471("token";412;\
"request";Command name:C538(412);\
"tips";Command name:C538(412)+": the new items do not have any associated methods or actions.";\
"type";"T"))


  // INSERT MENU ITEM
$QS_TBX_TIPS.push(New object:C1471("token";412;\
"request";Command name:C538(412);\
"tips";Command name:C538(412)+": If you pass a MenuRef in menu, the process parameter serves no purpose and will be ignored.";\
"type";"T"))


  //  Get menu item key    
$QS_TBX_TIPS.push(New object:C1471("token";424;\
"request";Command name:C538(424);\
"tips";"If the menu item has no associated shortcut or if the menuItem parameter designates a hierarchical submenu, "+Command name:C538(424)+" returns 0 (zero).";\
"type";"T"))


  //  Get menu item style      
$QS_TBX_TIPS.push(New object:C1471("token";426;\
"request";Command name:C538(426);\
"tips";Command name:C538(426)+" returns a combination (one or a sum) of the following predefined constants.";\
"type";"T"))


  //  HIDE TOOL BAR       
$QS_TBX_TIPS.push(New object:C1471("token";434;\
"request";Command name:C538(434);\
"tips";Command name:C538(434)+": On OS X, you have defined a custom toolbar and a standard window that has the Has full screen mode Mac option. When a standard window is maximized by a user while the toolbar window is displayed, you do not want the toolbar to overlap the maximized "+"window.";\
"type";"T"))


  //  SET WINDOW RECT        
$QS_TBX_TIPS.push(New object:C1471("token";444;\
"request";Command name:C538(444);\
"tips";Command name:C538(444)+": Be aware that by using this command, you may move a window beyond the limits of the main window (on Windows) or of the screens (on Macintosh).";\
"type";"T"))


  //  REDRAW WINDOW       
$QS_TBX_TIPS.push(New object:C1471("token";456;\
"request";Command name:C538(456);\
"tips";Command name:C538(456)+": 4D handles the graphical updates of the windows each time you move a window, resize it, or bring it to the front, as well as when you change the form and/or the values displayed in the window. You will rarely use this command.";\
"type";"T"))


  //  FONT LIST
$QS_TBX_TIPS.push(New object:C1471("token";460;\
"request";Command name:C538(460);\
"tips";"Under OS X, if you use the result of "+Command name:C538(460)+" with the ST SET ATTRIBUTES, you must not pass the * parameter.";\
"type";"W"))


  //  _o_Mac to Win   
$QS_TBX_TIPS.push(New object:C1471("token";463;\
"request";Command name:C538(463);\
"tips";Command name:C538(463)+" is obsolete.  It is recommended to convert character strings using the "+Command name:C538(1011)+" or "+Command name:C538(1012)+" commands.";\
"type";"W"))


  //  _o_Win to Mac   
$QS_TBX_TIPS.push(New object:C1471("token";464;\
"request";Command name:C538(464);\
"tips";Command name:C538(464)+" is obsolete. It is recommended to convert character strings using the "+Command name:C538(1011)+" or "+Command name:C538(1012)+" commands.";\
"type";"W"))


  //   FOLDER LIST     
$QS_TBX_TIPS.push(New object:C1471("token";473;\
"request";Command name:C538(473);\
"tips";Command name:C538(473)+": the pathname parameter only accepts absolute pathnames.";\
"type";"T"))


  //   GestAlt     
$QS_TBX_TIPS.push(New object:C1471("token";488;\
"request";Command name:C538(488);\
"tips";Command name:C538(488)+": The Gestalt Manager is part of Mac OS. On Windows, some of the selectors are also implemented, but the usefulness of this command is limited.";\
"type";"W"))


  //  Open resource file     
$QS_TBX_TIPS.push(New object:C1471("token";497;\
"request";Command name:C538(497);\
"tips";Command name:C538(494)+": Use the range 15,000..32,767 for your own resources. Remember that once you have opened a resource file, it will be the first file to be searched in the resource files chain.";\
"type";"W"))


  //  Open resource file     
$QS_TBX_TIPS.push(New object:C1471("token";497;\
"request";Command name:C538(497);\
"tips";Command name:C538(494)+": Resource files are highly structured files and cannot accept more than 2,700 resources per file.";\
"type";"W"))


  //  _o_Mac to ISO  
$QS_TBX_TIPS.push(New object:C1471("token";511;\
"request";Command name:C538(511);\
"tips";Command name:C538(511)+": Limit your use of string list resources to those up to 32K in total size, and a maximum of a few hundred strings per resource.";\
"type";"T"))


  //  _o_Mac to ISO  
$QS_TBX_TIPS.push(New object:C1471("token";519;\
"request";Command name:C538(519);\
"tips";Command name:C538(519)+" is obsolete.  It is recommended to convert character strings using the "+Command name:C538(1011)+" or "+Command name:C538(1012)+" commands.";\
"type";"W"))


  //  _o_ISO to Mac  
$QS_TBX_TIPS.push(New object:C1471("token";520;\
"request";Command name:C538(520)+"\\(";\
"tips";Command name:C538(520)+" is obsolete.  It is recommended to convert character strings using the "+Command name:C538(1011)+" or "+Command name:C538(1012)+" commands.";\
"type";"W"))


  //  BLOB TO VARIABLE  
$QS_TBX_TIPS.push(New object:C1471("token";533;\
"request";Command name:C538(533);\
"tips";Command name:C538(533)+" supports object and collection variables of the C_OBJECT and C_COLLECTION types. "+Command name:C538(1011)+" or "+Command name:C538(1012)+" commands.";\
"type";"W"))


  //  MOVE DOCUMENT   
$QS_TBX_TIPS.push(New object:C1471("token";540;\
"request";Command name:C538(540);\
"tips";Command name:C538(540)+": you can move a document from and to any directory on the same volume. If you want to move a document between two distinct volumes, use "+Command name:C538(541)+" to 'move' the document then delete the original copy of the document using "+Command name:C538(159)+".";\
"type";"W"))


  //  SET PICTURE TO LIBRARY   
$QS_TBX_TIPS.push(New object:C1471("token";566;\
"request";Command name:C538(566);\
"tips";Command name:C538(566)+" cannot be used from within a method executed on the server machine (stored procedure or trigger). If you call it on a server machine, nothing happens and the call is ignored.";\
"type";"Svr"))


  //  REMOVE PICTURE FROM LIBRARY   
$QS_TBX_TIPS.push(New object:C1471("token";567;\
"request";Command name:C538(567);\
"tips";Command name:C538(567)+" cannot be used from within a method executed on the server machine (stored procedure or trigger). If you call it on a server machine, nothing happens and the call is ignored.";\
"type";"Svr"))


  //  Set group properties    
$QS_TBX_TIPS.push(New object:C1471("token";612;\
"request";Command name:C538(612);\
"tips";Command name:C538(612)+": To revoke all the memberships of a user, pass an empty memberships array.";\
"type";"T"))


  //  Set user properties    
$QS_TBX_TIPS.push(New object:C1471("token";614;\
"request";Command name:C538(614);\
"tips";Command name:C538(614)+": The group owner is not automatically set as a member of the group that he or she owns. It is up to you to include the group owner in the group, using the members parameter.";\
"type";"T"))


  //  SET REAL COMPARISON LEVEL  
$QS_TBX_TIPS.push(New object:C1471("token";623;\
"request";Command name:C538(623);\
"tips";"With "+Command name:C538(623)+" command, changing the epsilon only affects real comparison for equality. It has no effect on other real computations nor on the display of real values.";\
"type";"W"))


  //  DELETE FROM LIST ( {* ;} list ; itemRef | * {; *} )    -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";624;\
"request";Command name:C538(624)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(624)+", when the last * parameter is passed, erases sublists (if any) from memory. If omitted, sublists (if any) are not erased.";\
"type";"T"))


  //  Current form table 
$QS_TBX_TIPS.push(New object:C1471("token";627;\
"request";Command name:C538(627);\
"tips";"If there are several windows open for the current process, "+Command name:C538(627)+" returns the pointer to the table of the form displayed in the active window.";\
"type";"T"))


  // List item position ( {* ;} list ; itemRef )  -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";629;\
"request";Command name:C538(629)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(629)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //  SELECT LIST ITEMS BY REFERENCE ( list ; itemRef {; refArray} )   -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";630;\
"request";Command name:C538(630)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(630)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))



  // GET LIST ITEM PROPERTIES({*;}list;itemRef | *;enterable{;styles{;icon{;color}}}) -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";631;\
"request";Command name:C538(631)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(631)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  // List item parent ( {* ;} list ; itemRef | * ) -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";633;\
"request";Command name:C538(633)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(633)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  // CREATE SELECTION FROM ARRAY    
$QS_TBX_TIPS.push(New object:C1471("token";640;\
"request";Command name:C538(640);\
"tips";"With an array of booleans, '"+Command name:C538(640)+"' uses elements from numbers 0 to N-1.";\
"type";"T"))


  // CREATE SET FROM ARRAY     
$QS_TBX_TIPS.push(New object:C1471("token";641;\
"request";Command name:C538(641);\
"tips";"With an array of booleans, '"+Command name:C538(641)+"' this command uses the elements from 0 to N-1.";\
"type";"T"))


  // QUERY WITH ARRAY     
$QS_TBX_TIPS.push(New object:C1471("token";644;\
"request";Command name:C538(644);\
"tips";"With '"+Command name:C538(644)+"', targetField and array must be of the same data type. Exception: you can use a Longint array with a field of the Time type.";\
"type";"T"))


  // Set timer  
$QS_TBX_TIPS.push(New object:C1471("token";645;\
"request";Command name:C538(645);\
"tips";"When the "+Command name:C538(645)+" command is executed in the context of a subform (form method of the subform), the On Timer event is generated in the subform and not at the parent form level.";\
"type";"T"))


  //  EXECUTE ON CLIENT 
$QS_TBX_TIPS.push(New object:C1471("token";651;\
"request";Command name:C538(651);\
"tips";Command name:C538(651)+": The stacking of the execution orders cannot be modified or stopped unless 4D Client is unregistered by using the "+Command name:C538(649)+" command.";\
"type";"T"))


  //  Find in field 
$QS_TBX_TIPS.push(New object:C1471("token";653;\
"request";Command name:C538(653);\
"tips";Command name:C538(653)+" doesn’t modify the current selection or the current record.";\
"type";"T"))


  //  WEB SET HTTP HEADER  
$QS_TBX_TIPS.push(New object:C1471("token";660;\
"request";Command name:C538(660);\
"tips";Command name:C538(660)+" will not accept a literal text type constant as the header parameter; it must be a 4D variable or field.";\
"type";"T"))


  // Is new record    
$QS_TBX_TIPS.push(New object:C1471("token";668;\
"request";Command name:C538(668);\
"tips";"This command returns a different result for the On Validate form event depending on whether it is executed on 4D in local mode or 4D in remote mode. In local mode, the command returns False (the record is considered as already created). In remote mode"+", the command returns True because, in this case, the record is already created on the server but the information has not yet been sent to the client.";\
"type";"Svr"))


  // Select folder   
$QS_TBX_TIPS.push(New object:C1471("token";670;\
"request";Command name:C538(670);\
"tips";"This function allows you to view the volumes connected to the client workstations. It is not possible to call this function from a stored procedure.";\
"type";"Svr"))


  //  OPEN URL
$QS_TBX_TIPS.push(New object:C1471("token";673;\
"request";Command name:C538(673);\
"tips";Command name:C538(673)+" does not work when called from a Web process.";\
"type";"T"))


  //  OPEN URL
$QS_TBX_TIPS.push(New object:C1471("token";675;\
"request";Command name:C538(675);\
"tips";Command name:C538(675)+": To reopen a window at vPos and hPos initial coordinates when the * parameter is used, hold down the Shift key while the window is being opened.";\
"type";"T"))


  //  BLOB TO PICTURE 
$QS_TBX_TIPS.push(New object:C1471("token";682;\
"request";Command name:C538(682);\
"tips";"A BLOB created by the "+Command name:C538(532)+" command is managed automatically; it is not necessary to pass a codec to encapsulate it since the BLOB is \"signed.\" In this case, for the opposite operation, you will need to pass \".4DVarBlob\" to the "+Command name:C538(692)+" command as the codec ID.";\
"type";"T"))


  //  WEB GET VARIABLES  
$QS_TBX_TIPS.push(New object:C1471("token";683;\
"request";Command name:C538(683);\
"tips";Command name:C538(683)+" Regarding check boxes, the variable name and value are returned only if the check box has been actually checked.";\
"type";"T"))


  //  GET FIELD ENTRY PROPERTIES   
$QS_TBX_TIPS.push(New object:C1471("token";685;\
"request";Command name:C538(685);\
"tips";Command name:C538(685)+" returns the properties defined at the structure window level.";\
"type";"T"))


  //  GENERATE ENCRYPTION KEYPAIR
$QS_TBX_TIPS.push(New object:C1471("token";688;\
"request";Command name:C538(688);\
"tips";Command name:C538(688)+": The private key should always be kept secret.";\
"type";"W"))


  //  GENERATE CERTIFICATE REQUEST  
$QS_TBX_TIPS.push(New object:C1471("token";691;\
"request";Command name:C538(691);\
"tips";Command name:C538(691)+": The private key is used to generate the request but should NOT be sent to the certificate authority.";\
"type";"W"))


  // Method called on error
$QS_TBX_TIPS.push(New object:C1471("token";704;\
"request";Command name:C538(704);\
"tips";"If no '"+Command name:C538(704)+"' method has been installed, an empty string (\"\")) is returned.";\
"type";"T"))


  // Method called on event
$QS_TBX_TIPS.push(New object:C1471("token";705;\
"request";Command name:C538(705);\
"tips";"If no such method has been installed, an empty string (\"\")) is returned.";\
"type";"T"))


  //  OBJECT Get horizontal alignment      
$QS_TBX_TIPS.push(New object:C1471("token";707;\
"request";Command name:C538(707);\
"tips";"With "+Command name:C538(707)+", if you apply the command to a group of objects, only the alignment value of the last object is returned.";\
"type";"T"))


  //  SET PRINTABLE MARGIN   
$QS_TBX_TIPS.push(New object:C1471("token";710;\
"request";Command name:C538(710);\
"tips";"By default, 4D bases its printouts on the printer margins. Once the "+Command name:C538(710)+" command is executed, the modified parameters are retained in the same process for the entire session.";\
"type";"T"))


  //  DOM Parse XML source     
$QS_TBX_TIPS.push(New object:C1471("token";719;\
"request";Command name:C538(719);\
"tips";"Execution of the "+Command name:C538(719)+" command is synchronous.";\
"type";"T"))


  //  DOM Parse XML variable       
$QS_TBX_TIPS.push(New object:C1471("token";729;\
"request";Command name:C538(729);\
"tips";Command name:C538(729)+": Once you no longer have any need for it, remember to call the "+Command name:C538(722)+" command with this reference in order to free up the memory.";\
"type";"W"))


  //  DOM GET XML ATTRIBUTE BY INDEX    
$QS_TBX_TIPS.push(New object:C1471("token";729;\
"request";Command name:C538(729);\
"tips";Command name:C538(729)+": The index number does not correspond to the location of the attribute in the XML file displayed in text form.";\
"type";"T"))


  //  DOM GET XML ATTRIBUTE BY INDEX    
$QS_TBX_TIPS.push(New object:C1471("token";731;\
"request";Command name:C538(731);\
"tips";"If the element designated by elementRef is a BLOB processed by the "+Command name:C538(731)+" command, it has been automatically encoded in base64. Therefore the command will automatically attempt to decode it in base64.";\
"type";"T"))


  //  SET PRINT OPTION   
$QS_TBX_TIPS.push(New object:C1471("token";733;\
"request";Command name:C538(733);\
"tips";Command name:C538(733)+": under Windows, after each printing, 4D automatically re-establishes the previous settings of the PDFCreator driver in order to avoid any interference with other programs using PDFCreator.";\
"type";"T"))


  //  OBJECT Get horizontal alignment      
$QS_TBX_TIPS.push(New object:C1471("token";734;\
"request";Command name:C538(734);\
"tips";Command name:C538(734)+" supports mainly PostScript printers. You can use this command with other types of printers, such as PCL or Ink, but in this case, it is possible that some options may not be available.";\
"type";"T"))


  //  QR RUN        
$QS_TBX_TIPS.push(New object:C1471("token";746;\
"request";Command name:C538(746);\
"tips";Command name:C538(746)+" can be executed on 4D Server as part of a stored procedure. In this context, make sure that no dialog box appears on the server machine. To do this, you need to call the "+Command name:C538(745)+" command with the \"*\" parameter.";\
"type";"Svr"))


  //  QR INSERT COLUMN        
$QS_TBX_TIPS.push(New object:C1471("token";748;\
"request";Command name:C538(748);\
"tips";Command name:C538(748)+" cannot be used with a cross-table report.";\
"type";"T"))


  //  QR SET HTML TEMPLATE        
$QS_TBX_TIPS.push(New object:C1471("token";750;\
"request";Command name:C538(750);\
"tips";Command name:C538(750)+": You first need to call '"+Command name:C538(745)+"' to set the output to HTML file.";\
"type";"T"))


  //  QR GET INFO COLUMN        
$QS_TBX_TIPS.push(New object:C1471("token";766;\
"request";Command name:C538(766);\
"tips";Command name:C538(766)+" does not take into account any virtual structure.";\
"type";"T"))


  //   WEB SERVICE SET PARAMETER          
$QS_TBX_TIPS.push(New object:C1471("token";777;\
"request";Command name:C538(777);\
"tips";Command name:C538(777)+": Each 4D variable or array used must be previously declared using the commands of the “Compiler and Arrays” themes.";\
"type";"T"))


  //  WEB SERVICE GET RESULT         
$QS_TBX_TIPS.push(New object:C1471("token";779;\
"request";Command name:C538(779);\
"tips";Command name:C538(779)+" must be used only after the "+Command name:C538(778)+" command.";\
"type";"T"))


  //  WEB SERVICE GET RESULT         
$QS_TBX_TIPS.push(New object:C1471("token";779;\
"request";Command name:C538(779);\
"tips";Command name:C538(779)+": Each 4D variable or array used must be previously declared using the commands of the “Compiler and Arrays” themes.";\
"type";"T"))


  //  SOAP DECLARATION         
$QS_TBX_TIPS.push(New object:C1471("token";782;\
"request";Command name:C538(782);\
"tips";Command name:C538(782)+":  Each 4D variable or array used must be previously declared using the commands of the “Compiler and Arrays” themes.";\
"type";"T"))


  //  SOAP DECLARATION         
$QS_TBX_TIPS.push(New object:C1471("token";782;\
"request";Command name:C538(782);\
"tips";"When "+Command name:C538(782)+" command is used, it is still necessary to declare 4D variables and arrays in the Compiler_Web method using commands of the \"Compiler\" theme.";\
"type";"W"))


  //  QR ON COMMAND        
$QS_TBX_TIPS.push(New object:C1471("token";790;\
"request";Command name:C538(790);\
"tips";Command name:C538(790)+": When planning on compiling the database, it is necessary to declare both $1 and $2 as Longints, even if you do not use them.";\
"type";"T"))


  //  QR GET SELECTION          
$QS_TBX_TIPS.push(New object:C1471("token";793;\
"request";Command name:C538(793);\
"tips";Command name:C538(793)+": If both left and top equal 0, the entire area is highlighted.";\
"type";"T"))


  //  QR SET SELECTION          
$QS_TBX_TIPS.push(New object:C1471("token";794;\
"request";Command name:C538(794);\
"tips";Command name:C538(794)+": If both left and top equal 0, the entire area is highlighted.";\
"type";"T"))


  //  QR GET BORDERS        
$QS_TBX_TIPS.push(New object:C1471("token";798;\
"request";Command name:C538(798);\
"tips";Command name:C538(798)+" does not accept a cumulative value. You must test all the parameters separately to have an overall view of the cell border.";\
"type";"T"))


  // EDIT FORM   
$QS_TBX_TIPS.push(New object:C1471("token";807;\
"request";Command name:C538(807);\
"tips";Command name:C538(807)+": you will need to open a new process to display the editor.";\
"type";"T"))


  // LAUNCH EXTERNAL PROCESS   
$QS_TBX_TIPS.push(New object:C1471("token";811;\
"request";Command name:C538(811);\
"tips";Command name:C538(811)+" can only launch executable applications; it cannot execute instructions that are part of the shell (command interpreter).";\
"type";"W"))


  // LAUNCH EXTERNAL PROCESS   
$QS_TBX_TIPS.push(New object:C1471("token";811;\
"request";Command name:C538(811);\
"tips";Command name:C538(811)+": If you use the _4D_OPTION_BLOCKING_EXTERNAL_PROCESS environment variable via the SET ENVIRONMENT VARIABLE command (asynchronous execution), the outputStream and errorStream parameters are not returned.";\
"type";"T"))


  // PROCESS 4D TAGS     
$QS_TBX_TIPS.push(New object:C1471("token";816;\
"request";Command name:C538(816);\
"tips";Command name:C538(816)+" never calls the On Web Authentication database method.";\
"type";"T"))


  // SQL LOGIN 
$QS_TBX_TIPS.push(New object:C1471("token";817;\
"request";Command name:C538(817);\
"tips";Command name:C538(817)+": The prefixes used in the dataEntry parameter (IP, ODBC, 4D) must be written in uppercase.";\
"type";"W"))


  // SQL LOGIN 
$QS_TBX_TIPS.push(New object:C1471("token";817;\
"request";Command name:C538(817);\
"tips";"In the case where an external connection attempt via "+Command name:C538(817)+", the internal 4D database automatically becomes the current data source.";\
"type";"T"))


  // SQL EXECUTE 
$QS_TBX_TIPS.push(New object:C1471("token";820;\
"request";Command name:C538(820);\
"tips";Command name:C538(820)+": When you pass 4D fields in the boundObj parameter(s) and execute the SELECT command, it is always the data of the remote 4D source that is modified.";\
"type";"W"))


  // SQL SET PARAMETER   
$QS_TBX_TIPS.push(New object:C1471("token";823;\
"request";Command name:C538(823);\
"tips";Command name:C538(823)+": It is also possible to directly insert the name of a 4D object to be used (variable, array or field) between the << and >> characters in the text of the request.";\
"type";"T"))


  // LISTBOX INSERT COLUMN  
$QS_TBX_TIPS.push(New object:C1471("token";829;\
"request";Command name:C538(829);\
"tips";Command name:C538(829)+" does nothing if it is applied to the first column of a list box displayed in hierarchical mode.";\
"type";"T"))


  // LISTBOX DELETE COLUMN  
$QS_TBX_TIPS.push(New object:C1471("token";830;\
"request";Command name:C538(830);\
"tips";Command name:C538(830)+" does nothing if it is applied to the first column of a list box displayed in hierarchical mode.";\
"type";"T"))


  //  LISTBOX MOVED ROW NUMBER    
$QS_TBX_TIPS.push(New object:C1471("token";837;\
"request";Command name:C538(837);\
"tips";Command name:C538(837)+" does not take into account any hidden/displayed states of list box rows.";\
"type";"T"))


  // LISTBOX MOVED COLUMN NUMBER   
$QS_TBX_TIPS.push(New object:C1471("token";844;\
"request";Command name:C538(844);\
"tips";Command name:C538(844)+" takes invisible columns into account.";\
"type";"T"))


  // FORM GET OBJECTS ( objectsArray {; variablesArray {; pagesArray}} {; formPageOption | *} )  -> * is obsolete
$QS_TBX_TIPS.push(New object:C1471("token";898;\
"request";Command name:C538(898)+"\\(([^.*]*)(?;\\*)\\)$";\
"tips";"Passing the * parameter is equivalent to passing 'Form current page+Form inherited'. The syntax using the * parameter is now deprecated and should no longer be used.";\
"type";"T"))


  //  DOM Find XML element    
$QS_TBX_TIPS.push(New object:C1471("token";864;\
"request";Command name:C538(864);\
"tips";Command name:C538(864)+" In conformity with the XML standard, searches will be case sensitive.";\
"type";"T"))


  //  OBJECT Get format     
$QS_TBX_TIPS.push(New object:C1471("token";894;\
"request";Command name:C538(894);\
"tips";"With "+Command name:C538(894)+", if you apply the command to a set of objects, the form of the last object selected is returned.";\
"type";"T"))


  //  SPELL CHECKING      
$QS_TBX_TIPS.push(New object:C1471("token";900;\
"request";Command name:C538(900);\
"tips";"The "+Command name:C538(900)+" command affects the text that is being entered in the form, and not the associated data source (field or variable).";\
"type";"W"))


  //  LISTBOX INSERT ROWS    
$QS_TBX_TIPS.push(New object:C1471("token";912;\
"request";Command name:C538(912);\
"tips";"With "+Command name:C538(912)+", if the number passed in position corresponds to a hidden row in the list box, the row is selected but not displayed.";\
"type";"T"))


  //  LISTBOX INSERT ROWS    
$QS_TBX_TIPS.push(New object:C1471("token";913;\
"request";Command name:C538(913);\
"tips";Command name:C538(913)+" only works with list boxes based on arrays. When this command is used with a list box based on a selection, it does nothing and the OK system variable is set to 0.";\
"type";"T"))


  //  LISTBOX DELETE ROWS    
$QS_TBX_TIPS.push(New object:C1471("token";914;\
"request";Command name:C538(914);\
"tips";Command name:C538(914)+" only works with list boxes based on arrays. When this command is used with a list box based on a selection, it does nothing and the OK system variable is set to 0.";\
"type";"T"))


  //   LISTBOX Get number of rows    
$QS_TBX_TIPS.push(New object:C1471("token";915;\
"request";Command name:C538(915);\
"tips";Command name:C538(915)+" does not take the hidden/displayed state of the rows into account.";\
"type";"T"))


  // New log file    
$QS_TBX_TIPS.push(New object:C1471("token";926;\
"request";Command name:C538(926);\
"tips";"This command only works with 4D Server. It can only be executed via the Execute on server command or in a stored procedure.";\
"type";"Svr"))


  // log file    
$QS_TBX_TIPS.push(New object:C1471("token";928;\
"request";Command name:C538(928);\
"tips";"If you execute this command from a 4D Client machine, only the log file name is returned, not the long name.";\
"type";"Svr"))


  //     QUERY BY SQL 
$QS_TBX_TIPS.push(New object:C1471("token";942;\
"request";Command name:C538(942);\
"tips";Command name:C538(942)+" is compatible with the "+Command name:C538(395)+" and "+Command name:C538(396)+" commands.";\
"type";"T"))


  //  GET LIST ITEM ICON ( {* ;} list ; itemRef | * ; icon )   -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";951;\
"request";Command name:C538(951)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(951)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //  Find in list ( {* ;} list ; value ; scope {; itemsArray {; *}} )  -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";952;\
"request";Command name:C538(952)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(952)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //  Get list item font ( {* ;} list ; itemRef | * )  -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";954;\
"request";Command name:C538(954)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(954)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //   Choose  
$QS_TBX_TIPS.push(New object:C1471("token";955;\
"request";Command name:C538(955);\
"tips";"If no value corresponds to criterion, "+Command name:C538(955)+" returns a 'null' value with respect to the type of the value parameter (for example, 0 for a Number type, \"\" for a String type, and so on).";\
"type";"N"))


  //   Select RGB Color    
$QS_TBX_TIPS.push(New object:C1471("token";956;\
"request";Command name:C538(956);\
"tips";Command name:C538(956)+" must not be executed on the server machine nor within a Web process.";\
"type";"W"))


  //    START SQL SERVER    
$QS_TBX_TIPS.push(New object:C1471("token";962;\
"request";Command name:C538(962);\
"tips";Command name:C538(962)+" does not affect the internal functioning of the 4D SQL kernel. The SQL kernal is always available for internal queries.";\
"type";"T"))


  //    CLOSE SQL SERVER    
$QS_TBX_TIPS.push(New object:C1471("token";963;\
"request";Command name:C538(963);\
"tips";Command name:C538(963)+" does not affect the internal functioning of the 4D SQL kernel. The SQL kernal is always available for internal queries.";\
"type";"T"))


  //    GET MENU ITEM ICON  
$QS_TBX_TIPS.push(New object:C1471("token";963;\
"request";Command name:C538(963);\
"tips";Command name:C538(963)+": If no icon is associated with the menu item, the command returns a blank value.";\
"type";"T"))


  //    CREATE INDEX  
$QS_TBX_TIPS.push(New object:C1471("token";966;\
"request";Command name:C538(966);\
"tips";Command name:C538(966)+": A B-Tree index associated with a Text type field stores the first 1024 characters of the field (maximum). Therefore in this context, searches for strings containing more than 1024 characters will fail.";\
"type";"T"))


  //   LISTBOX INSERT COLUMN FORMULA 
$QS_TBX_TIPS.push(New object:C1471("token";970;\
"request";Command name:C538(970);\
"tips";Command name:C538(970)+" does nothing if it is applied to the first column of a list box displayed in hierarchical mode.";\
"type";"T"))


  // LISTBOX GET CELL POSITION  
$QS_TBX_TIPS.push(New object:C1471("token";971;\
"request";Command name:C538(971);\
"tips";Command name:C538(971)+": The value returned in the row parameter does not take into account any hidden/displayed states of list box rows. It may also return a value of 0 if the click or Y position is below the last row.";\
"type";"T"))


  //   RELEASE MENU 
$QS_TBX_TIPS.push(New object:C1471("token";978;\
"request";Command name:C538(978);\
"tips";"Any sub-menus used by menu are not removed if they were created directly using the "+Command name:C538(408)+".";\
"type";"T"))


  //   SET MENU ITEM METHOD  
$QS_TBX_TIPS.push(New object:C1471("token";982;\
"request";Command name:C538(982);\
"tips";Command name:C538(982)+", if the menu item corresponds to the title of a hierarchical sub-menu, the method will not be called when the menu item is selected.";\
"type";"T"))


  //   COMBINE PICTURES  
$QS_TBX_TIPS.push(New object:C1471("token";987;\
"request";Command name:C538(987);\
"tips";Command name:C538(987)+" command preserves the characteristics of each source picture in the resulting picture, the & and | operators process each pixel and generate a bitmap picture in all cases. These operators, originally intended for black and white pictures, are now obs"+"olete.";\
"type";"T"))



  //  GET LIST ITEM PARAMETER ( {* ;} list ; itemRef | * ; selector ; value )   -- @ used
$QS_TBX_TIPS.push(New object:C1471("token";985;\
"request";Command name:C538(985)+"@";\
"tips";"If you use the @ character in the object name of the list and the form contains several lists that match this name, the "+Command name:C538(985)+" command will be applied to the first object whose name corresponds.";\
"type";"T"))


  //  GET DATA SOURCE LIST     
$QS_TBX_TIPS.push(New object:C1471("token";989;\
"request";Command name:C538(989);\
"tips";Command name:C538(989)+" does not take file type data sources into account.";\
"type";"T"))


  //  GET DATA SOURCE LIST     
$QS_TBX_TIPS.push(New object:C1471("token";989;\
"request";Command name:C538(989);\
"tips";Command name:C538(989)+": if you want to connect to an external 4D data source via ODBC, you will need to have installed the 4D ODBC Driver on your machine.";\
"type";"T"))


  //   NO DEFAULT TABLE  
$QS_TBX_TIPS.push(New object:C1471("token";993;\
"request";Command name:C538(993);\
"tips";"After "+Command name:C538(993)+" is executed, there is no longer any default table defined for the process.";\
"type";"T"))


  //  CONVERT PICTURE   
$QS_TBX_TIPS.push(New object:C1471("token";1002;\
"request";Command name:C538(1002);\
"tips";Command name:C538(1002)+": if the type of codec requested is the same as the original type of the picture, no conversion is carried out and the picture is returned \"as is\",except when the compression parameter is used.";\
"type";"T"))


  //  CONVERT PICTURE   
$QS_TBX_TIPS.push(New object:C1471("token";1005;\
"request";Command name:C538(1005);\
"tips";Command name:C538(1005)+": In remote mode, the command returns the path of the Resources folder on the client machine if the command is called from a client process.";\
"type";"T"))


  //  Dynamic pop up menu 
$QS_TBX_TIPS.push(New object:C1471("token";1006;\
"request";Command name:C538(1006);\
"tips";Command name:C538(1006)+": In conformity with standard interface rules, this command must generally be called in response to a right mouse click or when the button is held down a certain period of time (context menu for example).";\
"type";"T"))


  //  DOM Find XML element by ID     
$QS_TBX_TIPS.push(New object:C1471("token";1010;\
"request";Command name:C538(1010);\
"tips";Command name:C538(1010)+": The value of the id attribute must be a valid XML name and it must be unique among all the elements in the XML document (validity constraint).";\
"type";"W"))


  //  LISTBOX SET TABLE SOURCE   
$QS_TBX_TIPS.push(New object:C1471("token";1013;\
"request";Command name:C538(1013);\
"tips";Command name:C538(1013)+" is processed in an asynchronous manner; in other words, the source of the listbox is changed only after the complete execution of the method in which the command is called.";\
"type";"W"))


  //  GET LAST ERROR STACK   
$QS_TBX_TIPS.push(New object:C1471("token";1015;\
"request";Command name:C538(1015);\
"tips";"to obtain detailed information concerning the errors generated by an ODBC source, it will be necessary to use the "+Command name:C538(825)+" command.";\
"type";"T"))


  //  WA OPEN URL    
$QS_TBX_TIPS.push(New object:C1471("token";1020;\
"request";Command name:C538(1020);\
"tips";Command name:C538(1020)+": for compatibility, the \"file://\" syntax (using two \"/\")) is accepted in 4D but it does not conform to RFC. We recommend using the \"file:///\" syntax (with three \"/\")) that complies with RFC.";\
"type";"T"))


  //  WA SET EXTERNAL LINKS FILTERS      
$QS_TBX_TIPS.push(New object:C1471("token";1032;\
"request";Command name:C538(1032);\
"tips";"The filtering established by the "+Command name:C538(1030)+" command is taken into account before that of the "+Command name:C538(1032)+" command. This means that if a URL is denied because of a "+Command name:C538(1030)+" command filter, it cannot be opened in the browser even if it is explicitly specified by the "+Command name:C538(1032)+" command.";\
"type";"W"))


  //   WA SET PAGE CONTENT     
$QS_TBX_TIPS.push(New object:C1471("token";1037;\
"request";Command name:C538(1037);\
"tips";"Under Windows, you cannot call "+Command name:C538(1037)+" command unless a page has already been loaded previously into the Web area. If necessary, you can pass the \"about:blank\" URL in order to load a blank page.";\
"type";"T"))


  //   WA SET PAGE TEXT LARGER     
$QS_TBX_TIPS.push(New object:C1471("token";1039;\
"request";Command name:C538(1039);\
"tips";Command name:C538(1039)+" Under Mac OS, the scope of this command is the 4D session. Under Windows, the scope of this command is global.";\
"type";"T"))


  //    WA SET PAGE TEXT SMALLER      
$QS_TBX_TIPS.push(New object:C1471("token";1040;\
"request";Command name:C538(1040);\
"tips";Command name:C538(1040)+" Under Mac OS, the scope of this command is the 4D session. Under Windows, the scope of this command is global.";\
"type";"T"))


  //    WA SET PREFERENCE       
$QS_TBX_TIPS.push(New object:C1471("token";1041;\
"request";Command name:C538(1041);\
"tips";Command name:C538(1041)+" The use of Web plugins and Java applets is not recommended in Web areas because they may lead to instability in the operation of 4D, particularly at the event management level.";\
"type";"T"))


  //  TRUNCATE TABLE   
$QS_TBX_TIPS.push(New object:C1471("token";1051;\
"request";Command name:C538(1051);\
"tips";Command name:C538(1051)+": The concept and functioning of this command is similar to that of the SQL TRUNCATE (TABLE) command.";\
"type";"T"))


  //  PHP Execute    
$QS_TBX_TIPS.push(New object:C1471("token";1058;\
"request";Command name:C538(1058);\
"tips";Command name:C538(1058)+": For technical reasons, the size of parameters passed via the FastCGI protocol must not exceed 64 KB. You need to take this limitation into account if you use parameters of the Text type.";\
"type";"W"))


  // SQL EXPORT DATABASE     
$QS_TBX_TIPS.push(New object:C1471("token";1064;\
"request";Command name:C538(1064);\
"tips";Command name:C538(1064)+" does not support Object type fields.";\
"type";"T"))


  // SQL EXPORT DATABASE     
$QS_TBX_TIPS.push(New object:C1471("token";1065;\
"request";Command name:C538(1065);\
"tips";Command name:C538(1065)+" cannot be used with an external connection that is opened directly or via ODBC.";\
"type";"T"))


  // SQL EXECUTE SCRIPT   
$QS_TBX_TIPS.push(New object:C1471("token";1089;\
"request";Command name:C538(1089);\
"tips";Command name:C538(1089)+" cannot be used with an external connection that is opened directly or via ODBC.";\
"type";"T"))


  // LISTBOX SET HIERARCHY  
$QS_TBX_TIPS.push(New object:C1471("token";1098;\
"request";Command name:C538(1098);\
"tips";Command name:C538(1098)+" only functions with list boxes based on arrays. When this command is used with a list box based on selections, it does nothing.";\
"type";"T"))


  //  Is picture file  
$QS_TBX_TIPS.push(New object:C1471("token";1113;\
"request";Command name:C538(1113);\
"tips";Command name:C538(1113)+" returns True for PDF files under Windows and EMF files under Mac OS.";\
"type";"T"))


  //  SET PICTURE METADATA 
$QS_TBX_TIPS.push(New object:C1471("token";1121;\
"request";Command name:C538(1121);\
"tips";Command name:C538(1121)+": Certain metadata are read only and therefore cannot be modified by this command, for example TIFF XResolution/TIFF YResolution, EXIF Color Space or EXIF Pixel X Dimension/EXIF Pixel Y Dimension.";\
"type";"W"))


  //  GET MISSING TABLE NAMES   
$QS_TBX_TIPS.push(New object:C1471("token";1125;\
"request";Command name:C538(1125);\
"tips";Command name:C538(1125)+": The data of missing tables are erased when the data file is compacted (if the tables have not been regenerated).";\
"type";"T"))


  // SET ASSERT ENABLED   
$QS_TBX_TIPS.push(New object:C1471("token";1131;\
"request";Command name:C538(1131)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";"By default, the "+Command name:C538(1131)+" command affects all the processes of the application. To restrict the effect of the command to the current process only, you can pass the * parameter.";\
"type";"W"))


  //   SET EXTERNAL DATA PATH    
$QS_TBX_TIPS.push(New object:C1471("token";1134;\
"request";Command name:C538(1134);\
"tips";Command name:C538(1134)+" can only be called from 4D Server or a local 4D.";\
"type";"T"))


  //  RELOAD EXTERNAL DATA    
$QS_TBX_TIPS.push(New object:C1471("token";1135;\
"request";Command name:C538(1135);\
"tips";Command name:C538(1135)+" works only on a local 4D or on 4D Server.";\
"type";"T"))

  // GET TEXT KEYWORDS ( text ; arrKeywords {; *} )  -- * not present
$QS_TBX_TIPS.push(New object:C1471("token";1141;\
"request";Command name:C538(1141)+"\\(([^.*]*)(?!;\\*)\\)$";\
"tips";Command name:C538(1141)+", when the * parameter is passed, the command only stores each different keyword once.";\
"type";"T"))

  // GET PICTURE KEYWORDS  
$QS_TBX_TIPS.push(New object:C1471("token";1142;\
"request";Command name:C538(1142);\
"tips";Command name:C538(1142)+": Metadata of the IPTC/Keywords type are now indexable.";\
"type";"T"))

  // Generate digest    
$QS_TBX_TIPS.push(New object:C1471("token";1147;\
"request";Command name:C538(1147);\
"tips";Command name:C538(1147)+": It is not recommended to use MD5 and SHA algorithms to handle passwords; if you need to check passwords, you are advised to use Generate password hash and Verify password hash commands.";\
"type";"T"))

  //   LISTBOX SET LOCKED COLUMNS    
$QS_TBX_TIPS.push(New object:C1471("token";1151;\
"request";Command name:C538(1151);\
"tips";"With "+Command name:C538(1151)+", to remove column locking, pass 0 in numColumns.";\
"type";"T"))

  //   LISTBOX Get static columns     
$QS_TBX_TIPS.push(New object:C1471("token";1154;\
"request";Command name:C538(1154);\
"tips";Command name:C538(1154)+" does not take the hidden/displayed state of the rows into account.";\
"type";"T"))

  //   OBJECT Get focus rectangle invisible     
$QS_TBX_TIPS.push(New object:C1471("token";1178;\
"request";Command name:C538(1178);\
"tips";Command name:C538(1178)+" has no effect under Windows. You can only use this option under Mac OS.";\
"type";"W"))

  //   OBJECT Set Help Tip -- http://forums.4d.com/Post/FR/22946249/1/22946250#22946250    
$QS_TBX_TIPS.push(New object:C1471("token";1181;\
"request";Command name:C538(1181);\
"tips";Command name:C538(1178)+" has no effect with invisible buttons. To simulate this, use a 3D button whose style 'none' or 'custom'.";\
"type";"T"))

  //    LISTBOX SET COLUMN FORMULA       
$QS_TBX_TIPS.push(New object:C1471("token";1203;\
"request";Command name:C538(1203);\
"tips";"With "+Command name:C538(1203)+", use the "+Command name:C538(538)+" command to specify formulas independent from the application language (when they call 4D commands).";\
"type";"T"))

  //    SPELL CHECK TEXT       
$QS_TBX_TIPS.push(New object:C1471("token";1215;\
"request";Command name:C538(1215);\
"tips";Command name:C538(1215)+": Under OS X, when the native spell checker is enabled, this command does not support grammar correction.";\
"type";"T"))

  // JSON Parse        
$QS_TBX_TIPS.push(New object:C1471("token";1218;\
"request";Command name:C538(1218);\
"tips";Command name:C538(1218)+": If you use pointers, you must call the JSON Stringify command before calling JSON Parse.";\
"type";"T"))

  // JSON Parse array  
$QS_TBX_TIPS.push(New object:C1471("token";1219;\
"request";Command name:C538(1219);\
"tips";"Starting with 4D v16 R4, "+Command name:C538(1219)+" can usually be replaced by a call to JSON Parse that returns a collection. Collections are based on JSON arrays and allow to store data of mixed types, which provides more flexibility than arrays.";\
"type";"T"))

  //    OB SET ARRAY         
$QS_TBX_TIPS.push(New object:C1471("token";1227;\
"request";Command name:C538(1227);\
"tips";Command name:C538(1227)+": an object can be defined but empty. To find out if an object is undefined or empty, use the '"+Command name:C538(1297)+"'.";\
"type";"T"))

  //    OB SET ARRAY         
$QS_TBX_TIPS.push(New object:C1471("token";1227;\
"request";Command name:C538(1227);\
"tips";Command name:C538(1227)+": It is not possible to use two-dimensional arrays.";\
"type";"T"))

  //    OB Get Type       
$QS_TBX_TIPS.push(New object:C1471("token";1230;\
"request";Command name:C538(1230);\
"tips";Command name:C538(1230)+": For picture attributes, the command returns Is object.";\
"type";"N"))

  //    OB Is defined        
$QS_TBX_TIPS.push(New object:C1471("token";1231;\
"request";Command name:C538(1231);\
"tips";Command name:C538(1231)+": It is not possible to use two-dimensional arrays.";\
"type";"W"))

  // Selection to JSON         
$QS_TBX_TIPS.push(New object:C1471("token";1234;\
"request";Command name:C538(1234);\
"tips";"After a call to "+Command name:C538(1234)+", the current selection remains the same, but the current record is no longer loaded and might have changed.";\
"type";"W"))

  //    Document to text      
$QS_TBX_TIPS.push(New object:C1471("token";1236;\
"request";Command name:C538(1236);\
"tips";Command name:C538(1236)+" does not modify the OK variable. In case of failure, an error is generated that you can intercept using a method installed by the "+Command name:C538(155)+" command.";\
"type";"W"))

  //    Document to text      
$QS_TBX_TIPS.push(New object:C1471("token";1237;\
"request";Command name:C538(1237);\
"tips";Command name:C538(1237)+" does not modify the OK variable. In case of failure, an error is generated that you can intercept using a method installed by the "+Command name:C538(155)+" command.";\
"type";"W"))

  //    OBJECT GET EVENTS       
$QS_TBX_TIPS.push(New object:C1471("token";1238;\
"request";Command name:C538(1238);\
"tips";"With "+Command name:C538(1238)+", if you want to get events for a subform related to a table, you can only use the syntax based on the object name.";\
"type";"T"))

  //   OBJECT SET ACTION      
$QS_TBX_TIPS.push(New object:C1471("token";1259;\
"request";Command name:C538(1259);\
"tips";Command name:C538(1259)+": Legacy constants (prefixed by _o_ in the Standard Action theme) are deprecated starting with 4D v16 R3. However, they are still supported for compatibility.";\
"type";"W"))

  //   OBJECT Is styled text     
$QS_TBX_TIPS.push(New object:C1471("token";1261;\
"request";Command name:C538(1261);\
"tips";Command name:C538(1261)+" returns True when it is applied to a 4D Write Pro area.";\
"type";"T"))

  //   LISTBOX Set row font style     
$QS_TBX_TIPS.push(New object:C1471("token";1268;\
"request";Command name:C538(1268);\
"tips";Command name:C538(1268)+" does not take the hidden/displayed state of the rows into account.";\
"type";"T"))

  //   LISTBOX Get row font style     
$QS_TBX_TIPS.push(New object:C1471("token";1269;\
"request";Command name:C538(1269);\
"tips";Command name:C538(1269)+" does not take the hidden/displayed state of the rows into account.";\
"type";"T"))

  //   LISTBOX Set row color    
$QS_TBX_TIPS.push(New object:C1471("token";1270;\
"request";Command name:C538(1270);\
"tips";Command name:C538(1270)+" does not take the hidden/displayed state of the rows into account.";\
"type";"T"))

  //   LISTBOX Get row color    
$QS_TBX_TIPS.push(New object:C1471("token";1271;\
"request";Command name:C538(1271);\
"tips";Command name:C538(1271)+" does not take the hidden/displayed state of the rows into account.";\
"type";"T"))

  //   LISTBOX DUPLICATE COLUMN     
$QS_TBX_TIPS.push(New object:C1471("token";1273;\
"request";Command name:C538(1273);\
"tips";Command name:C538(1273)+" does nothing when it is applied to the first column of a list box displayed in hierarchical mode.";\
"type";"T"))

  //   LISTBOX MOVE COLUMN     
$QS_TBX_TIPS.push(New object:C1471("token";1274;\
"request";Command name:C538(1274);\
"tips";Command name:C538(1274)+" does nothing when it is applied to the first column of a list box displayed in hierarchical mode.";\
"type";"T"))

  //   LISTBOX SET ARRAY    
$QS_TBX_TIPS.push(New object:C1471("token";1279;\
"request";Command name:C538(1279);\
"tips";Command name:C538(1279)+" only works with array type list boxes.";\
"type";"T"))

  //  ST INSERT EXPRESSION     
$QS_TBX_TIPS.push(New object:C1471("token";1281;\
"request";Command name:C538(1281);\
"tips";Command name:C538(1281)+": Inserting picture expressions (e. g. Picture type variables) is supported in 4D Write Pro areas but is not supported in multi-style text areas.";\
"type";"T"))

  //   PAUSE INDEXES    
$QS_TBX_TIPS.push(New object:C1471("token";1293;\
"request";Command name:C538(1293);\
"tips";Command name:C538(1293)+" cannot be executed from a 4D remote.";\
"type";"T"))

  //   RESUME INDEXES    
$QS_TBX_TIPS.push(New object:C1471("token";1294;\
"request";Command name:C538(1294);\
"tips";Command name:C538(1294)+" can only be called from 4D Server or a local 4D.";\
"type";"T"))

  //   OBJECT Get placeholder    
$QS_TBX_TIPS.push(New object:C1471("token";1296;\
"request";Command name:C538(1296);\
"tips";Command name:C538(1296)+", if the placeholder is an xliff reference defined using the Property List, the command returns the original reference in the form \":xliff:resname\", and not its calculated value.";\
"type";"T"))

  //   OPEN FONT PICKER     
$QS_TBX_TIPS.push(New object:C1471("token";1303;\
"request";Command name:C538(1303);\
"tips";Command name:C538(1303)+": If the font was changed, the On After Edit form event is generated for the object.";\
"type";"T"))

  //   OPEN COLOR PICKER     
$QS_TBX_TIPS.push(New object:C1471("token";1304;\
"request";Command name:C538(1304);\
"tips";Command name:C538(1304)+": If the color was changed, the On After Edit form event is generated for the object.";\
"type";"T"))

  //    Get locked records info     
$QS_TBX_TIPS.push(New object:C1471("token";1316;\
"request";Command name:C538(1316);\
"tips";Command name:C538(1316)+" works only with 4D and 4D Server. It always return an invalid object when called from 4D Remote or a component. However, it can be called in these contexts if the \"Execute on server\" option is activated. In this case, the object returned will contain"+", respectively, information about the server or the host database.";\
"type";"W"))

  //    OBJECT Get corner radius   
$QS_TBX_TIPS.push(New object:C1471("token";1324;\
"request";Command name:C538(1324);\
"tips";Command name:C538(1324)+" only applies to rounded rectangles (which are static objects). As a result, only the syntax based on the object name (using the * parameter) is supported.";\
"type";"T"))

  //    QUERY BY ATTRIBUTE    
$QS_TBX_TIPS.push(New object:C1471("token";1331;\
"request";Command name:C538(1331);\
"tips";"With "+Command name:C538(1331)+", keep in mind that attribute names are case-sensitive and that attribute names are trimmed to eliminate extra spaces.";\
"type";"T"))

  //    QUERY BY ATTRIBUTE    
$QS_TBX_TIPS.push(New object:C1471("token";1331;\
"request";Command name:C538(1331);\
"tips";"With "+Command name:C538(1331)+", each table maintains its own currently-built query. This means that you can create multiple queries simultaneously, one for each table.";\
"type";"N"))

  // CALL WORKER      
$QS_TBX_TIPS.push(New object:C1471("token";1389;\
"request";Command name:C538(1389);\
"tips";"The main process, created by 4D when a database is opened for the user interface and the application mode, is a worker process and can be called by CALL WORKER. However, since its name can vary depending on the 4D language, it is preferable to designa"+"te this process using its number (always 1) when you use CALL WORKER.";\
"type";"N"))

  //    ORDER BY ATTRIBUTE      
$QS_TBX_TIPS.push(New object:C1471("token";1407;\
"request";Command name:C538(1407);\
"tips";"With "+Command name:C538(1407)+", only attributes containing scalar values (number, text, boolean, date) can be sorted. Others types of values (object, picture...) are considered as null values.";\
"type";"T"))

  // ADJUST TABLE CACHE PRIORITY         
$QS_TBX_TIPS.push(New object:C1471("token";1429;\
"request";Command name:C538(1429);\
"tips";"With "+Command name:C538(1429)+" is reserved for specific needs. Works in local mode (4D Server and 4D); it cannot be used in 4D remote mode.";\
"type";"T"))

  // ADJUST INDEX CACHE PRIORITY        
$QS_TBX_TIPS.push(New object:C1471("token";1430;\
"request";Command name:C538(1430);\
"tips";"With "+Command name:C538(1430)+" is reserved for specific needs. Works in local mode (4D Server and 4D); it cannot be used in 4D remote mode.";\
"type";"T"))

  // ADJUST BLOBS CACHE PRIORITY      
$QS_TBX_TIPS.push(New object:C1471("token";1431;\
"request";Command name:C538(1431);\
"tips";"With "+Command name:C538(1431)+" is reserved for specific needs. Works in local mode (4D Server and 4D); it cannot be used in 4D remote mode.";\
"type";"T"))

  // INVOKE ACTION       
$QS_TBX_TIPS.push(New object:C1471("token";1439;\
"request";Command name:C538(1439);\
"tips";"With "+Command name:C538(1439)+" command does not generate an error, for example, if the requested action is not available in the current context. You must validate the expected action using the Get action info command.";\
"type";"T"))

  // LISTBOX SET PROPERTY        
$QS_TBX_TIPS.push(New object:C1471("token";1440;\
"request";Command name:C538(1440);\
"tips";Command name:C538(1440)+": If the list box or list box column specified using the object and * parameters does not exist, the command does nothing and no error is triggered.";\
"type";"T"))

  // Get action info       
$QS_TBX_TIPS.push(New object:C1471("token";1442;\
"request";Command name:C538(1442);\
"tips";"With "+Command name:C538(1442)+": Some actions accept parameter(s). In this case, you must use the following pattern: actionName?parameterName=parameterValue. Example: \"gotoPage?value=2\"";\
"type";"T"))

  //  FORM GET ENTRY ORDER       
$QS_TBX_TIPS.push(New object:C1471("token";1469;\
"request";Command name:C538(1469);\
"tips";"If "+Command name:C538(1469)+" command was not previously called for the current form, the array returned is empty.";\
"type";"W"))

  //  JSON Resolve pointers          
$QS_TBX_TIPS.push(New object:C1471("token";1478;\
"request";Command name:C538(1478);\
"tips";Command name:C538(1478)+" The source object will be updated with the result of pointer resolution after the command is executed (except if the result is not an object, see below). If you want to keep an original version of object, you may consider using the OB Copy beforehand"+".";\
"type";"W"))

  //  C_COLLECTION       
$QS_TBX_TIPS.push(New object:C1471("token";1488;\
"request";Command name:C538(1488);\
"tips";"Keep in mind that "+Command name:C538(1472)+" declares a variable of the Collection type but does not create any collection.";\
"type";"W"))

  // New shared object         
$QS_TBX_TIPS.push(New object:C1471("token";1526;\
"request";Command name:C538(1526);\
"tips";Command name:C538(1526)+": Keep in mind that C_OBJECT declares a variable of the Object type but does not create an object.";\
"type";"N"))

  // Storage        
$QS_TBX_TIPS.push(New object:C1471("token";1525;\
"request";Command name:C538(1525);\
"tips";Command name:C538(1525)+": There is one Storage catalog per machine and component: in a client/server application, there is one Storage shared object on the server, and one Storage shared object on each remote 4D application; if the database uses components, there is one Stor"+"age object per component.";\
"type";"N"))

  // New shared collection         
$QS_TBX_TIPS.push(New object:C1471("token";1527;\
"request";Command name:C538(1527);\
"tips";Command name:C538(1527)+": Keep in mind that C_COLLECTION declares a variable of the Collection type, but does not create a collection.";\
"type";"N"))

  // Verify password hash       
$QS_TBX_TIPS.push(New object:C1471("token";1534;\
"request";Command name:C538(1534);\
"tips";Command name:C538(1534)+": The password is never stored on disk, only the hash. Using a remote 4D application, the hash could be produced on the client side.";\
"type";"W"))

  // Return the collection
$0:=$QS_TBX_TIPS