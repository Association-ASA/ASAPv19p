//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 21/05/16, 09:08:27
// ----------------------------------------------------
// méthode : SC_list_Relations
// description
// http://forums.4d.fr/Post/FR/17917298/1/17917388#17917388
//
// paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($TbLb_TableName; 0x0000)  // _USER_CONS_COLUMNS.TABLE_NAME
ARRAY TEXT:C222($TbLb_Col1; 0x0000)  // _USER_CONS_COLUMNS.COLUMN_NAME
ARRAY TEXT:C222($TbLb_Col2; 0x0000)  // _USER_CONS_COLUMNS.RELATED_COLUMN_NAME
ARRAY TEXT:C222($TbLb_Object; 0x0000)  // _USER_CONSTRAINTS.RELATED_TABLE_NAME
ARRAY TEXT:C222($TbLb_ObjectType; 0x0000)  // _USER_CONSTRAINTS.CONSTRAINT_TYPE

ARRAY LONGINT:C221($columnFK_al; 0x0000)
ARRAY LONGINT:C221($tableFK_al; 0x0000)
ARRAY LONGINT:C221($columnPK_al; 0x0000)
ARRAY LONGINT:C221($tablePK_al; 0x0000)
ARRAY TEXT:C222($ContrainstTable_at; 0x0000)

C_LONGINT:C283($N)
C_COLLECTION:C1488($result)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)
$result:=New collection:C1472

Begin SQL
	SELECT
	_USER_CONS_COLUMNS.COLUMN_ID,
	_USER_CONS_COLUMNS.TABLE_ID,
	_USER_CONS_COLUMNS.RELATED_COLUMN_ID,
	
	_USER_CONS_COLUMNS.TABLE_NAME,
	_USER_CONS_COLUMNS.COLUMN_NAME,
	_USER_CONS_COLUMNS.RELATED_COLUMN_NAME,
	_USER_CONSTRAINTS.TABLE_NAME,
	_USER_CONSTRAINTS.RELATED_TABLE_NAME,
	
	_USER_CONSTRAINTS.RELATED_TABLE_ID,
	_USER_CONSTRAINTS.CONSTRAINT_TYPE
	
	FROM _USER_CONS_COLUMNS
	JOIN _USER_CONSTRAINTS ON _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
	WHERE (_USER_CONSTRAINTS.CONSTRAINT_TYPE LIKE '%')
	INTO
	:$columnFK_al,/* num champ clé reportée*/
	:$tableFK_al,/* num table clé reportée*/
	:$columnPK_al,/* num champ clé primaire*/
	
	:$TbLb_TableName,
	:$TbLb_Col1,
	:$TbLb_Col2,
	:$ContrainstTable_at,
	:$TbLb_Object,
	
	:$tablePK_al,/* num table clé primaire*/
	:$TbLb_ObjectType /* (P=clé primaire, R=intégrité référentielle - clé étrangère, 4DR=relation 4D)*/
	;
	
End SQL

For ($N; Size of array:C274($TbLb_ObjectType); 1; -1)
	
	Case of 
			
		: ($TbLb_ObjectType{$n}="P")
			$TbLb_ObjectType{$n}:="Primary key"
			
		: ($TbLb_ObjectType{$n}="R")
			$TbLb_ObjectType{$n}:="Referential integrity"
			
		: ($TbLb_ObjectType{$n}="4DR")
			$TbLb_ObjectType{$n}:="4D Relation"
			
	End case 
	
	$result.push(New object:C1471("tablePK"; $TbLb_TableName{$n}; "columnPK"; $TbLb_Col1{$n}; "tableFK"; $TbLb_Object{$n}; "columnFK"; $TbLb_Col2{$n}; "Relation Type"; $TbLb_ObjectType{$n}; "empty"; ""))
End for 

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Primary Table\\(from)")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				
			: ($i=2)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Primary Field\\(from)")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Foreign Table\\(to)")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				
			: ($i=4)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); ">Foreign Field\\(to)")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				
			: ($i=5)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				
			: ($i=6)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 3; 1)
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$txt:=String:C10($result.length)+" Relations & Primary key found."
	$color:="red"
Else 
	$txt:="Search returns no result"
	$color:="blue"
End if 
displayInfo($txt; $color)
