//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 02/05/16, 18:10:28
// ----------------------------------------------------
// méthode : SC_list_Index
// description
// liste l'utilisation des champs indexés dans les recherches, min, max, ...
// ainsi que le nombre d'appel à ces champs
// regarde aussi les champs non indexés utilisés
//
// paramètres
// ----------------------------------------------------

C_COLLECTION:C1488($result)
C_LONGINT:C283($champLong; $champType; $IndexNumber)
C_BOOLEAN:C305($indexis)
C_OBJECT:C1216($Table)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472

For each ($table; Storage:C1525.structureTable)
	
	$tableNum:=$table.id
	If (Is table number valid:C999($tableNum))
		For ($b; 1; Get last field number:C255(Table:C252(Num:C11($tableNum))))  // for each table
			If (Is field number valid:C1000($tableNum; $b))
				GET FIELD PROPERTIES:C258($tableNum; $b; $champType; $champLong; $indexis)
				If ($indexis)
					$IndexNumber:=Num:C11(GetIndexNum(Field:C253($tableNum; $b)))
					$TypeIndex_t:=GetIndexType(Field:C253($tableNum; $b))
					$fieldName:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum; $b)
					
					$result.push(New object:C1471("method"; $IndexNumber; "index Type"; $TypeIndex_t; "table ID"; $tableNum; "field ID"; $b; "field Name"; $fieldName; "empty"; ""))
					
				End if 
			End if 
		End for 
	End if 
End for each 

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $tabPropertyNames{$i}; Align center:K42:3)
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Index ID")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 50)
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 90)
				
			: ($i=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 90)
				
			: ($i=4)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 90)
				
			: ($i=5)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 350)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align default:K42:1)
				
			: ($i=6)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 3; 1)
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
End if 
$txt:="Found "+String:C10($result.length)+" index defined."
displayInfo($txt; "blue")

