//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 06/12/17, 07:12:32
// ----------------------------------------------------
// Méthode : SC_lookAtObjectType
// Description
//  
//
// Paramètres
// ----------------------------------------------------

C_OBJECT:C1216($table)
C_LONGINT:C283($Progressing; $tableId)
C_TEXT:C284($Language; $search)
C_COLLECTION:C1488($val)
C_COLLECTION:C1488($result)
C_LONGINT:C283($window)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$Language:=Config_getLanguage
$result:=Storage:C1525.objectType.extract("name").orderBy(ck ascending:K85:9)
$ObjectType:=Pop up menu:C542($result.join(";"))-1

If ($ObjectType>0)
	$search:=$result[$ObjectType]
	$val:=Storage:C1525.objectType.query("name =:1"; $search)
	$ObjectType:=Num:C11($val[0].val)
	
	// Initialisation
	C_OBJECT:C1216($param)
	$param:=New object:C1471("title"; "Parsing forms for object type"; "icon"; "icns_structure.png"; "type"; 0)
	QST_progress_start($param)
	$window:=$param.window
	
	BASE_getTablesList(True:C214)
	$Progressing:=Storage:C1525.structureTable.length
	$Progression:=0
	$Pas:=1/($Progressing+1)
	
	ARRAY TEXT:C222($tTxt_objects; 0x0000)
	ARRAY POINTER:C280($tPtr_var; 0x0000)
	ARRAY LONGINT:C221($tLon_pages; 0x0000)
	ARRAY TEXT:C222($TbForms; 0x0000)
	
	C_LONGINT:C283($NbTable; $NbForms)
	C_BOOLEAN:C305($newForm; $NewTable)
	$NbTable:=0
	$NbForms:=0
	$newForm:=False:C215
	$NewTable:=False:C215
	$Composant:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode
	
	$result.clear()
	
	For each ($table; Storage:C1525.structureTable)  // For each table
		$tableId:=$table.id
		$Progression:=$Progression+$pas
		
		$param.value:=$Progression
		$param.content:="Parsing forms from "+$table.name
		CALL FORM:C1391($window; "progressBar_update"; $param)
		
		$Formulare:=""
		CLEAR VARIABLE:C89($TbForms)
		
		If ($table.id>0)
			FORM GET NAMES:C1167(Table:C252($tableId)->; $TbForms; *)
		Else 
			FORM GET NAMES:C1167($TbForms; *)
		End if 
		
		$tableName:=Str_GetTableOrProjectForm($tableId)
		$NewTable:=True:C214
		
		For ($sale; 1; Size of array:C274($TbForms))  // For each form
			
			$Formulare:=$TbForms{$sale}
			$newForm:=True:C214
			FE_getObjectsAndMethods($tableId; $Formulare; ->$tTxt_objects; ->$tPtr_var; ->$tLon_pages)
			
			For ($a; 1; Size of array:C274($tTxt_objects))
				
				ARRAY LONGINT:C221($tabEvenement; 0x0000)
				$objet:=$tTxt_objects{$a}
				
				If (OBJECT Get type:C1300(*; $objet)=$ObjectType)
					OBJECT GET EVENTS:C1238(*; $objet; $tabEvenement)  // récupération des évènements cochés au niveau de l'objet
					$txt:=""
					For ($b; 1; Size of array:C274($tabEvenement))
						$txt:=Choose:C955($b=1; ""; $txt+" - ")+Konstant_getName(2; $tabEvenement{$b})
					End for 
					
					$result.push(New object:C1471("method"; $tableName+$Formulare; "object"; $objet; "type"; $txt; "empty"; ""))
					
					If ($newForm)
						$NbForms:=$NbForms+1
						$newForm:=False:C215
					End if 
					
					If ($NewTable) & (Not:C34($Composant))
						$NbTable:=$NbTable+1
						$NewTable:=False:C215
					End if 
					
				End if 
				
			End for 
			
			FORM UNLOAD:C1299  // Release form from memory
			
		End for 
		
	End for each 
	
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
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table Name\rMethod Path Name\rObject name")
					
				: ($i=2)
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 250)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Object Name")
					
				: ($i=3)
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 400)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Event(s)")
					
				: ($i=4)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
					
			End case 
			
		End for 
		
		LB_setHeights($Listbox_Name; 3; 2)
		
	Else 
		LB_Init_Start($Listbox_Name)
	End if 
	
	ARRAY LONGINT:C221($MyEventsOnLB; 2)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	$MyEventsOnLB{2}:=On Double Clicked:K2:5
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	If ($ObjectType>=0) & ($result.length>0)
		$text:="Search for: "+Storage:C1525.objectType[$ObjectType].name+"\rFound "+String:C10($result.length)+" object(s) in "+String:C10($NbForms)+" form(s) from "+String:C10($NbTable)+" Project/table(s)."
	Else 
		$text:="Nothing found"
	End if 
	
	displayInfo($text)
	KILL WORKER:C1390("QST_Progress")
	
Else 
	
	$text:="No event selected"
	displayInfo($text; "red")
End if 
