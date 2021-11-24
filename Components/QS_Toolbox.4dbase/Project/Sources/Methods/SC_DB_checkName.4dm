//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 20/04/14, 15:54:06
// modifié par : Association QualiSoft (20/11/2016)
//
// ----------------------------------------------------
// méthode : SC_DB_checkName
// description
//
// checks if table and field names are compliant with some rules
// result as a text document
//
// paramètres
// ----------------------------------------------------
// http://forums.4d.com/Post/FR/14532263
C_LONGINT:C283($field_l)
C_LONGINT:C283($tableID)
C_TEXT:C284($name_t; $Language)
C_TEXT:C284($pattern_t)
C_BOOLEAN:C305($0)
ARRAY TEXT:C222($tTxt_objects; 0x0000)
ARRAY POINTER:C280($tPtr_var; 0x0000)
ARRAY LONGINT:C221($tLon_pages; 0x0000)
C_OBJECT:C1216($Table; $method)
ARRAY TEXT:C222($TbForms; 0x0000)
C_REAL:C285($pas)
C_COLLECTION:C1488($result; $systemKeywords)
C_LONGINT:C283($window)

$result:=New collection:C1472
// $systemKeywords:=Storage.systemKeywords 
$Listbox_Name:="LB_Information"

// Initialisation
LB_Init_Start($Listbox_Name)
C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "Checking Database for unwanted keyword or characters."; "icon"; "icns_structure.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

//************ Initialisation Start *************
$pattern_t:="[^a-zA-Z0-9_\\s]"  // All except these
$Language:=Config_getLanguage

// -- Search for error in Tables & Fields
$pas:=1/(Storage:C1525.structureTable.length+1)
$progression:=0
$param.content:="Check in progress..."
$systemKeywords:=Storage:C1525.systemKeywords
For each ($table; Storage:C1525.structureTable)
	
	$progression:=$progression+$pas
	$param.value:=$progression
	CALL FORM:C1391($window; "progressBar_update"; $param)
	
	CLEAR VARIABLE:C89($TbForms)
	$tableId:=$table.id
	
	If ($tableID>0)
		
		FORM GET NAMES:C1167(Table:C252($tableID)->; $TbForms; *)
		$tableName:="["+Table name:C256($tableID)+"];"
		
		If (SUPPORT_DB_testName($systemKeywords; $table.name; $pattern_t; $Language)#"")
			$result.push(New object:C1471("method"; $table.name; "object type"; "Table"; "idenfifier"; String:C10($tableId); "field"; ""; "Field Id"; ""))
		End if 
		
		// Then, work on Fields
		If (Is table number valid:C999($tableId))
			
			For ($field_l; 1; Get last field number:C255($tableID))
				
				If (Is field number valid:C1000($tableId; $field_l))
					
					$field_t:=Field name:C257(Num:C11($tableId); $field_l)
					
					If (SUPPORT_DB_testName($systemKeywords; $field_t; $pattern_t; $Language)#"")
						$result.push(New object:C1471("method"; $table.name; "object type"; "Field"; "idenfifier"; String:C10($tableId); "field"; $field_t; "Field Id"; String:C10($field_l)))
					End if 
					
				End if 
			End for 
		End if 
		
	Else 
		FORM GET NAMES:C1167($TbForms; *)
		
	End if 
	
	// ********************************************
	// --- Now work on objects name in forms
	// -- Load the object form names
	
	For ($b; 1; Size of array:C274($TbForms))
		
		// Project form of the hosted base
		FE_getObjectsAndMethods($tableID; $TbForms{$b}; ->$tTxt_objects; ->$tPtr_var; ->$tLon_pages)
		$titre:=Choose:C955($tableID=0; ""; $tableName)+"\""+$TbForms{$b}+"\""
		
		// -- Check object form names
		$liste:="listbox"
		
		For ($c; 1; Size of array:C274($tTxt_objects))
			
			$name_t:=$tTxt_objects{$c}
			
			If (OBJECT Get type:C1300(*; $name_t)#7)  // It is not a listbox
				
				Case of   // To manage multiple exception in case of
					: (Substring:C12($name_t; 1; 5)="form.")
					Else 
						If (SUPPORT_DB_testName($systemKeywords; $name_t; $pattern_t; $Language)#"")
							$result.push(New object:C1471("method"; $name_t; "object type"; "Form object"; "idenfifier"; $titre; "field"; ""; "Field Id"; "Page "+String:C10($tLon_pages{$c})))
						End if 
				End case 
				
			Else   // It is a listbox
				
				$lb:=$name_t
				ARRAY TEXT:C222($ColNames; 0x0000)
				ARRAY TEXT:C222($TbNomEntete; 0x0000)
				ARRAY POINTER:C280($TabVarCol; 0x0000)
				ARRAY POINTER:C280($TabVarEntete; 0x0000)
				ARRAY BOOLEAN:C223($TabColVisible; 0x0000)
				ARRAY POINTER:C280($unused5; 0x0000)
				ARRAY TEXT:C222($TbNomPieds; 0x0000)
				ARRAY POINTER:C280($unused6; 0x0000)
				LISTBOX GET ARRAYS:C832(*; $lb; $ColNames; $TbNomEntete; $TabVarCol; $TabVarEntete; $TabColVisible; $unused5; $TbNomPieds; $unused6)
				
				For ($y; 1; Size of array:C274($ColNames))
					$name_t:=$ColNames{$y}
					If (SUPPORT_DB_testName($systemKeywords; $name_t; $pattern_t; $Language)#"")
						$name_t:="Listbox Column ("+$lb+"): "+$name_t
						$result.push(New object:C1471("method"; $name_t; "object type"; "Form object"; "idenfifier"; $titre; "field"; ""; "Field Id"; "Page "+String:C10($tLon_pages{$c})))
					End if 
				End for 
				
				For ($y; 1; Size of array:C274($TbNomEntete))
					$name_t:=$TbNomEntete{$y}
					
					If (SUPPORT_DB_testName($systemKeywords; $name_t; $pattern_t; $Language)#"")
						$name_t:="Listbox Header("+$lb+"): "+$name_t
						$result.push(New object:C1471("method"; $name_t; "object type"; "Form object"; "idenfifier"; $titre; "field"; ""; "Field Id"; "Page "+String:C10($tLon_pages{$c})))
					End if 
					
				End for 
				
				For ($y; 1; Size of array:C274($TbNomPieds))
					$name_t:=$TbNomPieds{$y}
					
					If (SUPPORT_DB_testName($systemKeywords; $name_t; $pattern_t; $Language)#"")
						$name_t:="Listbox Footer("+$lb+"): "+$name_t
						$result.push(New object:C1471("method"; $name_t; "object type"; "Form object"; "idenfifier"; $titre; "field"; ""; "Field Id"; "Page "+String:C10($tLon_pages{$c})))
					End if 
					
				End for 
				
			End if 
			
		End for 
		
		FORM UNLOAD:C1299
		
	End for 
	
End for each 

// Now, work on Method name
For each ($method; Storage:C1525.allMethods)
	If ($method.path="Path project method")
		Case of 
			: (Match regex:C1019($pattern_t; $method.name; 1))
				$result.push(New object:C1471("method"; $method.name; "object type"; "char"; "idenfifier"; "Method name"; "field"; ""; "Field Id"; ""))
				
				//: (Substring($method.name;1;1)="_")
				//$result.push(New object("method";$method.name;"object type";"char";"idenfifier";"Method name";"field";"";"Field Id";"It is not recommanded to start method name by an underscore '_'. Seems to be reserved to 4D for internal use."))
				
		End case 
	End if 
End for each 

// Last part - Display the information
If (Count parameters:C259=1)
	$continue:=False:C215
	
	If ($result.length>0)
		ALERT:C41("Prior using this function, please correct all Table, Field & object Form names.")
	End if 
	$0:=Bool:C1537($result.length=0)
	
End if 

QST_progress_compileData($param)

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method desc")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Object")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 100)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Error Type")
				
			: ($i=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table Name\rMethod Path Name\rObject name")
				
			: ($i=4)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table Num\rForm name")
				
			: ($i=5)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 250)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Field Num\\Page")
				
		End case 
		
	End for 
	LB_setHeights($Listbox_Name; 3; 1)
	
	LB_ResizeLine($Listbox_Name)
	$txt:=String:C10($result.length)+" error(s) found into Table / Field / Object Form names."
	displayInfo($txt; "red")
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
Else 
	displayInfo("NO error found.")
	
End if 

KILL WORKER:C1390("QST_Progress")