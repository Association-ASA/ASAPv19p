//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 12/03/18, 16:55:55
// ----------------------------------------------------
// Méthode : SC_listAllObjects
// Description
//  
// Paramètres
// ----------------------------------------------------

C_POINTER:C301($ZptTable)

ARRAY TEXT:C222($TbForms; 0x0000)
ARRAY TEXT:C222($tTxt_objects; 0x0000)
ARRAY POINTER:C280($tPtr_var; 0x0000)
ARRAY LONGINT:C221($tLon_pages; 0x0000)
C_LONGINT:C283($tableNumber)
C_REAL:C285($Pas)
C_COLLECTION:C1488($result)
C_OBJECT:C1216($table)
C_LONGINT:C283($window)

// Initialisation
$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "Parsing forms for object type"; "icon"; "icns_structure.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

// -- Search preparation
BASE_getTablesList

$Progression:=0
$Pas:=1/(Storage:C1525.structureTable.length+1)
$CountForms:=0
$result:=New collection:C1472

For each ($table; Storage:C1525.structureTable)  // pour chacune des tables
	$tableNumber:=$table.id
	$Progression:=$Progression+$pas
	$NomTable:=Str_GetTableOrProjectForm($tableNumber)
	
	$param.value:=$Progression
	$param.content:="Parsing Form widgets from "+$table.name
	CALL FORM:C1391($window; "progressBar_update"; $param)
	
	If ($tableNumber>0)
		$ZptTable:=Table:C252($tableNumber)
		FORM GET NAMES:C1167($ZptTable->; $TbForms; *)
	Else 
		FORM GET NAMES:C1167($TbForms; *)
	End if 
	
	For ($sale; 1; Size of array:C274($TbForms))  // For each form
		$Formulaire:=$TbForms{$sale}
		$CountForms:=$CountForms+1
		
		FE_getObjectsAndMethods($tableNumber; $Formulaire; ->$tTxt_objects; ->$tPtr_var; ->$tLon_pages)
		
		For ($a; 1; Size of array:C274($tTxt_objects))
			$result.push(New object:C1471("method"; $NomTable+";\""+$Formulaire+"\""; "page"; $tLon_pages{$a}; "object"; $tTxt_objects{$a}; "Variable Name"; Object_IsDynamic($tPtr_var{$a}); "object Type"; Object_GetType($tTxt_objects{$a}); "Style sheet"; OBJECT Get style sheet:C1258(*; $tTxt_objects{$a}); "empty"; ""))
		End for 
		
		FORM UNLOAD:C1299
		
	End for 
	
End for each 

QST_progress_compileData($param)

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Form")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 40)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				
			: ($i=3) | ($i=4) | ($i=5)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				
			: ($i=6)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
	End for 
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$txt:="Parsed "+String:C10($result.length)+" objects."
	
Else 
	
	$txt:="No object has been found."
End if 

displayInfo($txt)
KILL WORKER:C1390("QST_Progress")
