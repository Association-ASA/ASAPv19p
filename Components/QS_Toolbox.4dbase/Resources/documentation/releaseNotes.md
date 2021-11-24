# Version History

	* 4.0ß - Update to v18, major improvements (workers, code simplification, optimization, some external resources have been removed) and new modules
	* 3.1.07 - Some bugs corrected on '4D command' module
	* 3.1.05 - Some bugs corrected on C/S and Graphviz schema creation - 29 April 2020
	* 3.1.03 - Minor bug corrected when started by QS_Toolbox call - 27 April 2020
	* 3.1.02 - Minor bug corrected on Path definition - 18 April 2020
	* 3.1.01 - bug corrected for new user - 16 April 2020
	* 3.1, final release on 12 April 2020 (v17.4)
	* 3.1MC1 released on 28 February 2020 (v17.4)
	* 3.02 released on 09 December 2019 (v17.3)
	* 3.01 released on 25 October 2019
	* 3.00 released on  14 October 2019
	* 2.20 released on 13 May 2018. This is the latest version developed in v15R5 and plainly useful with v16 versions. This version is still available and source opened
	* 2.15.1 released on 6 Avr 2018
	* 2.15 released on 3 Avr 2018
	* 2.14 released on 27 Ma 2018
	* 2.10.a released on 7 Mar 2018
	* 2.10 released on 22 Feb 2018
	* 2.03 released on 15 Feb 2018
	* 2.01 released on 7 Jan 2018
	* 2.00 released on 3 Jan 2018
	* 1.90 17 released on Aug 2017
	* 1.60.1 released on 23 Dec 2016
	* 1.60  released on 12 Dec 2016

---
# Modules details history

	## GENERAL
	* NEW (4.0ß): Refactoring of the interface in some modules, speed analysis, VCS module reviewed...
	* NEW (4.0ß):  Split the execution  of the 'callees/callers' from the main analyze. By this way, all modules are available. That is could be done automatically by selecting the correct option in 'Setup' module
	* NEW (v3.1): New interface, more simple. Work done with Protée
	* NEW (v3.1): Fully integrated to 4Dpop developed by Vincent de Lachaux
	* NEW (v3.1): Documentation available directly from the component (from About menu)
	* UPDATE (v2.1MC1): harmonization of the interface in all modules, increase the speed at starting execution time and analysis time.
	* UPDATE (v3.02): bug corrections and addition of a new functionality in Structure Analysis
	* UPDATE (v3.01): bug corrections and speed improvement for BD analysis.
	* UPDATE (v3.00): Review all User Interface by using Collection, Hierarchical List and Web area.
	refactoring  more than 80% of the code with v17. Apply a new approach to speed up the analysis.
	* UPDATE (v2.20): Fully compliance on server configuration. External database is placed on the server, all export folders are on the client side. Both in the '(My) documents' folder.
	* UPDATE (v2.20): A review of v16R6 and V17ß has been done to integrate some documentation information
	* UPDATE (v2.15): correction of bug at start after the dialog asking to save all methods
	* UPDATE (v2.15.1): restrict the VCS module to local mode use only.
	* NEW (v2.14): all main screens called by WORKER instead of launch in a new process
	* UPDATE(v2.13): Minor bugs correction
	* NEW (v2.13): When the option is displayed, opening a form is possible by double click. The Design Explorater must be open before
	* UPDATE( v2.11): Minor bugs correction
	* UPDATE(v2.11): Few interface improvements
	* UPDATE(v2.10): Tested in Client / Server mode. Improve Windows working and corrections of some bugs specific to this environment
	* UPDATE(v2.05): Review some part of code for windows users and Graphviz file generation
	* UPDATE(v2.05): Add a slowup function due to some optimization done and were files are used

---
	## MAIN SCREEN
	
	* NEW (3.1MC1): add 'DB Overview', 'Search & Control' and 'Go to Structure' buttons. The tab 'Search & Control' has been removed from the  'Structure Analysis' module.
	* NEW (3.00): add a Reports button and a 'bug' button. It opens the current 4D bug list for the current version of 4D. Some menus have been renamed and moved.
	* UPDATE (3.00): main menu has been fully reorganized regarding the previous version.
	* NEW (2.00): add a preference button where it is possible to define some parameters used by the component.* NEW (2.00): review of the UI.
	* UPDATE(v2.05): improve UI for windows users
	* UPDATE (3.00): rContinue to improve UI.
	
	How to integrate safely QS_Toolbox in your code if you don't have 4Dpop or OgPop:
	
	ARRAY TEXT($tTxt_Components;0)
	COMPONENT LIST($tTxt_Components)
	If (Find in array($tTxt_Components;"QS_Toolbox")>0)
	   EXECUTE METHOD("QS_Toolbox")
	End if
	
	If you already use 4Dpop or OgPop, QS_Toolbox start silently in background at startup of the application.

---
	## METHOD EXPLORER
	
	* UPDATE (v4.0): add new column  showing the presence of a comment file (project mode). Integration of a right clic from the listbox given access to multiple options
	* UPDATE (v4.0): in comment part, add the list of commands which are not preemptive
	* NEW (v3.1MC1): New interface more clear and some bugs corrected.
	* NEW (v3.00): Better management of the option. Using Collection to manage the list. Use the 'Typing' file to identify methods which can be set as 'preemptive'
	* NEW (v2.20): No possibility to generate reports without performing the analysis before.
	* NEW (v2.20): In comment lines, take care now of condition like if (1=2), if (False), ...
	* NEW (v2.20): Methods list is updated every minute, only if the analysis is not performed.
	* UPDATE (v2.15): Correction of a bug which could lost a code during beautifying it
	* NEW (v2.15): interface update
	* NEW (v2.15): Analysis of code will start now on demand
	* NEW (v2.15): Method empty or in full comment are detected and put in grey after analysis
	* NEW (v2.15): Add the capability to filter method based on their execution mode (preemptif)
	* NEW (v2.10): Optimization of all processes for methods analysis (factor > x12)
	* NEW (v2.10): Can export methods links (2 levels) from a specific Project Methods with DOT language
	* UPDATE (v2.00): Can export all Project Methods with DOT language to create a view in PDF, SVG, PNG or JPG format. To be able to use this function, Graphviz must be installed on your computer. (see http://www.graphviz.org/).
	* NEW (v2.00): review of the interface
	* NEW (v2.00): add the beautify of the code
	* NEW (v2.00): add & remove all comments with just 1 clic
	* NEW (v2.00): manage comments
	* (1.90): Show methods called from a specific method, and calling methods
	* (1.80): Add a ReadOnly mode. Defined by default.
	* (1.80): Reduce the number of buttons used for exportation (HTML, documentation, graphwiz schema)
	* (1.80): Add a status bar
	* Can perform analysis on "all" stored methods in the structure including project methods, project form/object methods, table form/object methods, database methods and trigger methods.
	* Show stats methods: line counts, comment line counts, blank line counts, code line counts, and cyclomatic complexity.
	* Show method properties which will be updated directly from the interface
	* Can export, as HTML disk files, every method in the structure. Can be used for archiving, backups, and source code management.
	* Can export, as DOCX, HTML or RTF format, all objects of the structure (methods, forms) with screenshot, object information. Can be used for archiving, backups, and source code management.
	* Can manage 4D Project Method Comments

---
	## METHOD ANALYZER
	
	* NEW (v3.00): With this new functionality, you're able to access directly to:
	     - callers, callees methods
	     - identify Commands and Constants used, and how many times
	     - a Method analysis
	     - Variables list, and their type. Better identification is done if the compilation has been performed with 'typing variable' enable. By this way, you're able to identify quickly which variable is not declared for the method selected. Up to you to update it ;-)
	     - visualized the Method code throw an external text editor
	     - give you the syntax to call you method 
	     - check Method for common error and advices

---
	## METHOD CALL CHAIN
		
	* NEW (v4.00): With this new functionality, you're able to get a Graphic Call Chain (callers or callees) of the selected method with different types of graphs.

---
	## 4D COMMAND
	
	* NEW (v4.0): Add new filters command (Table and Pointer, Ended by Star). Review command list for V18.
	* NEW (v3.00): New functionality. For each command, you're able to get
	     - token number 
	     - determine if the command is Tread-safe 
	     - get the syntax
	     - the the method list using this command, and the number of them
	     - per a single clic, get the list of command which have a specific exception like 'what are the commands affected by the Unicode mode', or 'what are the command where the Table parameter is optional if 'Default table' is used'...
	* NEW (2.00): Overhaul the method to eliminate 'false positive' result and increase speed analysis
	* (v1.80): Reduce the number of 'false positive'
	* (v1.60):On selection, copy on paperboard the CID of the command / function (Command:C{number})
	* (v1.60): allow a search in Method name or Command name, indifferently.
	* (v1.60): Display the ID and CID for each command used
	* Display used commands and location.
	* Can access directly to the edition mode by double-clicking
	* Can list all unused command
	* Show easily the obsolete command / function used

---
	## METHOD PALLET
	
	* NEW (4.0): add a search area to be used by 'ORDA' syntax
	* NEW (v3.00): Completely refactorized. The interface doesn't change so much, but all code of this module has been rewritten.
	     - New filters to reduce the current method list
	     - New editor to visualize code
	     - Increase by 90% the search speed
	* NEW (2.00): Add the possibility to select methods by searching keywords included in methods code.
	* NEW (2.00): Search can be done by multiple keywords
	* (v1.80): Add a button to copy methods' list to pasteboard
	* (v1.60): List can be reduced to created/modified since x days.
	* (v1.60): List can be reduced based on criteria search.
	* (v1.60): Display the content of a method with the capability to copy all or a part of it to the pasteboard.
	* Display a list of all methods, including database, project form and table form methods, sorted by name or latest modification date.
	* List can be reduce to Methods only.

---
	## DB OVERVIEW
	
	* NEW (v3.1): displays some stats information about the application (structure, index errors & types)

---
	## FORM EXPLORER
	
	* NEW (v3.00): New interface using hierarchical list and web area
	* NEW (v2.20): Listbox properties are managed now (displayed or printed on reports)
	* NEW (v2.20): Report can be now exported in ODT format
	* NEW (v2.20): Project method report can also include as option, neighboring method graphic in the doc
	* NEW (v2.20): If neighboring is selected, then all pictures are created into the Form folder.
	* UPDATE (v2.15): Correction of bug regarding JSON displaying on PC
	* NEW (v2.15): during export of form, code of all objects has been added to the document
	* NEW (v2.10): correct a bug on Validation Package and add the picture with links between objects in the exported document
	* NEW (2.00): During page selection (included page 0), only objects of the page are listed.
	* NEW (2.00): Analysis take care of 16R4 new object definition and form definition (soming soon)
	* NEW (2.00): add the beautify of the code
	* NEW (2.00): Screenshot of project form works with a turnaround.
	* (1.80): Add a status bar
	* Display the screenshot of a form with all information about it (form objects, methods, object definition).
	* Can display the form definition on JSON format.
	* Can export the form definition on JSON format. It can be used for archiving, backups, and source code management in another tool.
	* Can display the method used for a form object.

---
	## STRUCTURE ANALYSIS
	
	* UPDATE (v3.1MC1): Remove the tab 'Search & Control' to set it a menu button. Some bugs corrections.
	* NEW (v3.02): Search a subform based on its name
	* UPDATE (v2.20): The analysis of commands based on the documentation has been reviewed and include all points until V16R6
	* NEW (v2.20): List of all TIPS used in the analysis of commands
	* NEW (v2.20): Integrate the GDPR extraction base on the 4D Blog code
	* NEW (v2.20): In the 'Search & Control' part, a repeat button has been added to call again the last menu selected
	* NEW (v2.20): Check of 4D doc for V16R2/R3/R4/R5/R6
	* NEW (v2.20): Display all parameters of the database in a listbox (include v17 options too)
	* NEW (v2.20): Display all parameters of the WEB server
	* NEW (v2.20): Display all WEB options
	* NEW (v2.20): Review of the Check menu
	* UPDATE (v2.20): Review of TIPS until v17
	* NEW (v2.20): Display licences information (>= 4Dv16R4)
	* UPDATE (v2.20): Analysis of variables: Regarding process variable, the regex doesn't work correctly and give some false results. If you really want to add this type of variable to the extraction, you have to press the 'Shift key' when you call the menu
	* UPDATE (v2.15): Style is displayed with the objects list
	* NEW (v2.15): Style definition is displayed on a listbox
	* UPDATE (v2.15): Self is now managed with the 'Correct deprecated command'
	* NEW (2.14): When displayed, it is possible to open a form with a double clic. Limitation known: the explorer must be open on backgroud.
	* NEW (v2.13): Parse all methods and check local and global variables type used vs variables declaration. 
	* NEW (v2.12): List all form objects and their type.
	* UPDATE (v2.05): Update the interface for windows users
	* UPDATE (v2.03): Add a specific icon for UUID fields
	* NEW (v2.03): Import/Export of indexes from/to a JSON format file
	* UPDATE (v2.02): Extend the check table/field names to object names defined in all forms
	* NEW (v2.01): display Structure picture
	* NEW (v2.01): display Table Relations (based on 4D Blog)
	* UPDATE (v2.01): Integrate table & fields information from the XML structure file (based on 4D Blog)
	* NEW (v2.00): Search all objects using a specific event in all forms (project & tables) and display where they are used and what are the events associated
	* NEW (v2.00): Search all objects with a specific type (combox, button, ...) and display where they are used and what are the events associated
	* NEW (v2.00): Overhaul supplements the correction of statement with addition of new orders to be corrected and some other options.
	* NEW (v2.00): Add the research of all deprecated commands
	* NEW (v2.00): Add an evaluation of Open/Close couple commands to prevent memory error (eg: Create menu/Release menu)
	* NEW (v2.00): Add an analysis of commands based on specific point of the documentation (Warning, Tips ...)
	* NEW (v2.00): Add a 4DLink Editor. This is helpful tool to create / update a 4DLink file when an application need to be restart safely.
	* NEW (v2.00): List all objects with a format (no filter is apply).
	* NEW (v2.00): add an analysis of commands that can be optimized in server condition.
	* (1.80): Add a ReadOnly mode for all functions which updated the structure or data. Defined by default.
	* (1.80): Add a status bar.
	* (v1.70.6) : Add the Index number when a table is selected.
	* (v1.70): Export to disk the picture library in PNG format.
	* (v1.70): Replace pictures from picture library based on the name. Pictures are converted to PNG format.
	* (v1.70): List all variables using picture from picture library.
	* (v1.60): Event Manager has been rewritten to check consistent thrue current events and objects. Results are displayed into a listbox.
	* (v1.60): Can restore all debugger button
	* (v1.60): If version >=16, add the capability '4D File'
	* (v1.60): Display relations between table and field. Result is automatically copy to the pasteboard.
	* (v1.60): Correct old declaration like C_STRING, C_INTEGER, ARRAY STRING, _o_AP BLOB to print settings ...
	* Can perform analysis of the structure and display fields definition.
	* Can copy, per table, all fields name and type to paperboard.
	* Can update, for a select field, a BTree index if none exist
	* Can perform analysis of the code to see which fields are used in a query and report if they are indexed or not and the number of call. This analysis shows also fields indexed and NOT involved into any 4D command using index.
	* Check table name and field name regarding 4D recommandation (accent, 4D command name, SQL function)
	* Allow SQL command execution and display result into a listbox
	* Allow 4D execution code (no check done regarding code executed)
	* Export all data as DUMP, and by the way, can import a DUMP. Before using this function, think to save your application data first !
	* Display 'fat' table
	* Create the code to insert a new record (code is set into memory)
	* Give some information about plugins used, components used, public IP address, format system used
	* Open CSM, application folder, application properties
	* Start a compression of the data file. Before using this function, think to save your application data first !
	* Can show 4D folders, Syst* (v1.70.5): Some correction issues for JSON view & JSON export
	* REMOVE - Can install/uninstall an event manager (special thanks to Vincent De Lachaux)


	*** Note 1: List of depreciated commands than can be updated ***
	_o_GRAPH TABLE, _o_Convert case, _o_ADD DATA SEGMENT, _o_SET PLATFORM INTERFACE, _o_REDRAW LIST,
	_o_Font number, _o_Font name, _o_Get platform interface, _o_DELETE RESOURCE, _o_SET PICTURE RESOURCE,
	_o_SET TEXT RESOURCE, _o_SET STRING RESOURCE, _o_SET RESOURCE, _o_SET RESOURCE NAME, _o_SET RESOURCE PROPERTIES, _o_SET WEB DISPLAY LIMITS, _o_SET WEB TIMEOUT, _o_Web Context, _o_Get component resource ID, _o_SET CGI EXECUTABLE, before, _o_during, After, En entete, En rupture, En pied, _o_ACTIVER BOUTON, _o_INACTIVER BOUTON, _o_array string, _o_c_integer, _o_c_string, Self, Outside call, Activation, Desactivation, _o_QT COMPRESS PICTURE, _o_DATA SEGMENT LIST(), DOM SET XML DECLARATION, _o_USE EXTERNAL DATABASE, _o_USE INTERNAL DATABASE, _o_PICTURE TYPE LIST
	
	*** Note 2: None exhaustive list of open / close command checked ***
	create record / save record
	load set / clear set
	Semaphore / clear semaphore
	Read write / Read only
	Open window / close window
	Push record / Pop record
	Messages off / Messages On
	...

---
	## SEARCH & CONTROL
	
	* NEW (v3.1.05): List of process & inter process variables and their number of calls.
	* NEW (v3.1): This module was initially a section of Structure Analysis. It becomes a specific module due to the large quantity of information provided.

---
	## User Mode Navigator
	
	* (v3.02): Integration of "User Mode Component" from Thomas MAUL into QS_Toolbox with its kind permission.
	      This module allow you to navigate inside your Data information, extract some of them, update and delete. 
	      Using it without any precaution can damage the data integrity of your database. Perform a copy before manipulate any data!

---
	## VCS: Version Control System
	
	* (v4.00): Main concept  has been reviewed with Lutz Veith feedbacks
	* (v3.00): Completely refactorized. The interface doesn't change so much, but all code of this module has been rewritten.
	* (v2.00): Review interface of the VCS module
	* (v1.60): Methods are saved into a 4D external database at a selected location
	* (v1.60): Comparison between current version and an older one is performed with jsdifflib library
	* (v1.60): Allow to navigate inside all saved version of a method
	* (v1.60): Allow to force to save all methods from the database (Press shift on 'Create a stamp point') . Available only for the full version
	* (v1.60): Allow to manage all projects in the same window.  Available only for the full version
	* initial idea from J.Pupier. All initial methods have been rewritten
	* Can save methods for Version Control perspective. You can know what is the latest version of your code
	
	> ***KNOWN LIMITATION of VCS***
	> VCS module save LOCALLY methods into an 4D external database using SQL commands. The default folder is Documents/QS_Toolbox
	> In C/S, the folder must be located in the Server.

---
	## CONVERTER EN/FR
	
	* Based on all command names, constants and keywords used by 4D, allow the conversion from EN->FR or FR->EN of your code.
	* Insert code to translate is done by copy/paste.
	* Get translated code by copy/paste
	* Allow to save the converted code directly as a new method into the host database
	* Search Command or Constant from the current 4D version

---
	## REPORTS
	
	* NEW (4.0): Reports use Write Pro instead of PHP-Word which is not used anymore.
	* NEW (v3.00): Reports are now available since the main menu and code has been rewritten to use Collection to speed up the process.

