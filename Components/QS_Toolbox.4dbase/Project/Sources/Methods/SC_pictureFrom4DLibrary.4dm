//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Méthode : SC_pictureFrom4DLibrary
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 25/11/19, 12:53:32
// Paramètres

C_LONGINT:C283($NumTable; $methodCount_l)
C_TEXT:C284($NomTable)
ARRAY LONGINT:C221($PictRef_aL; 0x0000)
ARRAY TEXT:C222($PictName_aT; 0x0000)
ARRAY TEXT:C222($Tb_Objects; 0x0000)
ARRAY POINTER:C280($Tb_Ptr_Vars; 0x0000)
ARRAY LONGINT:C221($Tb_PageNum; 0x0000)
C_OBJECT:C1216($tableInfo)
C_REAL:C285($pas)
C_COLLECTION:C1488($result)
C_LONGINT:C283($window)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
$Listbox_Name:="LB_Information"
BASE_getTablesList(True:C214)  // Storage.structureTable

PICTURE LIBRARY LIST:C564($PictRef_aL; $PictName_aT)

// Initialisation
C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "Identifying Pictures coming from 4D Library"; "icon"; "icns_structure.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$methodCount_l:=Storage:C1525.structureTable.length
$Progression:=0
$Pas:=1/($methodCount_l+1)
ARRAY TEXT:C222($TbForms; 0x0000)

For each ($tableInfo; Storage:C1525.structureTable)
	
	$Progression:=$Progression+$pas
	$param.value:=$Progression
	CALL FORM:C1391($window; "progressBar_update"; $param)
	
	CLEAR VARIABLE:C89($TbForms)
	CLEAR VARIABLE:C89($ZptTable)
	$NumTable:=$tableInfo.id
	
	If ($NumTable>0)
		$ZptTable:=Table:C252($NumTable)
		FORM GET NAMES:C1167($ZptTable->; $TbForms; *)
	Else 
		FORM GET NAMES:C1167($TbForms; *)
	End if 
	
	For ($b; 1; Size of array:C274($TbForms))
		
		$NomTable:=Choose:C955($NumTable>0; "["+$tableInfo.name+"]"; "")
		FE_getObjectsAndMethods($NumTable; $TbForms{$b}; ->$Tb_Objects; ->$Tb_Ptr_Vars; ->$Tb_PageNum)
		
		For ($c; 1; Size of array:C274($Tb_Objects))
			
			$Format:=OBJECT Get format:C894(*; $Tb_Objects{$c})
			$Pos:=Position:C15(";?"; $Format)
			
			If ($Pos>0)
				// Search the picture name into the library
				$pos2:=Position:C15(";"; $Format; $Pos+1)
				$RefID:=Num:C11(Substring:C12($Format; $Pos; ($pos2-$Pos)))
				$Lig:=Find in array:C230($PictRef_aL; $RefID)
				$PictName_T:=""
				
				If ($lig>0)
					$PictName_T:=$PictName_aT{$Lig}
				End if 
				$result.push(New object:C1471("table"; $NomTable; "form."; $TbForms{$b}; "object"; $Tb_Objects{$c}; "object_type"; Object_GetType($Tb_Objects{$c}); "picture"; $PictName_T; "format"; $Format))
				
			End if 
			
			If ((OBJECT Get type:C1300(*; $Tb_Objects{$c})=2) & ((Substring:C12($Format; 1; 1)=":") | (Substring:C12($Format; 1; 1)="?")))
				$result.push(New object:C1471("table"; $NomTable; "form."; $TbForms{$b}; "object"; $Tb_Objects{$c}; "object_type"; Object_GetType($Tb_Objects{$c}); "picture"; $Format; "format"; $Format))
				
			End if 
		End for 
		
		FORM UNLOAD:C1299
		
	End for 
End for each 

QST_progress_compileData($param)

// Restore the Storage
BASE_getTablesList  // Storage.structureTable

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method desc")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		LISTBOX SET COLUMN WIDTH:C833(*; "Table"; 120)
		LISTBOX SET COLUMN WIDTH:C833(*; "Form"; 120)
		LISTBOX SET COLUMN WIDTH:C833(*; "Object"; 180)
		LISTBOX SET COLUMN WIDTH:C833(*; "ObjectT"; 180)
		LISTBOX SET COLUMN WIDTH:C833(*; "Format"; 220)
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 120)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 120)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Form")
				
			: ($i=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 180)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Object")
				
			: ($i=4)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 180)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
			: ($i=5)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 220)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Format")
				
		End case 
		
	End for 
	
	LB_setHeights($Listbox_Name; 3; 1)
	ARRAY LONGINT:C221($MyEventsOnLB; 2)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	$MyEventsOnLB{2}:=On Double Clicked:K2:5
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$txt:=String:C10($result.length)+" error(s) found into Table / Field / Object Form names."
	displayInfo($txt; "red")
	
Else 
	displayInfo("NO picture found (that is weird, no?).")
End if 
KILL WORKER:C1390("QST_Progress")
